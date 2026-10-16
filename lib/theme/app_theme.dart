import 'package:flutter/material.dart';

class AppColors {
  static const navy = Color(0xFF061427);
  static const gold = Color(0xFFE3A02B);
  static const cyan = Color(0xFF0FAFCD);
  static const teal = Color(0xFF4D7D76);
  static const slate = Color(0xFF2D3E48);
  static const mist = Color(0xFFBEC0B1);
}

class AppTheme {
  static OutlineInputBorder _border(Color c, [double w = 1]) =>
      OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: c, width: w),
      );

  static ThemeData get dark {
    const scheme = ColorScheme.dark(
      primary: AppColors.gold,
      onPrimary: AppColors.navy,
      secondary: AppColors.cyan,
      onSecondary: AppColors.navy,
      tertiary: AppColors.teal,
      surface: AppColors.slate,
      onSurface: Colors.white,
      error: Color(0xFFFF6B6B),
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: AppColors.navy,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.navy,
        elevation: 0,
        centerTitle: false,
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: const Color(0xFF0A1D36),
        indicatorColor: AppColors.gold.withValues(alpha: 0.2),
        iconTheme: WidgetStateProperty.resolveWith(
          (s) => IconThemeData(
            color: s.contains(WidgetState.selected)
                ? AppColors.gold
                : AppColors.mist,
          ),
        ),
        labelTextStyle: WidgetStateProperty.resolveWith(
          (s) => TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: s.contains(WidgetState.selected)
                ? AppColors.gold
                : AppColors.mist,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.slate.withValues(alpha: 0.55),
        labelStyle: const TextStyle(color: AppColors.mist),
        hintStyle: TextStyle(color: AppColors.mist.withValues(alpha: 0.6)),
        prefixIconColor: AppColors.mist,
        suffixIconColor: AppColors.mist,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        enabledBorder: _border(AppColors.teal.withValues(alpha: 0.5)),
        focusedBorder: _border(AppColors.gold, 1.6),
        errorBorder: _border(scheme.error),
        focusedErrorBorder: _border(scheme.error, 1.6),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.gold,
          foregroundColor: AppColors.navy,
          minimumSize: const Size.fromHeight(54),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.8,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: AppColors.cyan),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.slate,
        contentTextStyle: const TextStyle(color: Colors.white),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}