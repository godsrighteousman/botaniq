import 'package:supabase_flutter/supabase_flutter.dart';

/// Keeps the clinic record and the matching garden plant in sync.
class SickPlantService {
  SickPlantService._();

  static SupabaseClient get _client => Supabase.instance.client;

  static String normalizeUrgency(Object? value) {
    final urgency = (value ?? '').toString().trim().toLowerCase();
    if (urgency.contains('krit') ||
        urgency.contains('crit') ||
        urgency.contains('yüksek') ||
        urgency.contains('yuksek') ||
        urgency.contains('high') ||
        urgency.contains('urgent')) {
      return 'Kritik';
    }
    if (urgency.contains('düş') ||
        urgency.contains('dus') ||
        urgency.contains('low')) {
      return 'Düşük';
    }
    return 'Orta';
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
    final payload = <String, dynamic>{
      'user_id': user.id,
      'name': plantName.trim().isEmpty ? 'Bilinmeyen Bitki' : plantName.trim(),
      'diagnosis': diagnosis,
      'prescription': prescription,
      'urgency': normalizeUrgency(urgency),
      'recovery_progress': 0.0,
      'status': 'active',
      'updated_at': DateTime.now().toUtc().toIso8601String(),
      if (normalizedSpecies != null) 'species': normalizedSpecies,
      if (normalizedPlantId != null) 'plant_id': normalizedPlantId,
      if (normalizedImageUrl != null) 'image_url': normalizedImageUrl,
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

    final Map<String, dynamic> record;
    if (existing != null) {
      record = await _client
          .from('sick_plants')
          .update(payload)
          .eq('id', existing['id'])
          .select()
          .single();
    } else {
      record = await _client
          .from('sick_plants')
          .insert(payload)
          .select()
          .single();
    }

    if (normalizedPlantId != null) {
      await _client
          .from('plants')
          .update({'health_status': 'Sick'})
          .eq('id', normalizedPlantId)
          .eq('user_id', user.id);
    }

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

    if (plantId == null) return;

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
  }

  static String? _nonEmpty(String? value) {
    final trimmed = value?.trim();
    return trimmed == null || trimmed.isEmpty ? null : trimmed;
  }
}
