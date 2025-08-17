// lib/features/pdf_export/cv_designs/modern_top_header/modern_template_theme.dart
import 'package:cv_pro/features/pdf_export/theme_templates/pdf_template_theme.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

// كتيب التعليمات الخاص بالقالب العصري ذي الرأس العلوي
PdfTemplateTheme modernTopHeaderTheme() {
  // تعريف لوحة ألوان عصرية جديدة
  const primary = PdfColor.fromInt(0xFF0D47A1); // أزرق داكن وعميق
  const accent = PdfColor.fromInt(0xFF00BFA5); // أخضر مائل للأزرق (Teal)
  const lightText = PdfColor.fromInt(0xFFFFFFFF); // أبيض نقي
  const darkText = PdfColor.fromInt(0xFF424242); // رمادي داكن للنصوص

  return PdfTemplateTheme(
    // الألوان
    primaryColor: primary,
    accentColor: accent,
    lightTextColor: lightText,
    darkTextColor: darkText,

    // أنماط النصوص الرئيسية (لجسم الصفحة)
    h1: pw.TextStyle(
      fontSize: 28,
      fontWeight: pw.FontWeight.bold,
      color: lightText, // الاسم سيكون على خلفية داكنة في الرأس
    ),
    h2: pw.TextStyle(
      fontSize: 16,
      fontWeight: pw.FontWeight.bold,
      color: primary, // عناوين الأقسام باللون الأساسي
    ),
    body: const pw.TextStyle(
      fontSize: 10,
      lineSpacing: 3,
      color: darkText,
    ),
    subtitle: pw.TextStyle(
      fontSize: 10,
      fontStyle: pw.FontStyle.italic,
      color: primary,
    ),

    // أنماط العمود الأيسر (غير مستخدمة في هذا التصميم)
    // نوفرها لتلبية متطلبات الكلاس 'PdfTemplateTheme'
    // ونجعلها نسخًا من الأنماط الرئيسية
    leftColumnHeader: pw.TextStyle(
      color: primary,
      fontSize: 11,
      fontWeight: pw.FontWeight.bold,
    ),
    leftColumnBody: const pw.TextStyle(
      color: darkText,
      fontSize: 9.5,
      lineSpacing: 2,
    ),
    leftColumnSubtext: const pw.TextStyle(
      color: darkText,
      fontSize: 9,
    ),
  );
}
