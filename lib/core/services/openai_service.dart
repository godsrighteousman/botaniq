import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class OpenAIService {
  static const _functionName = 'analyze-plant';

  /// Fotoğrafı merkezi Botaniq AI entegrasyonu üzerinden tanımlar.
  static Future<Map<String, dynamic>?> identifyPlant(
    String base64Image, {
    bool isMushroom = false,
  }) async {
    final prompt = isMushroom
        ? 'Sen uzman bir mikologsun. Bu fotoğraftaki mantarın tam adını, '
              'türünü ve temel özelliklerini/yenilebilirliğini kısa bir özet '
              'olarak sadece şu JSON formatında dön: '
              '{"name":"Mantar Adı","species":"Bilimsel Türü",'
              '"description":"Kısa bilgi","water_needs":"Nerede yetişir?",'
              '"light_needs":"Zehirli mi/Yenilebilir mi?"}'
        : 'Sen uzman bir botanikçisin. Bu fotoğraftaki bitkinin tam adını, '
              'türünü ve temel bakım ihtiyaçlarını sadece şu JSON formatında '
              'dön: {"name":"Bitki Adı","species":"Bilimsel Türü",'
              '"description":"Kısa bilgi","water_needs":"Sulama ihtiyacı",'
              '"light_needs":"Işık ihtiyacı"}';

    try {
      final data = await _invoke({
        'mode': 'identify',
        'image_base64': base64Image,
        'image_mime_type': _imageMimeType(base64Image),
        'prompt': prompt,
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
    final plantContext = plantName != null && plantName != 'Yeni Bitki'
        ? "Bu '$plantName' bitkisinin fotoğrafını analiz et."
        : 'Bu fotoğraftaki hasta bitkiyi analiz et.';

    try {
      final data = await _invoke({
        'mode': 'diagnose',
        'image_base64': base64Image,
        'image_mime_type': _imageMimeType(base64Image),
        'prompt':
            '$plantContext Hastalığını teşhis et ve tedavi önerisini sadece '
            'şu JSON formatında dön: {"diagnosis":"Teşhis ve sorun",'
            '"prescription":"Tedavi adımları","urgency":"Düşük/Orta/Kritik",'
            '"care_tips":["İpucu 1","İpucu 2"],'
            '"recovery_time":"Tahmini iyileşme süresi"}',
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
    try {
      final data = await _invoke({
        'mode': 'details',
        'prompt':
            "Bana '$plantName' adlı bitki/çiçek hakkında detaylı bilgi ver. "
            'Şunları içersin: description, ideal_climate, humidity, '
            'temperature_range, watering_protocol, feeding_protocol, '
            'toxicity, difficulty, environment, sunlight. Yanıtı yalnızca '
            'JSON objesi olarak ve Türkçe dön.',
      });
      return _resultMap(data);
    } catch (error) {
      debugPrint('Botaniq AI bitki detayları hatası: $error');
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
        throw Exception(
          'Botaniq AI servisi Supabase projesinde bulunamadı. '
          'analyze-plant Edge Function deploy edilmelidir.',
        );
      }
      if (error.status == 401 || error.status == 403) {
        throw Exception(
          'Botaniq AI oturumu doğrulanamadı. Lütfen tekrar giriş yapın.',
        );
      }

      final details = error.details;
      final message = details is Map
          ? details['error']?.toString()
          : details?.toString();
      throw Exception(
        message != null && message.isNotEmpty
            ? message
            : 'Botaniq AI servisine ulaşılamadı (${error.status}).',
      );
    }

    final rawData = response.data;
    if (rawData is! Map) {
      throw const FormatException('Botaniq AI geçersiz yanıt döndürdü.');
    }

    final data = Map<String, dynamic>.from(rawData);
    final error = data['error'];
    if (response.status < 200 || response.status >= 300 || error != null) {
      throw Exception(error?.toString() ?? 'Botaniq AI isteği başarısız oldu.');
    }
    return data;
  }

  static Map<String, dynamic>? _resultMap(Map<String, dynamic> data) {
    final result = data['result'];
    if (result is Map) {
      return Map<String, dynamic>.from(result);
    }
    return null;
  }

  static String _imageMimeType(String base64Image) {
    return base64Image.startsWith('iVBORw') ? 'png' : 'jpeg';
  }
}
