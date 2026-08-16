import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../locale/locale_provider.dart';

class BotaniqAiException implements Exception {
  const BotaniqAiException(this.code, {this.status});

  final String code;
  final int? status;

  @override
  String toString() => 'BotaniqAiException($code)';
}

class OpenAIService {
  static const _functionName = 'analyze-plant';

  /// Fotoğrafı merkezi Botaniq AI entegrasyonu üzerinden tanımlar.
  static Future<Map<String, dynamic>?> identifyPlant(
    String base64Image, {
    bool isMushroom = false,
  }) async {
    final localeTag = await _localeTag();
    final prompt = isMushroom
        ? 'Identify the mushroom only from visible evidence. Return JSON with '
              'name, species, description, water_needs, and light_needs. '
              'Clearly express uncertainty and never imply that visual '
              'identification proves edibility.'
        : 'Identify the plant only from visible evidence. Return JSON with '
              'name, species, description, water_needs, '
              'watering_interval_days, and light_needs. Use a positive integer '
              'for watering_interval_days and clearly express uncertainty.';

    try {
      final data = await _invoke({
        'mode': 'identify',
        'image_base64': base64Image,
        'image_mime_type': _imageMimeType(base64Image),
        'prompt': prompt,
        'language_code': localeTag,
      });
      return _resultMap(data);
    } catch (error) {
      debugPrint('Botaniq AI tanımlama hatası: $error');
      rethrow;
    }
  }

  /// Hasta bitki fotoğrafını merkezi Botaniq AI entegrasyonuyla analiz eder.
  static Future<Map<String, dynamic>?> diagnosePlant(
    String base64Image, {
    String? plantName,
  }) async {
    final localeTag = await _localeTag();
    final normalizedName = plantName?.trim() ?? '';
    final plantContext =
        normalizedName.isNotEmpty &&
            ![
              'yeni bitki',
              'bilinmeyen bitki',
              'unknown plant',
            ].contains(normalizedName.toLowerCase())
        ? "The user labels this plant '$plantName'. Preserve that user-entered "
              'label; do not translate or replace it.'
        : 'Assess the plant shown in the photo.';

    try {
      final data = await _invoke({
        'mode': 'diagnose',
        'image_base64': base64Image,
        'image_mime_type': _imageMimeType(base64Image),
        'language_code': localeTag,
        'prompt':
            '$plantContext Identify the plant when the visual evidence is '
            'sufficient. Give a cautious, non-definitive health assessment and '
            'safe care steps. Return JSON with nullable plant_name and species, '
            'localized diagnosis, prescription, care_tips and recovery_time, '
            'plus urgency_code as exactly low, medium, or critical. State when '
            'professional or local expert assessment is appropriate.',
      });
      return _resultMap(data);
    } catch (error) {
      debugPrint('Botaniq AI teşhis hatası: $error');
      rethrow;
    }
  }

  /// Sohbet geçmişini merkezi Botaniq AI entegrasyonuna gönderir.
  static Future<String?> chatWithDoctor(
    List<Map<String, dynamic>> messages,
  ) async {
    final localeTag = await _localeTag();
    final sanitizedMessages = messages.map((message) {
      final sanitized = Map<String, dynamic>.from(message);
      if (sanitized['image_url'] == 'photo') {
        sanitized.remove('image_url');
      }
      return sanitized;
    }).toList();

    try {
      final data = await _invoke({
        'mode': 'chat',
        'messages': sanitizedMessages,
        'language_code': localeTag,
      });
      return data['reply']?.toString();
    } catch (error) {
      debugPrint('Botaniq AI sohbet hatası: $error');
      rethrow;
    }
  }

  /// Bitki adı için detaylı bakım bilgisini merkezi entegrasyondan getirir.
  static Future<Map<String, dynamic>?> getPlantDetailsByName(
    String plantName,
  ) async {
    final localeTag = await _localeTag();
    try {
      final data = await _invoke({
        'mode': 'details',
        'language_code': localeTag,
        'prompt':
            "Provide evidence-based care information for '$plantName'. "
            'Return only a JSON object containing description, ideal_climate, humidity, '
            'temperature_range, watering_protocol, feeding_protocol, '
            'soil_protocol, care_protocol, toxicity, difficulty, environment, '
            'and sunlight. Express uncertainty instead of inventing details.',
      });
      return _resultMap(data);
    } catch (error) {
      debugPrint('Botaniq AI bitki detayları hatası: $error');
      return null;
    }
  }

  static Future<Map<String, dynamic>?> localizePlantDetails(
    Map<String, dynamic> details,
  ) async {
    final localeTag = await _localeTag();
    const translatableKeys = {
      'description',
      'difficulty',
      'toxicity',
      'environment',
      'sunlight',
      'light_needs',
      'ideal_climate',
      'humidity',
      'temperature_range',
      'watering_protocol',
      'water_needs',
      'soil_protocol',
      'feeding_protocol',
      'care_protocol',
    };
    final content = <String, dynamic>{};
    for (final entry in details.entries) {
      if (translatableKeys.contains(entry.key) && entry.value is String) {
        final value = (entry.value as String).trim();
        if (value.isNotEmpty) content[entry.key] = value;
      }
    }
    if (content.isEmpty) return null;

    try {
      final data = await _invoke({
        'mode': 'localize',
        'language_code': localeTag,
        'content': content,
      });
      return _resultMap(data);
    } catch (error) {
      debugPrint('Botaniq bitki içeriği yerelleştirme hatası: $error');
      return null;
    }
  }

  static Future<Map<String, dynamic>> _invoke(Map<String, dynamic> body) async {
    late final FunctionResponse response;
    try {
      response = await Supabase.instance.client.functions.invoke(
        _functionName,
        body: body,
      );
    } on FunctionException catch (error) {
      if (error.status == 404) {
        throw BotaniqAiException('function_not_deployed', status: error.status);
      }
      if (error.status == 401 || error.status == 403) {
        throw BotaniqAiException(
          'authentication_required',
          status: error.status,
        );
      }

      final details = error.details;
      final code = details is Map ? details['error_code']?.toString() : null;
      throw BotaniqAiException(
        code?.isNotEmpty == true ? code! : 'service_unavailable',
        status: error.status,
      );
    }

    final rawData = response.data;
    if (rawData is! Map) {
      throw const BotaniqAiException('invalid_response');
    }

    final data = Map<String, dynamic>.from(rawData);
    final errorCode = data['error_code'] ?? data['error'];
    if (response.status < 200 || response.status >= 300 || errorCode != null) {
      throw BotaniqAiException(
        errorCode?.toString() ?? 'request_failed',
        status: response.status,
      );
    }
    return data;
  }

  static Map<String, dynamic>? _resultMap(Map<String, dynamic> data) {
    final result = data['result'];
    if (result is Map) {
      return Map<String, dynamic>.from(result)
        ..['_response_locale'] = data['response_locale']
        ..['_fallback_used'] = data['fallback_used'] == true;
    }
    return null;
  }

  static String _imageMimeType(String base64Image) {
    return base64Image.startsWith('iVBORw') ? 'png' : 'jpeg';
  }

  static Future<String> _localeTag() => LocaleProvider.preferredLocaleTag();
}
