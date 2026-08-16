import 'dart:math' as math;

import 'package:botaniq/core/locale/locale_provider.dart';
import 'package:botaniq/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    GoogleFonts.config.allowRuntimeFetching = false;
    SharedPreferences.setMockInitialValues(const {});
    await Supabase.initialize(
      url: 'http://127.0.0.1:54321',
      publishableKey: 'local-theme-test-key',
    );
  });

  setUp(() {
    SharedPreferences.setMockInitialValues({'settings_timezone': 'UTC'});
  });

  test(
    'theme preference persists and restores light, dark, and system',
    () async {
      final provider = LocaleProvider();
      addTearDown(provider.dispose);
      await provider.loadSavedLocale();

      expect(provider.themePreference, AppThemePreference.system);
      expect(provider.themeMode, ThemeMode.system);

      await provider.setThemePreference(AppThemePreference.dark);
      var preferences = await SharedPreferences.getInstance();
      expect(preferences.getString('settings_theme_mode'), 'dark');
      expect(preferences.getBool('settings_dark_mode'), isTrue);

      final restoredDark = LocaleProvider();
      addTearDown(restoredDark.dispose);
      await restoredDark.loadSavedLocale();
      expect(restoredDark.themePreference, AppThemePreference.dark);
      expect(restoredDark.themeMode, ThemeMode.dark);

      await restoredDark.setThemePreference(AppThemePreference.light);
      preferences = await SharedPreferences.getInstance();
      expect(preferences.getString('settings_theme_mode'), 'light');
      expect(preferences.getBool('settings_dark_mode'), isFalse);

      await restoredDark.setThemePreference(AppThemePreference.system);
      preferences = await SharedPreferences.getInstance();
      expect(preferences.getString('settings_theme_mode'), 'system');

      final restoredSystem = LocaleProvider();
      addTearDown(restoredSystem.dispose);
      await restoredSystem.loadSavedLocale();
      expect(restoredSystem.themePreference, AppThemePreference.system);
      expect(restoredSystem.themeMode, ThemeMode.system);
    },
  );

  test(
    'new system preference takes precedence over a legacy dark value',
    () async {
      SharedPreferences.setMockInitialValues({
        'settings_timezone': 'UTC',
        'settings_theme_mode': 'system',
        'settings_dark_mode': true,
      });
      final provider = LocaleProvider();
      addTearDown(provider.dispose);
      await provider.loadSavedLocale();

      expect(provider.themePreference, AppThemePreference.system);
      expect(provider.themeMode, ThemeMode.system);
    },
  );

  testWidgets('MaterialApp follows platform brightness only in system mode', (
    tester,
  ) async {
    tester.binding.platformDispatcher.platformBrightnessTestValue =
        Brightness.dark;
    addTearDown(
      tester.binding.platformDispatcher.clearPlatformBrightnessTestValue,
    );

    final provider = LocaleProvider();
    addTearDown(provider.dispose);
    await provider.loadSavedLocale();
    await tester.pumpWidget(_themeTestApp(provider));
    await tester.pumpAndSettle();

    expect(provider.themeMode, ThemeMode.system);
    expect(_renderedBrightness(tester), Brightness.dark);

    await provider.setThemePreference(AppThemePreference.light);
    await tester.pumpAndSettle();
    expect(_renderedBrightness(tester), Brightness.light);

    await provider.setThemePreference(AppThemePreference.dark);
    await tester.pumpAndSettle();
    expect(_renderedBrightness(tester), Brightness.dark);

    await provider.setThemePreference(AppThemePreference.system);
    await tester.pumpAndSettle();
    expect(_renderedBrightness(tester), Brightness.dark);

    tester.binding.platformDispatcher.platformBrightnessTestValue =
        Brightness.light;
    await tester.pumpAndSettle();
    expect(_renderedBrightness(tester), Brightness.light);
    expect(tester.takeException(), isNull);
  });

  test('semantic foreground and background pairs have readable contrast', () {
    final light = AppTheme.light.colorScheme;
    final dark = AppTheme.dark.colorScheme;

    expect(light.brightness, Brightness.light);
    expect(dark.brightness, Brightness.dark);
    expect(light.primary, isNot(dark.primary));
    expect(light.surface, isNot(dark.surface));

    _expectContrast(light.primary, light.onPrimary, minimum: 4.5);
    _expectContrast(light.surface, light.onSurface, minimum: 4.5);
    _expectContrast(light.error, light.onError, minimum: 4.5);
    _expectContrast(dark.primary, dark.onPrimary, minimum: 4.5);
    _expectContrast(dark.surface, dark.onSurface, minimum: 4.5);
    _expectContrast(dark.error, dark.onError, minimum: 4.5);
  });
}

Widget _themeTestApp(LocaleProvider provider) {
  return ChangeNotifierProvider<LocaleProvider>.value(
    value: provider,
    child: Consumer<LocaleProvider>(
      builder: (context, preferences, _) {
        return MaterialApp(
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: preferences.themeMode,
          home: const Scaffold(body: SizedBox(key: Key('theme-probe'))),
        );
      },
    ),
  );
}

Brightness _renderedBrightness(WidgetTester tester) {
  return Theme.of(
    tester.element(find.byKey(const Key('theme-probe'))),
  ).brightness;
}

void _expectContrast(
  Color background,
  Color foreground, {
  required double minimum,
}) {
  final backgroundLuminance = background.computeLuminance();
  final foregroundLuminance = foreground.computeLuminance();
  final lighter = math.max(backgroundLuminance, foregroundLuminance);
  final darker = math.min(backgroundLuminance, foregroundLuminance);
  final ratio = (lighter + 0.05) / (darker + 0.05);
  expect(
    ratio,
    greaterThanOrEqualTo(minimum),
    reason:
        '$foreground on $background has ${ratio.toStringAsFixed(2)}:1 contrast',
  );
}
