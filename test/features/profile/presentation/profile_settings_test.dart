import 'package:botaniq/core/locale/locale_provider.dart';
import 'package:botaniq/features/profile/presentation/pages/profile_page.dart';
import 'package:botaniq/features/profile/presentation/pages/settings_page.dart';
import 'package:botaniq/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() {
  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await Supabase.initialize(
      url: 'http://127.0.0.1:54321',
      publishableKey: 'local-test-key',
    );
  });

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  testWidgets('profile is responsive and opens app settings', (tester) async {
    await _setPhoneViewport(tester);
    await tester.pumpWidget(_testApp(const ProfilePage()));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 350));

    expect(find.text('Profilim'), findsOneWidget);
    expect(find.text('BAHÇE PASAPORTU'), findsOneWidget);
    expect(find.text('Genel Bakış'), findsOneWidget);
    expect(tester.takeException(), isNull);

    await tester.tap(find.text('Ayarlar'));
    await tester.pumpAndSettle();

    expect(find.text('Uygulama Ayarları'), findsOneWidget);
    await tester.tap(find.text('Uygulama Ayarları'));
    await tester.pumpAndSettle();

    expect(
      find.text('Botaniq\'i kendi bakım ritmine göre şekillendir.'),
      findsOneWidget,
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('settings persist local switches without a user API field', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues({
      'openai_api_key': 'legacy-user-key',
    });
    await _setPhoneViewport(tester);
    await tester.pumpWidget(_testApp(const SettingsPage()));
    await tester.pumpAndSettle();

    final switches = find.byType(Switch);
    expect(switches, findsNWidgets(2));
    await tester.tap(switches.first);
    await tester.pumpAndSettle();

    var preferences = await SharedPreferences.getInstance();
    expect(preferences.getBool('settings_dark_mode'), isTrue);
    await tester.tap(switches.at(1));
    await tester.pumpAndSettle();

    preferences = await SharedPreferences.getInstance();
    expect(preferences.getBool('settings_metric_system'), isFalse);
    expect(preferences.getString('openai_api_key'), isNull);
    expect(find.text('OpenAI API Key'), findsNothing);
    expect(find.byType(TextField), findsNothing);
    expect(tester.takeException(), isNull);
  });
}

Widget _testApp(Widget home) {
  return ChangeNotifierProvider(
    create: (_) => LocaleProvider(),
    child: MaterialApp(
      locale: const Locale('tr'),
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: ThemeData(useMaterial3: true),
      home: home,
    ),
  );
}

Future<void> _setPhoneViewport(WidgetTester tester) async {
  tester.view.devicePixelRatio = 1;
  tester.view.physicalSize = const Size(390, 844);
  addTearDown(tester.view.resetDevicePixelRatio);
  addTearDown(tester.view.resetPhysicalSize);
}
