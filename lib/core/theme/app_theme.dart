import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppTheme {
  AppTheme._();

  static const _lightPrimary = Color(0xFF087A3D);
  static const _darkPrimary = Color(0xFF68E99D);

  static ThemeData get light => _build(Brightness.light);
  static ThemeData get dark => _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    final scheme =
        ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          brightness: brightness,
        ).copyWith(
          primary: isDark ? _darkPrimary : _lightPrimary,
          onPrimary: isDark ? const Color(0xFF062616) : Colors.white,
          secondary: isDark ? const Color(0xFFB8D9C3) : const Color(0xFF35664A),
          surface: isDark ? const Color(0xFF202A24) : Colors.white,
          onSurface: isDark ? const Color(0xFFE6F1E9) : const Color(0xFF183326),
          error: isDark ? const Color(0xFFFFB4AB) : const Color(0xFFBA1A1A),
        );
    final base = ThemeData(
      brightness: brightness,
      colorScheme: scheme,
      useMaterial3: true,
      scaffoldBackgroundColor: isDark
          ? const Color(0xFF141C17)
          : const Color(0xFFF5F9F6),
    );
    final textTheme = GoogleFonts.interTextTheme(
      base.textTheme,
    ).apply(bodyColor: scheme.onSurface, displayColor: scheme.onSurface);

    return base.copyWith(
      textTheme: textTheme,
      appBarTheme: AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        backgroundColor: Colors.transparent,
        foregroundColor: scheme.onSurface,
        systemOverlayStyle: isDark
            ? SystemUiOverlayStyle.light
            : SystemUiOverlayStyle.dark,
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: scheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: BorderSide(color: scheme.outlineVariant),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: scheme.surfaceContainerHighest.withValues(alpha: 0.5),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(color: scheme.primary, width: 1.5),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size(48, 52),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          textStyle: const TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: scheme.surface,
        modalBackgroundColor: scheme.surface,
        showDragHandle: true,
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: isDark
            ? const Color(0xFF30443A)
            : const Color(0xFF174B32),
        contentTextStyle: const TextStyle(color: Colors.white),
      ),
      dividerColor: scheme.outlineVariant,
      visualDensity: VisualDensity.standard,
    );
  }
}
