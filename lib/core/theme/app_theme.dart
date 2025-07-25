import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cv_pro/core/theme/app_colors.dart';

// هذا الملف يعرف المظهر الكامل للتطبيق في مكان واحد
final appTheme = ThemeData(
  // تحديد الألوان الأساسية
  primaryColor: AppColors.primary,
  scaffoldBackgroundColor: AppColors.background,

  // استخدام ColorScheme لتحديد الألوان المشتقة تلقائيًا
  colorScheme: ColorScheme.fromSeed(
    seedColor: AppColors.primary,
    primary: AppColors.primary,
    secondary: AppColors.accent,
    surface: AppColors.background,
  ),

  // تحديد الخطوط باستخدام google_fonts
  textTheme: GoogleFonts.cairoTextTheme(
    const TextTheme(
      // للعناوين الرئيسية داخل البطاقات
      titleLarge: TextStyle(
        color: AppColors.textPrimary,
        fontWeight: FontWeight.bold,
        fontSize: 18.0,
      ),
      // للعناوين الفرعية
      titleMedium: TextStyle(
        color: AppColors.textPrimary,
        fontWeight: FontWeight.w600,
        fontSize: 16.0,
      ),
      // للنصوص العادية
      bodyMedium: TextStyle(
        color: AppColors.textSecondary,
        fontSize: 14.0,
        height: 1.5,
      ),
      // للنصوص على الأزرار
      labelLarge: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
    ),
  ),

  // تصميم موحد للـ AppBar
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.primary,
    foregroundColor: Colors.white, // لون الأيقونات والنص في AppBar
    elevation: 2.0,
    centerTitle: true,
    titleTextStyle: GoogleFonts.cairo(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
  ),

  // تصميم موحد للبطاقات (Cards)
  cardTheme: CardTheme(
    elevation: 1.0,
    color: AppColors.cardBackground,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0),
    ),
    margin: EdgeInsets.zero, // سنقوم بتحديد الهوامش يدويًا باستخدام SizedBox
  ),

  // تصميم موحد لحقول الإدخال
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    contentPadding:
        const EdgeInsets.symmetric(vertical: 14.0, horizontal: 12.0),
    labelStyle: const TextStyle(color: AppColors.textSecondary),
    hintStyle: const TextStyle(color: Colors.grey),
    // إزالة الخط السفلي الافتراضي
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: BorderSide.none,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: const BorderSide(color: AppColors.primary, width: 2.0),
    ),
  ),

  // تصميم موحد للأزرار
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 14.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      textStyle: GoogleFonts.cairo(
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
    ),
  ),
);
