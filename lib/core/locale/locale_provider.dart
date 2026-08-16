import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'supported_app_locale.dart';

enum AppThemePreference { system, light, dark }

enum MeasurementSystemPreference { system, metric, imperial }

class LocaleProvider extends ChangeNotifier {
  static const String prefKey = 'app_locale';
  static const String _prefModeKey = 'app_locale_mode';
  static const String _initialSelectionKey =
      'app_initial_language_selection_completed';
  static const String _themePreferenceKey = 'settings_theme_mode';
  static const String _legacyDarkModeKey = 'settings_dark_mode';
  static const String _measurementPreferenceKey = 'settings_measurement_system';
  static const String _legacyMetricSystemKey = 'settings_metric_system';
  static const String _timezoneKey = 'settings_timezone';
  static const String _preferencesUpdatedAtKey =
      'settings_preferences_updated_at';

  Locale? _locale;
  Locale _recommendedLocale = SupportedAppLocales.fallback;
  bool _hasCompletedInitialSelection = false;
  AppThemePreference _themePreference = AppThemePreference.system;
  MeasurementSystemPreference _measurementPreference =
      MeasurementSystemPreference.system;
  String _timezone = 'UTC';
  StreamSubscription<AuthState>? _authSubscription;

  Locale? get locale => _locale;
  String? get currentLanguageCode => _locale?.languageCode;
  String? get currentLocaleTag =>
      _locale == null ? null : SupportedAppLocales.tagFor(_locale!);
  Locale get recommendedLocale => _recommendedLocale;
  bool get hasCompletedInitialSelection => _hasCompletedInitialSelection;
  AppThemePreference get themePreference => _themePreference;
  ThemeMode get themeMode => switch (_themePreference) {
    AppThemePreference.system => ThemeMode.system,
    AppThemePreference.light => ThemeMode.light,
    AppThemePreference.dark => ThemeMode.dark,
  };
  MeasurementSystemPreference get measurementPreference =>
      _measurementPreference;
  String get timezone => _timezone;

  String get effectiveLocaleTag {
    final selected = _locale;
    if (selected != null) return SupportedAppLocales.tagFor(selected);
    return SupportedAppLocales.tagFor(
      WidgetsBinding.instance.platformDispatcher.locale,
    );
  }

  /// runApp() öncesi çağır — YALNIZCA SharedPreferences'tan okur (hızlı, ~5ms).
  /// Supabase çağrısı YAPILMAZ, böylece ağ beklemesi olmaz.
  Future<void> loadSavedLocale() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      // Older builds briefly stored a user-supplied AI key on device. The AI
      // integration is server-side now, so remove that legacy secret.
      await prefs.remove('openai_api_key');
      _recommendedLocale = SupportedAppLocales.byLocale(
        WidgetsBinding.instance.platformDispatcher.locale,
      ).locale;
      final localTag = prefs.getString(prefKey);
      final mode = prefs.getString(_prefModeKey);
      if (mode == 'system') {
        _locale = null;
      } else if (SupportedAppLocales.isSupportedTag(localTag)) {
        _locale = SupportedAppLocales.parse(localTag);
      } else {
        _locale = _recommendedLocale;
      }

      // A saved locale from an earlier Botaniq version is already an explicit
      // user choice and must not send an existing user through the new gate.
      _hasCompletedInitialSelection =
          prefs.getBool(_initialSelectionKey) ??
          (mode == 'system' || SupportedAppLocales.isSupportedTag(localTag));

      _themePreference = _parseThemePreference(
        prefs.getString(_themePreferenceKey),
        legacyValue: prefs.getBool(_legacyDarkModeKey),
      );
      _measurementPreference = _parseMeasurementPreference(
        prefs.getString(_measurementPreferenceKey),
        legacyValue: prefs.getBool(_legacyMetricSystemKey),
      );
      _timezone = prefs.getString(_timezoneKey) ?? await _deviceTimezone();
      await prefs.setString(_timezoneKey, _timezone);
    } catch (_) {
      _recommendedLocale = SupportedAppLocales.byLocale(
        WidgetsBinding.instance.platformDispatcher.locale,
      ).locale;
      _locale = _recommendedLocale;
    }
  }

  void bindToAuth(GoTrueClient auth) {
    _authSubscription?.cancel();
    _authSubscription = auth.onAuthStateChange.listen((event) {
      if (event.session != null) {
        unawaited(syncFromSupabase());
      }
    });
  }

  /// runApp() SONRASI arka planda çağır — Supabase'den locale'i senkronize eder.
  /// Farklı bir değer varsa UI güncellenir.
  Future<void> syncFromSupabase() async {
    try {
      final user = Supabase.instance.client.auth.currentUser;
      if (user == null) return;

      Map<String, dynamic>? response;
      var supportsExtendedPreferences = true;
      try {
        response = await Supabase.instance.client
            .from('profiles')
            .select(
              'language_code, locale, theme_mode, measurement_system, '
              'timezone, preferences_updated_at',
            )
            .eq('id', user.id)
            .maybeSingle()
            .timeout(const Duration(seconds: 4));
      } catch (_) {
        supportsExtendedPreferences = false;
        response = await Supabase.instance.client
            .from('profiles')
            .select('language_code')
            .eq('id', user.id)
            .maybeSingle()
            .timeout(const Duration(seconds: 4));
      }

      final prefs = await SharedPreferences.getInstance();
      final hasLocalChoice =
          prefs.containsKey(_prefModeKey) || prefs.containsKey(prefKey);
      final localUpdatedAt = DateTime.tryParse(
        prefs.getString(_preferencesUpdatedAtKey) ?? '',
      );
      final remoteUpdatedAt = DateTime.tryParse(
        response?['preferences_updated_at']?.toString() ?? '',
      );
      final remoteIsNewer =
          supportsExtendedPreferences &&
          remoteUpdatedAt != null &&
          (localUpdatedAt == null || remoteUpdatedAt.isAfter(localUpdatedAt));

      if (hasLocalChoice && !remoteIsNewer) {
        await _persistRemotePreferences(
          user.id,
          localeTag: currentLocaleTag,
          extended: supportsExtendedPreferences,
        );
        return;
      }

      final hasExplicitRemoteLocale =
          supportsExtendedPreferences &&
          response != null &&
          response.containsKey('locale');
      final remoteLocaleValue = response?['locale'];
      final remoteTag =
          remoteLocaleValue?.toString() ??
          response?['language_code']?.toString();
      if (hasExplicitRemoteLocale && remoteLocaleValue == null) {
        _locale = null;
        _hasCompletedInitialSelection = true;
        await prefs.remove(prefKey);
        await prefs.setString(_prefModeKey, 'system');
        await prefs.setBool(_initialSelectionKey, true);
      } else if (SupportedAppLocales.isSupportedTag(remoteTag)) {
        _locale = SupportedAppLocales.parse(remoteTag);
        _hasCompletedInitialSelection = true;
        await prefs.setString(prefKey, SupportedAppLocales.tagFor(_locale!));
        await prefs.setString(_prefModeKey, 'fixed');
        await prefs.setBool(_initialSelectionKey, true);
      }
      if (supportsExtendedPreferences) {
        _themePreference = _parseThemePreference(
          response?['theme_mode']?.toString(),
        );
        _measurementPreference = _parseMeasurementPreference(
          response?['measurement_system']?.toString(),
        );
        final remoteTimezone = response?['timezone']?.toString().trim();
        if (remoteTimezone != null && remoteTimezone.isNotEmpty) {
          _timezone = remoteTimezone;
        }
        await _writeLocalPreferences(
          prefs,
          updatedAt: remoteUpdatedAt,
          updateLegacyKeys: true,
        );
      }
      notifyListeners();
    } catch (_) {
      // Supabase erişilemezse lokal cache yeterli
    }
  }

  /// Dili değiştirir. Önce state güncellenir, sonra I/O arka planda yapılır.
  Future<void> setLocale(String? localeTag) async {
    final nextLocale = localeTag == null || localeTag.isEmpty
        ? null
        : SupportedAppLocales.byTag(localeTag)?.locale;
    if (localeTag != null && nextLocale == null) return;
    if (nextLocale == _locale) return;

    _locale = nextLocale;
    notifyListeners();

    // I/O arka planda — UI bloklanmaz
    await _persistLocale(localeTag);
  }

  Future<void> completeInitialSelection([String? localeTag]) async {
    if (localeTag != null) {
      _locale = SupportedAppLocales.byTag(localeTag)?.locale ?? _locale;
    }
    _hasCompletedInitialSelection = true;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_initialSelectionKey, true);
    await _persistLocale(currentLocaleTag);
  }

  Future<void> setThemePreference(AppThemePreference preference) async {
    if (_themePreference == preference) return;
    _themePreference = preference;
    notifyListeners();
    await _persistAllPreferences();
  }

  Future<void> setMeasurementPreference(
    MeasurementSystemPreference preference,
  ) async {
    if (_measurementPreference == preference) return;
    _measurementPreference = preference;
    notifyListeners();
    await _persistAllPreferences();
  }

  Future<void> _persistLocale(String? languageCode) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final updatedAt = DateTime.now().toUtc();
      if (languageCode == null || languageCode.isEmpty) {
        await prefs.remove(prefKey);
        await prefs.setString(_prefModeKey, 'system');
      } else {
        final normalized = SupportedAppLocales.byTag(languageCode)?.tag;
        if (normalized == null) return;
        await prefs.setString(prefKey, normalized);
        await prefs.setString(_prefModeKey, 'fixed');
      }
      await prefs.setString(
        _preferencesUpdatedAtKey,
        updatedAt.toIso8601String(),
      );

      final user = Supabase.instance.client.auth.currentUser;
      if (user != null) {
        await _persistRemotePreferences(user.id, localeTag: languageCode);
      }
    } catch (_) {}
  }

  Future<void> _persistAllPreferences() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final updatedAt = DateTime.now().toUtc();
      await _writeLocalPreferences(
        prefs,
        updatedAt: updatedAt,
        updateLegacyKeys: true,
      );
      final user = Supabase.instance.client.auth.currentUser;
      if (user != null) {
        await _persistRemotePreferences(user.id, localeTag: currentLocaleTag);
      }
    } catch (_) {}
  }

  Future<void> _writeLocalPreferences(
    SharedPreferences prefs, {
    DateTime? updatedAt,
    required bool updateLegacyKeys,
  }) async {
    await prefs.setString(_themePreferenceKey, _themePreference.name);
    await prefs.setString(
      _measurementPreferenceKey,
      _measurementPreference.name,
    );
    await prefs.setString(_timezoneKey, _timezone);
    if (updatedAt != null) {
      await prefs.setString(
        _preferencesUpdatedAtKey,
        updatedAt.toUtc().toIso8601String(),
      );
    }
    if (updateLegacyKeys) {
      if (_themePreference != AppThemePreference.system) {
        await prefs.setBool(
          _legacyDarkModeKey,
          _themePreference == AppThemePreference.dark,
        );
      }
      if (_measurementPreference != MeasurementSystemPreference.system) {
        await prefs.setBool(
          _legacyMetricSystemKey,
          _measurementPreference == MeasurementSystemPreference.metric,
        );
      }
    }
  }

  Future<void> _persistRemotePreferences(
    String userId, {
    required String? localeTag,
    bool extended = true,
  }) async {
    final effectiveTag = localeTag ?? effectiveLocaleTag;
    final languageCode = SupportedAppLocales.parse(effectiveTag).languageCode;
    if (extended) {
      try {
        await Supabase.instance.client
            .from('profiles')
            .upsert({
              'id': userId,
              'language_code': languageCode,
              'locale': localeTag,
              'theme_mode': _themePreference.name,
              'measurement_system': _measurementPreference.name,
              'timezone': _timezone,
              'preferences_updated_at': DateTime.now()
                  .toUtc()
                  .toIso8601String(),
            })
            .timeout(const Duration(seconds: 4));
        return;
      } catch (_) {
        // A deployed backend can temporarily lag behind the mobile release.
      }
    }
    await Supabase.instance.client
        .from('profiles')
        .upsert({'id': userId, 'language_code': languageCode})
        .timeout(const Duration(seconds: 4));
  }

  static Future<String> preferredLocaleTag() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final saved = prefs.getString(prefKey);
      if (SupportedAppLocales.isSupportedTag(saved)) {
        return SupportedAppLocales.byTag(saved)!.tag;
      }
    } catch (_) {}
    return SupportedAppLocales.tagFor(
      WidgetsBinding.instance.platformDispatcher.locale,
    );
  }

  static AppThemePreference _parseThemePreference(
    String? value, {
    bool? legacyValue,
  }) {
    for (final preference in AppThemePreference.values) {
      if (preference.name == value) return preference;
    }
    if (legacyValue != null) {
      return legacyValue ? AppThemePreference.dark : AppThemePreference.light;
    }
    return AppThemePreference.system;
  }

  static MeasurementSystemPreference _parseMeasurementPreference(
    String? value, {
    bool? legacyValue,
  }) {
    for (final preference in MeasurementSystemPreference.values) {
      if (preference.name == value) return preference;
    }
    if (legacyValue != null) {
      return legacyValue
          ? MeasurementSystemPreference.metric
          : MeasurementSystemPreference.imperial;
    }
    return MeasurementSystemPreference.system;
  }

  static Future<String> _deviceTimezone() async {
    try {
      return await FlutterTimezone.getLocalTimezone();
    } catch (_) {
      return 'UTC';
    }
  }

  @override
  void dispose() {
    _authSubscription?.cancel();
    super.dispose();
  }
}
