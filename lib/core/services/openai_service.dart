import 'dart:convert';
import 'package:http/http.dart' as http;

class OpenAIService {
  // TODO: OPENAI_API_KEY BURAYA EKLENECEK
  // GÜVENLİK NOTU: Gerçek projelerde bu key'i backend'de tutmak en doğrusudur.
  static const String _apiKey =
      'YOUR_API_KEY_HERE';

  static const String _apiUrl = 'https://api.openai.com/v1/chat/completions';

  /// Fotoğrafı Base64 formatında alıp OpenAI'a gönderir
  static Future<Map<String, dynamic>?> identifyPlant(String base64Image, {bool isMushroom = false}) async {
    if (_apiKey == 'BUNU_DEĞİŞTİR' || _apiKey.isEmpty) {
      throw Exception(
        'OpenAI API Key eksik. Lütfen OpenAIService dosyasına ekleyin.',
      );
    }

    try {
      final response = await http.post(
        Uri.parse(_apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_apiKey',
        },
        body: jsonEncode({
          "model": "gpt-4o-mini", // Veya "gpt-4o" kullanabilirsiniz
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
                    "url": "data:image/jpeg;base64,$base64Image",
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

        // Bazen OpenAI markdown olarak ```json ... ``` dönebilir, onu temizliyoruz
        final cleanContent = content
            .toString()
            .replaceAll('```json', '')
            .replaceAll('```', '')
            .trim();

        final Map<String, dynamic> result = jsonDecode(cleanContent);
        return result;
      } else {
        throw Exception(
          'OpenAI Hatası: ${response.statusCode} - ${response.body}',
        );
      }
    } catch (e) {
      print("OpenAI İstek Hatası: $e");
      rethrow;
    }
  }
}
