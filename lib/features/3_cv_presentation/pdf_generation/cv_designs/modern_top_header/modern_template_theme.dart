// lib/features/3_cv_presentation/pdf_generation/cv_designs/modern_top_header/modern_template_theme.dart
import 'package:cv_pro/features/3_cv_presentation/pdf_generation/theme_templates/pdf_template_theme.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

PdfTemplateTheme modernTopHeaderTheme() {
  const primary = PdfColor.fromInt(0xFF1976D2);
  const accent = PdfColor.fromInt(0xFF1976D2);
  const lightText = PdfColor.fromInt(0xFFFFFFFF);
  const darkText = PdfColor.fromInt(0xFF212121);

  return PdfTemplateTheme(
    primaryColor: primary,
    accentColor: accent,
    lightTextColor: lightText,
    darkTextColor: darkText,
    h1: pw.TextStyle(
        fontSize: 26, fontWeight: pw.FontWeight.bold, color: lightText),
    h2: pw.TextStyle(
        fontSize: 16, fontWeight: pw.FontWeight.bold, color: primary),
    body: const pw.TextStyle(fontSize: 10, lineSpacing: 3, color: darkText),
    subtitle: pw.TextStyle(
        fontSize: 10, fontStyle: pw.FontStyle.italic, color: primary),
    leftColumnHeader: pw.TextStyle(
        color: primary, fontSize: 11, fontWeight: pw.FontWeight.bold),
    leftColumnBody:
        const pw.TextStyle(color: darkText, fontSize: 9.5, lineSpacing: 2),
    leftColumnSubtext: const pw.TextStyle(color: darkText, fontSize: 9),

    // تمت الإضافة: تحديد الأنماط لتناسب القالب الحديث
    experienceTitleStyle: pw.TextStyle(
        fontSize: 12, fontWeight: pw.FontWeight.bold, color: primary),
    experienceCompanyStyle: const pw.TextStyle(fontSize: 11, color: primary),
    experienceDateStyle: pw.TextStyle(
        fontSize: 10, color: primary, fontWeight: pw.FontWeight.bold),
  );
}
