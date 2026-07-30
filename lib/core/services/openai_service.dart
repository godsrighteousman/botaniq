import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class OpenAIService {
  static const _functionName = 'analyze-plant';

  /// Fotoğrafı merkezi Botaniq AI entegrasyonu üzerinden tanımlar.
  static Future<Map<String, dynamic>?> identifyPlant(
    String base64Image, {
    bool isMushroom = false,
  }) async {
    final languageCode = await _languageCode();
    final language = languageCode == 'en' ? 'English' : 'Türkçe';
    final prompt = isMushroom
        ? 'Bu fotoğraftaki mantarın tam adını, '
              'türünü ve temel özelliklerini/yenilebilirliğini kısa bir özet '
              'olarak sadece şu JSON formatında dön: '
              '{"name":"Mantar Adı","species":"Bilimsel Türü",'
              '"description":"Kısa bilgi","water_needs":"Yetişme ortamı",'
              '"light_needs":"Toksisite/Yenilebilirlik"}. Yanıt dili: $language.'
        : 'Bu fotoğraftaki bitkinin tam adını, '
              'türünü ve temel bakım ihtiyaçlarını sadece şu JSON formatında '
              'dön: {"name":"Bitki Adı","species":"Bilimsel Türü",'
              '"description":"Kısa bilgi","water_needs":"Sulama ihtiyacı",'
              '"watering_interval_days":7,"light_needs":"Işık ihtiyacı"}. '
              'watering_interval_days değerini bu türe uygun pozitif tam sayı '
              'olarak ver; emin değilsen uydurma kesinlik kullanma. '
              'Yanıt dili: $language.';

    try {
      final data = await _invoke({
        'mode': 'identify',
        'image_base64': base64Image,
        'image_mime_type': _imageMimeType(base64Image),
        'prompt': prompt,
        'language_code': languageCode,
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
    final languageCode = await _languageCode();
    final normalizedName = plantName?.trim() ?? '';
    final plantContext =
        normalizedName.isNotEmpty &&
            ![
              'yeni bitki',
              'bilinmeyen bitki',
              'unknown plant',
            ].contains(normalizedName.toLowerCase())
        ? "Bu '$plantName' bitkisinin fotoğrafını analiz et."
        : 'Bu fotoğraftaki hasta bitkiyi analiz et.';

    try {
      final data = await _invoke({
        'mode': 'diagnose',
        'image_base64': base64Image,
        'image_mime_type': _imageMimeType(base64Image),
        'language_code': languageCode,
        'prompt':
            '$plantContext Önce bitkiyi mümkün olan en doğru ortak adı ve '
            'bilimsel türüyle tanımla; emin değilsen bunu açıkça belirt ve '
            'uydurma isim kullanma. Hastalığını teşhis et ve tedavi önerisini '
            'sadece şu JSON formatında dön: '
            '{"plant_name":"Bitkinin ortak adı veya Tanımlanamayan Bitki",'
            '"species":"Bilimsel tür veya Belirsiz",'
            '"diagnosis":"Teşhis ve sorun",'
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
    final languageCode = await _languageCode();
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
        'language_code': languageCode,
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
    final languageCode = await _languageCode();
    final language = languageCode == 'en' ? 'English' : 'Türkçe';
    try {
      final data = await _invoke({
        'mode': 'details',
        'language_code': languageCode,
        'prompt':
            "Bana '$plantName' adlı bitki/çiçek hakkında detaylı bilgi ver. "
            'Şunları içersin: description, ideal_climate, humidity, '
            'temperature_range, watering_protocol, feeding_protocol, '
            'soil_protocol, care_protocol, toxicity, difficulty, environment, '
            'sunlight. Yanıtı yalnızca JSON objesi olarak $language dilinde dön.',
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
    final languageCode = await _languageCode();
    const translatableKeys = {
      'name',
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
        'language_code': languageCode,
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

  static Future<String> _languageCode() async {
    try {
      final preferences = await SharedPreferences.getInstance();
      final saved = preferences.getString('app_locale');
      if (saved == 'en' || saved == 'tr') return saved!;
    } catch (_) {}
    final platformCode =
        WidgetsBinding.instance.platformDispatcher.locale.languageCode;
    return platformCode == 'en' ? 'en' : 'tr';
  }
}
