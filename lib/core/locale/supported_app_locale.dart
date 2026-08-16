import 'dart:ui';

/// A locale exposed by Botaniq's language picker.
///
/// Keep registration data here so adding a language does not require changing
/// navigation, settings, AI, or notification code.
class SupportedAppLocale {
  const SupportedAppLocale({
    required this.tag,
    required this.locale,
    required this.nativeName,
    required this.englishName,
    required this.emoji,
  });

  final String tag;
  final Locale locale;
  final String nativeName;
  final String englishName;
  final String emoji;

  String get searchableText => '$nativeName $englishName $tag'.toLowerCase();
}

class SupportedAppLocales {
  SupportedAppLocales._();

  static const fallback = Locale('en');

  static const entries = <SupportedAppLocale>[
    SupportedAppLocale(
      tag: 'en',
      locale: Locale('en'),
      nativeName: 'English',
      englishName: 'English',
      emoji: '🇬🇧',
    ),
    SupportedAppLocale(
      tag: 'tr',
      locale: Locale('tr'),
      nativeName: 'Türkçe',
      englishName: 'Turkish',
      emoji: '🇹🇷',
    ),
    SupportedAppLocale(
      tag: 'de',
      locale: Locale('de'),
      nativeName: 'Deutsch',
      englishName: 'German',
      emoji: '🇩🇪',
    ),
    SupportedAppLocale(
      tag: 'fr',
      locale: Locale('fr'),
      nativeName: 'Français',
      englishName: 'French',
      emoji: '🇫🇷',
    ),
    SupportedAppLocale(
      tag: 'es',
      locale: Locale('es'),
      nativeName: 'Español',
      englishName: 'Spanish',
      emoji: '🇪🇸',
    ),
    SupportedAppLocale(
      tag: 'it',
      locale: Locale('it'),
      nativeName: 'Italiano',
      englishName: 'Italian',
      emoji: '🇮🇹',
    ),
    SupportedAppLocale(
      tag: 'pt',
      locale: Locale('pt'),
      nativeName: 'Português',
      englishName: 'Portuguese',
      emoji: '🇵🇹',
    ),
    SupportedAppLocale(
      tag: 'pt-BR',
      locale: Locale('pt', 'BR'),
      nativeName: 'Português (Brasil)',
      englishName: 'Brazilian Portuguese',
      emoji: '🇧🇷',
    ),
    SupportedAppLocale(
      tag: 'pl',
      locale: Locale('pl'),
      nativeName: 'Polski',
      englishName: 'Polish',
      emoji: '🇵🇱',
    ),
    SupportedAppLocale(
      tag: 'ru',
      locale: Locale('ru'),
      nativeName: 'Русский',
      englishName: 'Russian',
      emoji: '🇷🇺',
    ),
    SupportedAppLocale(
      tag: 'zh-Hans',
      locale: Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hans'),
      nativeName: '简体中文',
      englishName: 'Simplified Chinese',
      emoji: '🇨🇳',
    ),
    SupportedAppLocale(
      tag: 'zh-Hant',
      locale: Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hant'),
      nativeName: '繁體中文',
      englishName: 'Traditional Chinese',
      emoji: '🇹🇼',
    ),
    SupportedAppLocale(
      tag: 'id',
      locale: Locale('id'),
      nativeName: 'Bahasa Indonesia',
      englishName: 'Indonesian',
      emoji: '🇮🇩',
    ),
    SupportedAppLocale(
      tag: 'th',
      locale: Locale('th'),
      nativeName: 'ไทย',
      englishName: 'Thai',
      emoji: '🇹🇭',
    ),
    SupportedAppLocale(
      tag: 'ar',
      locale: Locale('ar'),
      nativeName: 'العربية',
      englishName: 'Arabic',
      emoji: '🇸🇦',
    ),
    SupportedAppLocale(
      tag: 'nl-NL',
      locale: Locale('nl', 'NL'),
      nativeName: 'Nederlands (Nederland)',
      englishName: 'Dutch (Netherlands)',
      emoji: '🇳🇱',
    ),
    SupportedAppLocale(
      tag: 'nl-BE',
      locale: Locale('nl', 'BE'),
      nativeName: 'Nederlands (België)',
      englishName: 'Dutch (Belgium)',
      emoji: '🇧🇪',
    ),
  ];

  static List<Locale> get locales =>
      entries.map((entry) => entry.locale).toList(growable: false);

  static Set<String> get tags => entries.map((entry) => entry.tag).toSet();

  static SupportedAppLocale? byTag(String? value) {
    if (value == null || value.trim().isEmpty) return null;
    final normalized = value.trim().replaceAll('_', '-').toLowerCase();
    for (final entry in entries) {
      if (entry.tag.toLowerCase() == normalized) return entry;
    }
    return null;
  }

  static SupportedAppLocale byLocale(Locale locale) {
    final exactTag = _canonicalDeviceTag(locale);
    final exact = byTag(exactTag);
    if (exact != null) return exact;

    for (final entry in entries) {
      if (entry.locale.languageCode == locale.languageCode) return entry;
    }
    return entries.first;
  }

  static Locale parse(String? value) => byTag(value)?.locale ?? fallback;

  static String tagFor(Locale locale) => byLocale(locale).tag;

  static bool isSupportedTag(String? value) => byTag(value) != null;

  static String _canonicalDeviceTag(Locale locale) {
    final language = locale.languageCode.toLowerCase();
    final country = locale.countryCode?.toUpperCase();
    final script = locale.scriptCode;

    if (language == 'zh') {
      if (script == 'Hant' || const {'TW', 'HK', 'MO'}.contains(country)) {
        return 'zh-Hant';
      }
      return 'zh-Hans';
    }
    if (language == 'pt' && country == 'BR') return 'pt-BR';
    if (language == 'nl') return country == 'BE' ? 'nl-BE' : 'nl-NL';
    return language;
  }
}
