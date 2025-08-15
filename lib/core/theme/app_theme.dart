// lib/core/theme/app_theme.dart
import 'package:cv_pro/core/constants/app_sizes.dart';
import 'package:cv_pro/core/constants/app_text_styles.dart';
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
        titleLarge: AppTextStyles.lightTitleLarge,
        titleMedium: AppTextStyles.lightTitleMedium,
        bodyMedium: AppTextStyles.lightBodyMedium,
        bodySmall: AppTextStyles.lightBodySmall,
        labelLarge: AppTextStyles.lightButton,
      ),
    ),
    appBarTheme: AppBarTheme(
      elevation: 0,
      centerTitle: true,
      backgroundColor: AppColors.lightCard,
      foregroundColor: AppColors.lightPrimaryText,
      titleTextStyle: GoogleFonts.cairo(
        textStyle: AppTextStyles.lightAppBar,
      ),
      iconTheme: const IconThemeData(
          color: AppColors.lightPrimaryText, size: AppSizes.iconSizeMedium),
    ),
    cardTheme: CardTheme(
      elevation: 0,
      color: AppColors.lightCard,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.cardRadius),
      ),
      margin: EdgeInsets.zero,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.lightCard,
      contentPadding: const EdgeInsets.symmetric(
          vertical: AppSizes.formFieldContentPaddingV,
          horizontal: AppSizes.formFieldContentPaddingH),
      labelStyle: const TextStyle(color: AppColors.lightSecondaryText),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.buttonRadius),
        borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.buttonRadius),
        borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.buttonRadius),
        borderSide: const BorderSide(color: AppColors.accent, width: 2.0),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.accent,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(
            vertical: AppSizes.formFieldContentPaddingV),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.buttonRadius)),
        textStyle: GoogleFonts.cairo(textStyle: AppTextStyles.lightButton),
      ),
    ),
    chipTheme: ChipThemeData(
      labelStyle: const TextStyle(
          color: AppColors.accent, fontSize: 12, fontWeight: FontWeight.w600),
      backgroundColor: AppColors.accent.withOpacity(0.1),
      deleteIconColor: AppColors.accent.withOpacity(0.7),
      padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.p12, vertical: AppSizes.p8),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.buttonRadius)),
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
        titleLarge: AppTextStyles.darkTitleLarge,
        titleMedium: AppTextStyles.darkTitleMedium,
        bodyMedium: AppTextStyles.darkBodyMedium,
        bodySmall: AppTextStyles.darkBodySmall,
        labelLarge: AppTextStyles.darkButton,
      ),
    ),
    appBarTheme: AppBarTheme(
      elevation: 0,
      centerTitle: true,
      backgroundColor: AppColors.darkCard,
      foregroundColor: AppColors.darkPrimaryText,
      titleTextStyle: GoogleFonts.cairo(
        textStyle: AppTextStyles.darkAppBar,
      ),
      iconTheme: const IconThemeData(
          color: AppColors.darkPrimaryText, size: AppSizes.iconSizeMedium),
    ),
    cardTheme: CardTheme(
      elevation: 0,
      color: AppColors.darkCard,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.cardRadius),
      ),
      margin: EdgeInsets.zero,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.darkCard,
      contentPadding: const EdgeInsets.symmetric(
          vertical: AppSizes.formFieldContentPaddingV,
          horizontal: AppSizes.formFieldContentPaddingH),
      labelStyle: const TextStyle(color: AppColors.darkSecondaryText),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.buttonRadius),
        borderSide: BorderSide(color: Colors.grey.shade700),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.buttonRadius),
        borderSide: BorderSide(color: Colors.grey.shade800),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.buttonRadius),
        borderSide: const BorderSide(color: AppColors.accent, width: 2.0),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.accent,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(
            vertical: AppSizes.formFieldContentPaddingV),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.buttonRadius)),
        textStyle: GoogleFonts.cairo(textStyle: AppTextStyles.darkButton),
      ),
    ),
    chipTheme: ChipThemeData(
      labelStyle: const TextStyle(
          color: AppColors.accentLight,
          fontSize: 12,
          fontWeight: FontWeight.w600),
      backgroundColor: AppColors.accent.withOpacity(0.2),
      deleteIconColor: AppColors.accentLight.withOpacity(0.7),
      padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.p12, vertical: AppSizes.p8),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.buttonRadius)),
      side: BorderSide.none,
    ),
  );
}
