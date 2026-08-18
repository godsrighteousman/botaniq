import 'package:botaniq/core/locale/locale_provider.dart';
import 'package:botaniq/core/locale/supported_app_locale.dart';
import 'package:botaniq/core/theme/app_theme.dart';
import 'package:botaniq/features/auth/presentation/pages/login_page.dart';
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

  testWidgets('login fields survive a locale change from the shared picker', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues({
      'settings_timezone': 'UTC',
      'app_locale': 'en',
      'app_locale_mode': 'fixed',
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
