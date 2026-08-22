import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:botaniq/l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import 'features/onboarding/presentation/pages/onboarding_page.dart';
import 'features/home/presentation/pages/home_page.dart';
import 'features/splash/presentation/pages/splash_page.dart';
import 'core/config/supabase_config.dart';
import 'core/theme/app_theme.dart';
import 'core/locale/locale_provider.dart';
import 'core/locale/supported_app_locale.dart';
import 'core/services/care_notification_service.dart';
import 'features/subscription/presentation/controllers/subscription_controller.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SupabaseConfig.validate();
  await Supabase.initialize(
    url: SupabaseConfig.url,
    publishableKey: SupabaseConfig.publishableKey,
  );

  // Yalnızca SharedPreferences'tan oku — ağ beklemesi YOK (~5ms)
  final localeProvider = LocaleProvider();
  await localeProvider.loadSavedLocale();
  localeProvider.bindToAuth(Supabase.instance.client.auth);
  final subscriptionController = SubscriptionController()
    ..bindToAuth(Supabase.instance.client.auth);
  try {
    await CareNotificationService.instance.initialize();
  } catch (error) {
    debugPrint('Bakım bildirimleri başlatılamadı: $error');
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<LocaleProvider>.value(value: localeProvider),
        ChangeNotifierProvider<SubscriptionController>.value(
          value: subscriptionController,
        ),
      ],
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
    final preferences = context.watch<LocaleProvider>();

    return MaterialApp(
      onGenerateTitle: (context) => AppLocalizations.of(context)!.appTitle,
      debugShowCheckedModeBanner: false,
      locale: preferences.locale,
      supportedLocales: SupportedAppLocales.locales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      localeResolutionCallback: (deviceLocale, supportedLocales) {
        if (preferences.locale != null) return preferences.locale;
        return SupportedAppLocales.byLocale(
          deviceLocale ?? SupportedAppLocales.fallback,
        ).locale;
      },
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: preferences.themeMode,
      home: const _SplashGate(),
    );
  }
}

/// Uygulama her açıldığında kısa bir marka anı (logo + isim animasyonu)
/// gösterir, ardından mevcut oturum-tabanlı yönlendirmeye (Ana Sayfa veya
/// Onboarding) sorunsuzca devreder. Oturum kontrolü mantığı hiç değişmedi —
/// sadece önüne, sabit süreli, saf görsel bir açılış ekranı eklendi.
class _SplashGate extends StatefulWidget {
  const _SplashGate();

  @override
  State<_SplashGate> createState() => _SplashGateState();
}

class _SplashGateState extends State<_SplashGate> {
  bool _showSplash = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 1600), () {
      if (mounted) setState(() => _showSplash = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_showSplash) return const SplashPage();

    return StreamBuilder<AuthState>(
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
    );
  }
}
