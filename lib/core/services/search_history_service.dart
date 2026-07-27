import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

/// Aratılan veya taranan bitkilerin gerçek geçmiş kaydını yöneten servis.
class SearchHistoryService {
  static const String _key = 'plant_search_history_v2';

  /// Yeni arama/tarama kaydı ekler
  static Future<void> addRecord(Map<String, dynamic> record) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final List<Map<String, dynamic>> history = await getHistory();

      final Map<String, dynamic> item = Map<String, dynamic>.from(record);
      item['id'] ??= DateTime.now().millisecondsSinceEpoch.toString();
      item['searched_at'] ??= DateTime.now().toIso8601String();

      // Aynı isimde varsa eskiyi çıkarıp en başa taşıyalım
      history.removeWhere(
        (h) => (h['name'] ?? '').toString().toLowerCase() ==
            (item['name'] ?? '').toString().toLowerCase(),
      );

      history.insert(0, item);

      // Maksimum 50 kayıt tutalım
      if (history.length > 50) {
        history.removeRange(50, history.length);
      }

      final List<String> encoded = history.map((e) => jsonEncode(e)).toList();
      await prefs.setStringList(_key, encoded);
    } catch (_) {}
  }

  /// Tüm arama geçmişini getirir (Gerçek kayıt yoksa boş liste döner)
  static Future<List<Map<String, dynamic>>> getHistory() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final List<String>? current = prefs.getStringList(_key);

      if (current == null || current.isEmpty) {
        return [];
      }

      final list = current
          .map((s) => Map<String, dynamic>.from(jsonDecode(s)))
          .where((item) => !(item['id']?.toString().startsWith('demo_') ?? false))
          .toList();

      return list;
    } catch (_) {
      return [];
    }
  }

  /// Geçmişi temizler
  static Future<void> clearHistory() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList(_key, []);
    } catch (_) {}
  }
}
