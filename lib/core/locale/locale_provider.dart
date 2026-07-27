import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LocaleProvider extends ChangeNotifier {
  static const String _prefKey = 'app_locale';

  Locale? _locale;

  Locale? get locale => _locale;
  String? get currentLanguageCode => _locale?.languageCode;

  /// runApp() öncesi çağır — YALNIZCA SharedPreferences'tan okur (hızlı, ~5ms).
  /// Supabase çağrısı YAPILMAZ, böylece ağ beklemesi olmaz.
  Future<void> loadSavedLocale() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final localCode = prefs.getString(_prefKey);
      if (localCode != null && localCode.isNotEmpty) {
        _locale = Locale(localCode);
      }
    } catch (_) {
      // SharedPreferences okunamazsa sistem dili kullanılır
    }
  }

  /// runApp() SONRASI arka planda çağır — Supabase'den locale'i senkronize eder.
  /// Farklı bir değer varsa UI güncellenir.
  Future<void> syncFromSupabase() async {
    try {
      final user = Supabase.instance.client.auth.currentUser;
      if (user == null) return;

      final response = await Supabase.instance.client
          .from('profiles')
          .select('language_code')
          .eq('id', user.id)
          .maybeSingle()
          .timeout(const Duration(seconds: 4));

      final remoteCode = response?['language_code'] as String?;
      if (remoteCode != null && remoteCode.isNotEmpty) {
        if (remoteCode != currentLanguageCode) {
          _locale = Locale(remoteCode);
          notifyListeners();
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString(_prefKey, remoteCode);
        }
      }
    } catch (_) {
      // Supabase erişilemezse lokal cache yeterli
    }
  }

  /// Dili değiştirir. Önce state güncellenir, sonra I/O arka planda yapılır.
  Future<void> setLocale(String? languageCode) async {
    if (languageCode == currentLanguageCode) return;

    _locale = (languageCode != null && languageCode.isNotEmpty)
        ? Locale(languageCode)
        : null;
    notifyListeners();

    // I/O arka planda — UI bloklanmaz
    _persistLocale(languageCode);
  }

  Future<void> _persistLocale(String? languageCode) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      if (languageCode == null || languageCode.isEmpty) {
        await prefs.remove(_prefKey);
      } else {
        await prefs.setString(_prefKey, languageCode);
      }

      final user = Supabase.instance.client.auth.currentUser;
      if (user != null) {
        await Supabase.instance.client
            .from('profiles')
            .upsert({'id': user.id, 'language_code': languageCode ?? ''})
            .timeout(const Duration(seconds: 4));
      }
    } catch (_) {}
  }
}
