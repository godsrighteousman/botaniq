import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:botaniq/l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'features/onboarding/presentation/pages/onboarding_page.dart';
import 'features/home/presentation/pages/home_page.dart';
import 'core/theme/app_colors.dart';
import 'core/locale/locale_provider.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Supabase başlatma — bu gerekli, auth state için zorunlu
  await Supabase.initialize(
    url: 'https://fikozptvdfzfdruukoqs.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZpa296cHR2ZGZ6ZmRydXVrb3FzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODQzMDc3NzEsImV4cCI6MjA5OTg4Mzc3MX0.QcFIb7d1utIEe5_cB-XBXTHl4F0XJCrujrpsy0QzdUQ',
  );

  // Yalnızca SharedPreferences'tan oku — ağ beklemesi YOK (~5ms)
  final localeProvider = LocaleProvider();
  await localeProvider.loadSavedLocale();

  runApp(
    ChangeNotifierProvider<LocaleProvider>.value(
      value: localeProvider,
      child: const BotaniqApp(),
    ),
  );

  // runApp sonrası arka planda Supabase'den locale senkronize et
  // UI zaten gösterildi, farklı bir değer varsa anında güncellenir
  localeProvider.syncFromSupabase();
}

class BotaniqApp extends StatelessWidget {
  const BotaniqApp({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = context.select<LocaleProvider, Locale?>((p) => p.locale);

    return MaterialApp(
      title: 'Botaniq',
      debugShowCheckedModeBanner: false,
      locale: locale,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
        textTheme: GoogleFonts.interTextTheme().apply(
          bodyColor: Colors.white,
          displayColor: Colors.white,
        ),
      ),
      home: StreamBuilder<AuthState>(
        stream: Supabase.instance.client.auth.onAuthStateChange,
        builder: (context, snapshot) {
          final session =
              snapshot.data?.session ??
              Supabase.instance.client.auth.currentSession;
          if (session != null) {
            return const HomePage();
          } else {
            return const OnboardingPage();
          }
        },
      ),
    );
  }
}
