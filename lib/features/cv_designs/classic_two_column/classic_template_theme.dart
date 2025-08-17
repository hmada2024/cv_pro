// lib/features/pdf_export/cv_designs/classic_two_column/classic_template_theme.dart
import 'package:cv_pro/features/pdf_export/theme_templates/pdf_template_theme.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

// هذا هو التنفيذ الفعلي لكتيب التعليمات الخاص بالقالب الكلاسيكي
PdfTemplateTheme classicTemplateTheme() {
  const primary = PdfColor.fromInt(0xFF2C3E50); // رمادي داكن
  const accent = PdfColor.fromInt(0xFF3498DB); // أزرق
  const lightText = PdfColor.fromInt(0xFFFFFFFF); // أبيض
  const darkText = PdfColor.fromInt(0xFF7F8C8D); // رمادي فاتح للنص الثانوي

  return PdfTemplateTheme(
    // الألوان
    primaryColor: primary,
    accentColor: accent,
    lightTextColor: lightText,
    darkTextColor: darkText,

    // أنماط العمود الأيمن (الرئيسي)
    h1: pw.TextStyle(
      fontSize: 26,
      fontWeight: pw.FontWeight.bold,
      color: primary,
    ),
    h2: const pw.TextStyle(
      fontSize: 16, // حجم أكبر لعنوان القسم في العمود الأيمن
      color: primary,
    ),
    body: const pw.TextStyle(fontSize: 10, lineSpacing: 3),
    subtitle: pw.TextStyle(
      fontSize: 10,
      fontStyle: pw.FontStyle.italic,
      color: primary,
    ),

    // أنماط العمود الأيسر (الجانبي)
    leftColumnHeader: pw.TextStyle(
      color: lightText,
      fontSize: 11,
      fontWeight: pw.FontWeight.bold,
    ),
    leftColumnBody: const pw.TextStyle(
      color: lightText,
      fontSize: 9.5,
      lineSpacing: 2,
    ),
    leftColumnSubtext: const pw.TextStyle(
      color: PdfColor.fromInt(0xFFBDC3C7), // رمادي فاتح
      fontSize: 9,
    ),
  );
}
