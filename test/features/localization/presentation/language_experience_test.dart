import 'package:botaniq/core/locale/locale_provider.dart';
import 'package:botaniq/core/locale/supported_app_locale.dart';
import 'package:botaniq/core/theme/app_theme.dart';
import 'package:botaniq/features/auth/presentation/pages/login_page.dart';
import 'package:botaniq/features/localization/presentation/pages/language_selection_page.dart';
import 'package:botaniq/features/localization/presentation/widgets/language_picker_sheet.dart';
import 'package:botaniq/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
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
      publishableKey: 'local-widget-test-key',
    );
  });

  setUp(() {
    SharedPreferences.setMockInitialValues({'settings_timezone': 'UTC'});
  });

  testWidgets('Arabic first-launch gate is RTL and persists completion', (
    tester,
  ) async {
    final provider = LocaleProvider();
    addTearDown(provider.dispose);
    await provider.loadSavedLocale();
    await provider.setLocale('ar');

    await tester.pumpWidget(
      _localizedTestApp(provider: provider, home: const _FirstLaunchGate()),
    );
    await tester.pump();

    final gate = find.byType(LanguageSelectionPage);
    expect(gate, findsOneWidget);
    expect(Directionality.of(tester.element(gate)), TextDirection.rtl);
    expect(Localizations.localeOf(tester.element(gate)), const Locale('ar'));
    expect(provider.hasCompletedInitialSelection, isFalse);

    final continueButton = find.byType(FilledButton);
    await tester.ensureVisible(continueButton);
    await tester.tap(continueButton);
    await tester.pumpAndSettle();

    expect(provider.hasCompletedInitialSelection, isTrue);
    expect(find.byType(LanguageSelectionPage), findsNothing);
    expect(
      find.byKey(const Key('initial-language-gate-complete')),
      findsOneWidget,
    );
    final preferences = await SharedPreferences.getInstance();
    expect(
      preferences.getBool('app_initial_language_selection_completed'),
      isTrue,
    );
    expect(preferences.getString(LocaleProvider.prefKey), 'ar');
    expect(tester.takeException(), isNull);
  });

  testWidgets('login fields survive a locale change from the shared picker', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues({
      'settings_timezone': 'UTC',
      'app_locale': 'en',
      'app_locale_mode': 'fixed',
      'app_initial_language_selection_completed': true,
    });
    final provider = LocaleProvider();
    addTearDown(provider.dispose);
    await provider.loadSavedLocale();

    await tester.pumpWidget(
      _localizedTestApp(provider: provider, home: const LoginPage()),
    );
    await tester.pumpAndSettle();

    var fields = find.byType(TextField);
    expect(fields, findsNWidgets(2));
    await tester.enterText(fields.at(0), 'grower@example.com');
    await tester.enterText(fields.at(1), 'do not trim this password ');

    await tester.tap(find.byTooltip('Select Language'));
    await tester.pumpAndSettle();
    expect(find.byType(LanguagePickerSheet), findsOneWidget);

    final searchField = find.descendant(
      of: find.byType(LanguagePickerSheet),
      matching: find.byType(TextField),
    );
    expect(searchField, findsOneWidget);
    await tester.enterText(searchField, 'Deutsch');
    await tester.pump();
    final germanOption = find.byWidgetPredicate(
      (widget) => widget is Text && widget.data == 'Deutsch',
    );
    expect(germanOption, findsOneWidget);
    await tester.tap(germanOption);
    await tester.pumpAndSettle();

    expect(provider.currentLocaleTag, 'de');
    expect(find.byType(LanguagePickerSheet), findsNothing);
    expect(find.text('Willkommen zurück'), findsOneWidget);

    fields = find.byType(TextField);
    expect(fields, findsNWidgets(2));
    final emailField = tester.widget<TextField>(fields.at(0));
    final passwordField = tester.widget<TextField>(fields.at(1));
    expect(emailField.controller?.text, 'grower@example.com');
    expect(passwordField.controller?.text, 'do not trim this password ');
    expect(tester.takeException(), isNull);
  });

  testWidgets('German first-launch page fits a small phone at 2x text scale', (
    tester,
  ) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(320, 568);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.view.resetPhysicalSize);

    SharedPreferences.setMockInitialValues({
      'settings_timezone': 'UTC',
      'app_locale': 'de',
      'app_locale_mode': 'fixed',
    });
    final provider = LocaleProvider();
    addTearDown(provider.dispose);
    await provider.loadSavedLocale();

    await tester.pumpWidget(
      _localizedTestApp(
        provider: provider,
        home: const LanguageSelectionPage(),
        textScaler: const TextScaler.linear(2),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Wählen Sie Ihre Sprache'), findsOneWidget);
    expect(find.byType(CustomScrollView), findsOneWidget);
    expect(tester.takeException(), isNull);

    await tester.drag(find.byType(CustomScrollView), const Offset(0, -260));
    await tester.pumpAndSettle();
    expect(find.byType(FilledButton), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}

class _FirstLaunchGate extends StatelessWidget {
  const _FirstLaunchGate();

  @override
  Widget build(BuildContext context) {
    return context.watch<LocaleProvider>().hasCompletedInitialSelection
        ? const SizedBox(key: Key('initial-language-gate-complete'))
        : const LanguageSelectionPage();
  }
}

Widget _localizedTestApp({
  required LocaleProvider provider,
  required Widget home,
  TextScaler textScaler = TextScaler.noScaling,
}) {
  return ChangeNotifierProvider<LocaleProvider>.value(
    value: provider,
    child: Consumer<LocaleProvider>(
      builder: (context, preferences, _) {
        return MaterialApp(
          locale: preferences.locale,
          supportedLocales: SupportedAppLocales.locales,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: preferences.themeMode,
          builder: (context, child) {
            final mediaQuery = MediaQuery.of(context);
            return MediaQuery(
              data: mediaQuery.copyWith(textScaler: textScaler),
              child: child!,
            );
          },
          home: home,
        );
      },
    ),
  );
}
