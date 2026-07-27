import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class OpenAIService {
  static const String _defaultApiKey = String.fromEnvironment('OPENAI_API_KEY');
  static const String _apiUrl = 'https://api.openai.com/v1/chat/completions';

  /// Fotoğrafı Base64 formatında alıp tanımlama yapar
  static Future<Map<String, dynamic>?> identifyPlant(
    String base64Image, {
    bool isMushroom = false,
  }) async {
    // Settings'ten özel key girilmişse onu kullan, yoksa defaultu kullan
    String apiKey = _defaultApiKey;
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedKey = prefs.getString('openai_api_key');
      if (savedKey != null &&
          savedKey.trim().isNotEmpty &&
          savedKey.trim().startsWith('sk-')) {
        apiKey = savedKey.trim();
      }
    } catch (e) {
      debugPrint("SharedPreferences okuma hatası: $e");
    }

    debugPrint("OpenAI isteği gönderiliyor (Tanımlama)... Model: gpt-4o-mini");

    final String mimeType = base64Image.startsWith('iVBORw') ? 'png' : 'jpeg';

    try {
      final response = await http.post(
        Uri.parse(_apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey',
        },
        body: jsonEncode({
          "model": "gpt-4o-mini",
          "messages": [
            {
              "role": "user",
              "content": [
                {
                  "type": "text",
                  "text": isMushroom
                      ? "Sen uzman bir mikologsun. Bu fotoğraftaki mantarın tam adını, türünü ve temel özelliklerini/yenilebilirliğini (zehirli mi, nerede yetişir, yenilebilir mi vs.) kısa bir özet olarak JSON formatında dön. JSON formatı şöyle olsun:\n{\n  \"name\": \"Mantar Adı\",\n  \"species\": \"Bilimsel Türü\",\n  \"description\": \"Mantar hakkında kısa bilgi\",\n  \"water_needs\": \"Nerede yetişir?\",\n  \"light_needs\": \"Zehirli mi/Yenilebilir mi?\"\n}"
                      : "Sen uzman bir botanikçisin. Bu fotoğraftaki bitkinin tam adını, türünü ve temel bakım ihtiyaçlarını (ışık, sulama, sıcaklık) kısa bir özet olarak JSON formatında dön. JSON formatı şöyle olsun:\n{\n  \"name\": \"Bitki Adı\",\n  \"species\": \"Bilimsel Türü\",\n  \"description\": \"Bitki hakkında kısa bilgi\",\n  \"water_needs\": \"Sulama ihtiyacı\",\n  \"light_needs\": \"Işık ihtiyacı\"\n}",
                },
                {
                  "type": "image_url",
                  "image_url": {
                    "url": "data:image/$mimeType;base64,$base64Image",
                    "detail": "low",
                  },
                },
              ],
            },
          ],
          "max_tokens": 500,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(utf8.decode(response.bodyBytes));
        final content = data['choices'][0]['message']['content'];
        final cleanContent = content
            .toString()
            .replaceAll('```json', '')
            .replaceAll('```', '')
            .trim();

        return Map<String, dynamic>.from(jsonDecode(cleanContent));
      } else {
        throw Exception(
          'OpenAI Hatası: ${response.statusCode} - ${response.body}',
        );
      }
    } catch (e) {
      debugPrint("OpenAI İstek Hatası: $e");
      rethrow;
    }
  }

  /// Hasta bitki fotoğrafını alıp teşhis ve tedavi reçetesi çıkarır
  static Future<Map<String, dynamic>?> diagnosePlant(
    String base64Image, {
    String? plantName,
  }) async {
    String apiKey = _defaultApiKey;
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedKey = prefs.getString('openai_api_key');
      if (savedKey != null &&
          savedKey.trim().isNotEmpty &&
          savedKey.trim().startsWith('sk-')) {
        apiKey = savedKey.trim();
      }
    } catch (e) {
      debugPrint("SharedPreferences okuma hatası: $e");
    }

    debugPrint("OpenAI isteği gönderiliyor (Teşhis)... Model: gpt-4o-mini");

    final String mimeType = base64Image.startsWith('iVBORw') ? 'png' : 'jpeg';
    final plantContext = plantName != null && plantName != 'Yeni Bitki'
        ? "Bu '$plantName' bitkisinin fotoğrafını analiz et."
        : "Bu fotoğraftaki hasta bitkiyi analiz et.";

    try {
      final response = await http.post(
        Uri.parse(_apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey',
        },
        body: jsonEncode({
          "model": "gpt-4o-mini",
          "messages": [
            {
              "role": "system",
              "content":
                  "Sen uzman bir bitki doktoru ve botanikçisin. Fotoğraftaki hasta bitkiyi analiz edip teşhis koymalısın. Sadece aşağıdaki JSON şablonunda cevap vermelisin ve markdown kod blokları kullanmamalısın.",
            },
            {
              "role": "user",
              "content": [
                {
                  "type": "text",
                  "text":
                      "$plantContext Hastalığını teşhis et ve tedavi önerisi sun. Yanıtını sadece şu JSON formatında dön:\n{\n  \"diagnosis\": \"Teşhis ve sorun açıklaması\",\n  \"prescription\": \"Tedavi için yapılması gereken reçete adımları\",\n  \"urgency\": \"Düşük\" veya \"Orta\" veya \"Kritik\",\n  \"care_tips\": [\"Bakım ipucu 1\", \"Bakım ipucu 2\"],\n  \"recovery_time\": \"Tahmini iyileşme süresi (örn: 2-3 hafta)\"\n}",
                },
                {
                  "type": "image_url",
                  "image_url": {
                    "url": "data:image/$mimeType;base64,$base64Image",
                    "detail": "low",
                  },
                },
              ],
            },
          ],
          "max_tokens": 800,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(utf8.decode(response.bodyBytes));
        final content = data['choices'][0]['message']['content'];
        final cleanContent = content
            .toString()
            .replaceAll('```json', '')
            .replaceAll('```', '')
            .trim();

        return Map<String, dynamic>.from(jsonDecode(cleanContent));
      } else {
        throw Exception(
          'OpenAI Hatası: ${response.statusCode} - ${response.body}',
        );
      }
    } catch (e) {
      debugPrint("OpenAI Teşhis Hatası: $e");
      rethrow;
    }
  }

  /// Sohbet geçmişi ile doktora soru sorar
  static Future<String?> chatWithDoctor(
    List<Map<String, dynamic>> messages,
  ) async {
    String apiKey = _defaultApiKey;
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedKey = prefs.getString('openai_api_key');
      if (savedKey != null &&
          savedKey.trim().isNotEmpty &&
          savedKey.trim().startsWith('sk-')) {
        apiKey = savedKey.trim();
      }
    } catch (e) {
      debugPrint("SharedPreferences okuma hatası: $e");
    }

    debugPrint("OpenAI sohbet isteği gönderiliyor... Model: gpt-4o-mini");

    // Mesajları OpenAI API formatına dönüştür
    final apiMessages = [
      {
        "role": "system",
        "content":
            "Sen uzman bir bitki doktoru ve botanikçisin. Kullanıcının bitki sağlığı, hastalıkları ve tedavisi hakkındaki sorularını yanıtla. Yanıtların Türkçe, samimi ve son derece pratik reçete çözümleri içersin.",
      },
      ...messages.map((m) {
        final role = m['role'] == 'user' ? 'user' : 'assistant';
        final content = m['content'] ?? '';
        final imageUrl = m['image_url'];

        if (imageUrl != null && imageUrl != 'photo') {
          return {
            "role": role,
            "content": [
              {"type": "text", "text": content},
              {
                "type": "image_url",
                "image_url": {"url": imageUrl, "detail": "low"},
              },
            ],
          };
        }
        return {"role": role, "content": content};
      }),
    ];

    try {
      final response = await http.post(
        Uri.parse(_apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey',
        },
        body: jsonEncode({
          "model": "gpt-4o-mini",
          "messages": apiMessages,
          "max_tokens": 1000,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(utf8.decode(response.bodyBytes));
        return data['choices'][0]['message']['content'] as String;
      } else {
        throw Exception(
          'OpenAI Hatası: ${response.statusCode} - ${response.body}',
        );
      }
    } catch (e) {
      debugPrint("OpenAI Sohbet Hatası: $e");
      rethrow;
    }
  }

  /// Bitki ismi verildiğinde detaylı bakım bilgilerini getirir
  static Future<Map<String, dynamic>?> getPlantDetailsByName(
    String plantName,
  ) async {
    String apiKey = _defaultApiKey;
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedKey = prefs.getString('openai_api_key');
      if (savedKey != null &&
          savedKey.trim().isNotEmpty &&
          savedKey.trim().startsWith('sk-')) {
        apiKey = savedKey.trim();
      }
    } catch (e) {
      debugPrint("SharedPreferences okuma hatası: $e");
    }

    try {
      final response = await http.post(
        Uri.parse(_apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey',
        },
        body: jsonEncode({
          "model": "gpt-4o-mini",
          "messages": [
            {
              "role": "system",
              "content":
                  "Sen uzman bir botanikçisin ve bitki detayları sağlayan bir API'sin. Sadece JSON formatında cevap vermelisin.",
            },
            {
              "role": "user",
              "content":
                  "Bana '$plantName' adlı bitki/çiçek hakkında detaylı bilgi ver. Şunları içersin: description, ideal_climate, humidity, temperature_range, watering_protocol, feeding_protocol, toxicity, difficulty, environment, sunlight. Lütfen yanıtını sadece bir JSON objesi olarak dön ve markdown kullanma. Çıktı dili Türkçe olsun.",
            },
          ],
          "max_tokens": 800,
          "temperature": 0.3,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(utf8.decode(response.bodyBytes));
        final content = data['choices'][0]['message']['content'];
        final cleanContent = content
            .toString()
            .replaceAll('```json', '')
            .replaceAll('```', '')
            .trim();
        return Map<String, dynamic>.from(jsonDecode(cleanContent));
      }
    } catch (e) {
      debugPrint("OpenAI AI Plant Details fetch error: $e");
    }
    return null;
  }
}
