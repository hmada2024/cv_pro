// lib/core/theme/app_colors.dart
import 'package:flutter/material.dart';

class AppColors {
  // --- الألوان الأساسية ---
  static const Color accent = Color(0xFF1976D2); // أزرق احترافي (دون تغيير)
  static const Color accentLight =
      Color(0xFF64B5F6); // نسخة فاتحة من الأزرق للاستخدام في الوضع الداكن

  static const Color lightScaffold =
      Color(0xFFF0F2F5); // رمادي فاتح للخلفية لمظهر عصري
  static const Color lightCard =
      Color(0xFFFFFFFF); // أبيض نقي للبطاقات لإبرازها
  static const Color lightPrimaryText =
      Color(0xFF1A1A1A); // رمادي داكن للنص الأساسي
  static const Color lightSecondaryText =
      Color(0xFF657786); // رمادي هادئ للنص الثانوي

  // --- ألوان الوضع الداكن ---
  static const Color darkScaffold = Color(0xFF121212); // فحمي للخلفية
  static const Color darkCard = Color(0xFF1E1E1E); // رمادي داكن للبطاقات
  static const Color darkPrimaryText =
      Color(0xFFE0E0E0); // رمادي فاتح للنص الأساسي
  static const Color darkSecondaryText =
      Color(0xFF9E9E9E); // رمادي متوسط للنص الثانوي
}
