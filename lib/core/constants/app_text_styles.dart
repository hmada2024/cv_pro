// lib/core/constants/app_text_styles.dart
import 'package:flutter/material.dart';
import 'package:cv_pro/core/theme/app_colors.dart';

class AppTextStyles {
  // Light Theme Text Styles
  static const TextStyle lightTitleLarge = TextStyle(
      fontSize: 18,
      color: AppColors.lightPrimaryText,
      fontWeight: FontWeight.bold);
  static const TextStyle lightTitleMedium = TextStyle(
      fontSize: 16,
      color: AppColors.lightPrimaryText,
      fontWeight: FontWeight.w600);
  static const TextStyle lightBodyMedium =
      TextStyle(fontSize: 14, color: AppColors.lightSecondaryText);
  static const TextStyle lightBodySmall =
      TextStyle(fontSize: 12, color: AppColors.lightSecondaryText);
  static const TextStyle lightButton =
      TextStyle(fontWeight: FontWeight.bold, fontSize: 15);
  static const TextStyle lightAppBar = TextStyle(
      fontSize: 19,
      fontWeight: FontWeight.bold,
      color: AppColors.lightPrimaryText);

  // Dark Theme Text Styles
  static const TextStyle darkTitleLarge = TextStyle(
      fontSize: 18,
      color: AppColors.darkPrimaryText,
      fontWeight: FontWeight.bold);
  static const TextStyle darkTitleMedium = TextStyle(
      fontSize: 16,
      color: AppColors.darkPrimaryText,
      fontWeight: FontWeight.w600);
  static const TextStyle darkBodyMedium =
      TextStyle(fontSize: 14, color: AppColors.darkSecondaryText);
  static const TextStyle darkBodySmall =
      TextStyle(fontSize: 12, color: AppColors.darkSecondaryText);
  static const TextStyle darkButton =
      TextStyle(fontWeight: FontWeight.bold, fontSize: 15);
  static const TextStyle darkAppBar = TextStyle(
      fontSize: 19,
      fontWeight: FontWeight.bold,
      color: AppColors.darkPrimaryText);
}
