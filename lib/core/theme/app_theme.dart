import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cv_pro/core/theme/app_colors.dart';

// هذا الملف يعرف المظهر الكامل للتطبيق في مكان واحد

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.accent,
    scaffoldBackgroundColor: AppColors.lightBackground,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.accent,
      brightness: Brightness.light,
      primary: AppColors.accent,
      secondary: AppColors.accent,
      surface: AppColors.lightBackground,
    ),
    textTheme: GoogleFonts.cairoTextTheme(
      const TextTheme(
        titleLarge: TextStyle(
            color: AppColors.lightPrimaryText, fontWeight: FontWeight.bold),
        titleMedium: TextStyle(
            color: AppColors.lightPrimaryText, fontWeight: FontWeight.w600),
        bodyMedium: TextStyle(color: AppColors.lightSecondaryText),
        labelLarge: TextStyle(fontWeight: FontWeight.bold),
      ),
    ),
    appBarTheme: AppBarTheme(
      elevation: 0, // إزالة الظل
      centerTitle: true,
      backgroundColor: AppColors.lightBackground, // نفس لون الخلفية
      foregroundColor: AppColors.lightPrimaryText, // لون الأيقونات والنص
      titleTextStyle: GoogleFonts.cairo(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: AppColors.lightPrimaryText,
      ),
    ),
    cardTheme: CardTheme(
      elevation: 0,
      color: AppColors.lightCard,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      margin: EdgeInsets.zero,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.lightBackground,
      contentPadding:
          const EdgeInsets.symmetric(vertical: 14.0, horizontal: 12.0),
      labelStyle: const TextStyle(color: AppColors.lightSecondaryText),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: Colors.grey),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: AppColors.accent, width: 2.0),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.accent,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 14.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        textStyle: GoogleFonts.cairo(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.accent,
    scaffoldBackgroundColor: AppColors.darkBackground,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.accent,
      brightness: Brightness.dark,
      primary: AppColors.accent,
      secondary: AppColors.accent,
      surface: AppColors.darkBackground,
    ),
    textTheme: GoogleFonts.cairoTextTheme(
      const TextTheme(
        titleLarge: TextStyle(
            color: AppColors.darkPrimaryText, fontWeight: FontWeight.bold),
        titleMedium: TextStyle(
            color: AppColors.darkPrimaryText, fontWeight: FontWeight.w600),
        bodyMedium: TextStyle(color: AppColors.darkSecondaryText),
        labelLarge: TextStyle(fontWeight: FontWeight.bold),
      ),
    ),
    appBarTheme: AppBarTheme(
      elevation: 0,
      centerTitle: true,
      backgroundColor: AppColors.darkBackground,
      foregroundColor: AppColors.darkPrimaryText,
      titleTextStyle: GoogleFonts.cairo(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: AppColors.darkPrimaryText,
      ),
    ),
    cardTheme: CardTheme(
      elevation: 0,
      color: AppColors.darkCard,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      margin: EdgeInsets.zero,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.darkCard,
      contentPadding:
          const EdgeInsets.symmetric(vertical: 14.0, horizontal: 12.0),
      labelStyle: const TextStyle(color: AppColors.darkSecondaryText),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: Colors.grey.shade700),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: Colors.grey.shade800),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: AppColors.accent, width: 2.0),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.accent,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 14.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        textStyle: GoogleFonts.cairo(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    ),
  );
}
