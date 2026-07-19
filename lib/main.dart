import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'features/onboarding/presentation/pages/onboarding_page.dart';
import 'core/theme/app_colors.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://fikozptvdfzfdruukoqs.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZpa296cHR2ZGZ6ZmRydXVrb3FzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODQzMDc3NzEsImV4cCI6MjA5OTg4Mzc3MX0.QcFIb7d1utIEe5_cB-XBXTHl4F0XJCrujrpsy0QzdUQ',
  );

  runApp(const BotaniqApp());
}

class BotaniqApp extends StatelessWidget {
  const BotaniqApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Botaniq',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
        textTheme: GoogleFonts.interTextTheme(
          Theme.of(context).textTheme,
        ).apply(bodyColor: Colors.white, displayColor: Colors.white),
      ),
      home: const OnboardingPage(),
    );
  }
}
