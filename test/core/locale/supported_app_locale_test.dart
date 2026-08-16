import 'package:botaniq/core/locale/locale_provider.dart';
import 'package:botaniq/core/locale/supported_app_locale.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('registry exposes every supported BCP-47 tag exactly once', () {
    const expected = <String>{
      'en',
      'tr',
      'de',
      'fr',
      'es',
      'it',
      'pt',
      'pt-BR',
      'pl',
      'ru',
      'zh-Hans',
      'zh-Hant',
      'id',
      'th',
      'ar',
      'nl-NL',
      'nl-BE',
    };

    expect(SupportedAppLocales.tags, expected);
    expect(SupportedAppLocales.entries, hasLength(expected.length));
    for (final entry in SupportedAppLocales.entries) {
      expect(SupportedAppLocales.tagFor(entry.locale), entry.tag);
      expect(SupportedAppLocales.parse(entry.tag), entry.locale);
      expect(
        SupportedAppLocales.parse(entry.tag.replaceAll('-', '_')),
        entry.locale,
      );
    }
  });

  test('device locale resolution preserves region and Chinese script', () {
    expect(SupportedAppLocales.byLocale(const Locale('pt', 'BR')).tag, 'pt-BR');
    expect(SupportedAppLocales.byLocale(const Locale('nl', 'BE')).tag, 'nl-BE');
    expect(SupportedAppLocales.byLocale(const Locale('nl', 'NL')).tag, 'nl-NL');
    expect(
      SupportedAppLocales.byLocale(
        const Locale.fromSubtags(languageCode: 'zh', countryCode: 'TW'),
      ).tag,
      'zh-Hant',
    );
    expect(
      SupportedAppLocales.byLocale(
        const Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hans'),
      ).tag,
      'zh-Hans',
    );
    expect(SupportedAppLocales.byLocale(const Locale('sv')).tag, 'en');
  });

  testWidgets('first launch recommends a supported device language', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues({'settings_timezone': 'UTC'});
    tester.binding.platformDispatcher.localeTestValue = const Locale(
      'de',
      'DE',
    );
    addTearDown(tester.binding.platformDispatcher.clearLocaleTestValue);

    final provider = LocaleProvider();
    await provider.loadSavedLocale();

    expect(provider.recommendedLocale, const Locale('de'));
    expect(provider.currentLocaleTag, 'de');
    expect(provider.hasCompletedInitialSelection, isFalse);
  });

  testWidgets('legacy and new choices persist without resetting other prefs', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues({
      'app_locale': 'tr',
      'settings_dark_mode': true,
      'settings_metric_system': false,
      'settings_timezone': 'UTC',
      'openai_api_key': 'legacy-secret',
    });
    final provider = LocaleProvider();
    await provider.loadSavedLocale();

    expect(provider.currentLocaleTag, 'tr');
    expect(provider.hasCompletedInitialSelection, isTrue);
    expect(provider.themePreference, AppThemePreference.dark);
    expect(
      provider.measurementPreference,
      MeasurementSystemPreference.imperial,
    );

    await provider.setLocale('pt-BR');
    await provider.setThemePreference(AppThemePreference.light);
    final prefs = await SharedPreferences.getInstance();
    expect(prefs.getString(LocaleProvider.prefKey), 'pt-BR');
    expect(prefs.getString('settings_theme_mode'), 'light');
    expect(prefs.getString('settings_measurement_system'), 'imperial');
    expect(prefs.getString('openai_api_key'), isNull);
  });
}
