// lib/features/pdf_export/cv_designs/modern_top_header/modern_template_theme.dart
import 'package:cv_pro/features/pdf_generation/theme_templates/pdf_template_theme.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

// كتيب التعليمات الخاص بالقالب العصري ذي الرأس العلوي
PdfTemplateTheme modernTopHeaderTheme() {
  const primary = PdfColor.fromInt(0xFF1976D2); // أزرق احترافي (دون تغيير)
  const accent = PdfColor.fromInt(
      0xFF1976D2); // استخدام اللون الأساسي نفسه كلمسة لونية للتوحيد
  const lightText = PdfColor.fromInt(0xFFFFFFFF); // أبيض نقي
  const darkText = PdfColor.fromInt(0xFF212121); // أسود داكن جدًا لوضوح تام

  return PdfTemplateTheme(
    // الألوان
    primaryColor: primary,
    accentColor: accent,
    lightTextColor: lightText,
    darkTextColor: darkText,

    // أنماط النصوص الرئيسية (لجسم الصفحة)
    h1: pw.TextStyle(
      fontSize: 26,
      fontWeight: pw.FontWeight.bold,
      color: lightText,
    ),
    h2: pw.TextStyle(
      fontSize: 16,
      fontWeight: pw.FontWeight.bold,
      color: primary,
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
