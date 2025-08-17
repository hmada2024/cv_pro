// lib/features/pdf_export/templates/classic_two_column/classic_template_theme.dart
import 'package:cv_pro/features/pdf_export/theme_templates/pdf_template_theme.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

// هذا هو التنفيذ الفعلي لكتيب التعليمات الخاص بالقالب الكلاسيكي
PdfTemplateTheme classicTemplateTheme() {
  const primary = PdfColor.fromInt(0xFF2C3E50);
  const accent = PdfColor.fromInt(0xFF3498DB);
  const lightText = PdfColor.fromInt(0xFFBDC3C7);
  const darkText = PdfColor.fromInt(0xFF7F8C8D);

  return PdfTemplateTheme(
    primaryColor: primary,
    accentColor: accent,
    lightTextColor: lightText,
    darkTextColor: darkText,
    h1: pw.TextStyle(
      fontSize: 26,
      fontWeight: pw.FontWeight.bold,
      color: primary,
    ),
    h2: const pw.TextStyle(
      fontSize: 14,
      color: primary,
    ),
    body: const pw.TextStyle(fontSize: 10, lineSpacing: 3),
    subtitle: pw.TextStyle(
      fontSize: 10,
      fontStyle: pw.FontStyle.italic,
      color: darkText,
    ),
  );
}
