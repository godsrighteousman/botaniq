import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'features/onboarding/presentation/pages/onboarding_page.dart';
import 'core/theme/app_colors.dart';

void main() {
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
