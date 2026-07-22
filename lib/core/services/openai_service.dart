import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class OpenAIService {
  // Gerçek API key — SharedPreferences'tan override edilebilir
  static const String _defaultApiKey =
      '';
  static const String _apiUrl = 'https://api.openai.com/v1/chat/completions';

  /// Fotoğrafı Base64 formatında alıp OpenAI'a gönderir
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

    debugPrint("OpenAI isteği gönderiliyor... Model: gpt-4o-mini");

    // PNG veya JPEG formatına göre base64 önekini belirle (PNG başlığı: iVBORw)
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

      debugPrint("OpenAI yanıt kodu: ${response.statusCode}");

      if (response.statusCode == 200) {
        final data = jsonDecode(utf8.decode(response.bodyBytes));
        final content = data['choices'][0]['message']['content'];

        // Bazen OpenAI markdown olarak ```json ... ``` dönebilir, onu temizliyoruz
        final cleanContent = content
            .toString()
            .replaceAll('```json', '')
            .replaceAll('```', '')
            .trim();

        debugPrint("OpenAI sonucu: $cleanContent");
        final Map<String, dynamic> result = jsonDecode(cleanContent);
        return result;
      } else {
        debugPrint("OpenAI Hata gövdesi: ${response.body}");
        throw Exception(
          'OpenAI Hatası: ${response.statusCode} - ${response.body}',
        );
      }
    } catch (e) {
      debugPrint("OpenAI İstek Hatası: $e");
      rethrow;
    }
  }
}
