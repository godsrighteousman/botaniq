import 'package:supabase_flutter/supabase_flutter.dart';

import '../locale/locale_provider.dart';
import 'care_notification_service.dart';

/// Keeps the clinic record and the matching garden plant in sync.
class SickPlantService {
  SickPlantService._();

  static SupabaseClient get _client => Supabase.instance.client;

  static String urgencyCode(Object? value) {
    final urgency = (value ?? '').toString().trim().toLowerCase();
    if (urgency == 'critical' ||
        urgency.contains('krit') ||
        urgency.contains('crit') ||
        urgency.contains('yüksek') ||
        urgency.contains('yuksek') ||
        urgency.contains('high') ||
        urgency.contains('urgent')) {
      return 'critical';
    }
    if (urgency == 'low' ||
        urgency.contains('düş') ||
        urgency.contains('dus') ||
        urgency.contains('low')) {
      return 'low';
    }
    return 'medium';
  }

  /// Legacy display value retained for older database constraints/clients.
  static String normalizeUrgency(Object? value) {
    return switch (urgencyCode(value)) {
      'critical' => 'Kritik',
      'low' => 'Düşük',
      _ => 'Orta',
    };
  }

  static Future<Map<String, dynamic>> saveDiagnosis({
    required String plantName,
    required String diagnosis,
    required String prescription,
    required Object? urgency,
    String? species,
    String? plantId,
    String? imageUrl,
  }) async {
    final user = _client.auth.currentUser;
    if (user == null) {
      throw AuthException('Hasta bitki kaydı için oturum gerekli.');
    }

    final normalizedPlantId = _nonEmpty(plantId);
    final normalizedImageUrl = _nonEmpty(imageUrl);
    final normalizedSpecies = _nonEmpty(species);
    final localeTag = await LocaleProvider.preferredLocaleTag();
    final stableUrgency = urgencyCode(urgency);
    final payload = <String, dynamic>{
      'user_id': user.id,
      'name': plantName.trim().isEmpty ? 'Bilinmeyen Bitki' : plantName.trim(),
      'diagnosis': diagnosis,
      'prescription': prescription,
      'urgency': normalizeUrgency(stableUrgency),
      'urgency_code': stableUrgency,
      'diagnosis_locale': localeTag,
      'recovery_progress': 0.0,
      'status': 'active',
      'updated_at': DateTime.now().toUtc().toIso8601String(),
      'species': ?normalizedSpecies,
      'plant_id': ?normalizedPlantId,
      'image_url': ?normalizedImageUrl,
    };

    Map<String, dynamic>? existing;
    if (normalizedPlantId != null) {
      existing = await _client
          .from('sick_plants')
          .select('id')
          .eq('user_id', user.id)
          .eq('plant_id', normalizedPlantId)
          .eq('status', 'active')
          .order('created_at', ascending: false)
          .limit(1)
          .maybeSingle();
    }

    Future<Map<String, dynamic>> persist(Map<String, dynamic> values) async {
      if (existing != null) {
        return _client
            .from('sick_plants')
            .update(values)
            .eq('id', existing['id'])
            .select()
            .single();
      }
      return _client.from('sick_plants').insert(values).select().single();
    }

    Map<String, dynamic> record;
    try {
      record = await persist(payload);
    } on PostgrestException catch (error) {
      final schemaIsOlder =
          error.code == '42703' ||
          error.code == 'PGRST204' ||
          error.message.contains('urgency_code') ||
          error.message.contains('diagnosis_locale');
      if (!schemaIsOlder) rethrow;
      final legacyPayload = Map<String, dynamic>.from(payload)
        ..remove('urgency_code')
        ..remove('diagnosis_locale');
      record = await persist(legacyPayload);
    }

    if (normalizedPlantId != null) {
      await _client
          .from('plants')
          .update({'health_status': 'Sick'})
          .eq('id', normalizedPlantId)
          .eq('user_id', user.id);
    }

    await CareNotificationService.instance.refreshSchedules();
    return record;
  }

  static Future<void> markRecovered(String sickPlantId) async {
    final user = _client.auth.currentUser;
    if (user == null) {
      throw AuthException('İyileşme kaydı için oturum gerekli.');
    }

    final record = await _client
        .from('sick_plants')
        .select('plant_id')
        .eq('id', sickPlantId)
        .eq('user_id', user.id)
        .single();
    final plantId = _nonEmpty(record['plant_id']?.toString());

    await _client
        .from('sick_plants')
        .update({
          'status': 'recovered',
          'recovery_progress': 1.0,
          'updated_at': DateTime.now().toUtc().toIso8601String(),
        })
        .eq('id', sickPlantId)
        .eq('user_id', user.id);

    if (plantId == null) {
      await CareNotificationService.instance.refreshSchedules();
      return;
    }

    final otherActiveRecords = await _client
        .from('sick_plants')
        .select('id')
        .eq('user_id', user.id)
        .eq('plant_id', plantId)
        .eq('status', 'active')
        .neq('id', sickPlantId)
        .limit(1);

    if (otherActiveRecords.isEmpty) {
      await _client
          .from('plants')
          .update({'health_status': 'Healthy'})
          .eq('id', plantId)
          .eq('user_id', user.id);
    }
    await CareNotificationService.instance.refreshSchedules();
  }

  static String? _nonEmpty(String? value) {
    final trimmed = value?.trim();
    return trimmed == null || trimmed.isEmpty ? null : trimmed;
  }
}
