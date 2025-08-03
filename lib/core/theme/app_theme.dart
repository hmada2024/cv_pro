// lib/core/theme/app_theme.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cv_pro/core/theme/app_colors.dart';

final themeModeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.system);

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.accent,
    scaffoldBackgroundColor: AppColors.lightScaffold,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.accent,
      brightness: Brightness.light,
      primary: AppColors.accent,
      secondary: AppColors.accent,
      surface: AppColors.lightCard,
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
      elevation: 0,
      centerTitle: true,
      // ✅ تحديث: لون شريط التطبيقات يطابق لون البطاقات
      backgroundColor: AppColors.lightCard,
      foregroundColor: AppColors.lightPrimaryText,
      titleTextStyle: GoogleFonts.cairo(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: AppColors.lightPrimaryText,
      ),
      iconTheme: const IconThemeData(
          color: AppColors.lightPrimaryText), // Ensure icons color
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
      fillColor: AppColors.lightCard,
      contentPadding:
          const EdgeInsets.symmetric(vertical: 14.0, horizontal: 12.0),
      labelStyle: const TextStyle(color: AppColors.lightSecondaryText),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
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
    chipTheme: ChipThemeData(
      labelStyle: const TextStyle(
          color: AppColors.accent, fontSize: 12, fontWeight: FontWeight.w600),
      backgroundColor: AppColors.accent.withOpacity(0.1),
      deleteIconColor: AppColors.accent.withOpacity(0.7),
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      side: BorderSide.none,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.accent,
    scaffoldBackgroundColor: AppColors.darkScaffold,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.accent,
      brightness: Brightness.dark,
      primary: AppColors.accent,
      secondary: AppColors.accent,
      surface: AppColors.darkCard,
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
      // ✅ تحديث: لون شريط التطبيقات يطابق لون البطاقات في الوضع الداكن
      backgroundColor: AppColors.darkCard,
      foregroundColor: AppColors.darkPrimaryText,
      titleTextStyle: GoogleFonts.cairo(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: AppColors.darkPrimaryText,
      ),
      iconTheme: const IconThemeData(
          color: AppColors.darkPrimaryText), // Ensure icons color
    ),
    cardTheme: CardTheme(
      elevation: 0,
      // ✅ تحديث: لون البطاقة من متغيرات الألوان الجديدة
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
    chipTheme: ChipThemeData(
      labelStyle: const TextStyle(
          color: AppColors.accentLight,
          fontSize: 12,
          fontWeight: FontWeight.w600),
      backgroundColor: AppColors.accent.withOpacity(0.2),
      deleteIconColor: AppColors.accentLight.withOpacity(0.7),
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      side: BorderSide.none,
    ),
  );
}
