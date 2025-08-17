// lib/features/3_cv_presentation/pdf_generation/cv_designs/yellow_design/yellow_template_theme.dart
import 'package:cv_pro/features/3_cv_presentation/pdf_generation/theme_templates/pdf_template_theme.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

PdfTemplateTheme yellowTemplateTheme() {
  const primary = PdfColor.fromInt(0xFFFDB416);
  const darkBg = PdfColor.fromInt(0xFF1A1A1A);
  const lightText = PdfColors.white;
  const darkText = PdfColor.fromInt(0xFF1A1A1A);

  return PdfTemplateTheme(
    primaryColor: primary,
    accentColor: darkBg,
    lightTextColor: lightText,
    darkTextColor: darkText,
    h1: pw.TextStyle(
        fontSize: 28, fontWeight: pw.FontWeight.bold, color: lightText),
    h2: pw.TextStyle(
        fontSize: 14, fontWeight: pw.FontWeight.bold, color: darkText),
    body: const pw.TextStyle(fontSize: 9.5, lineSpacing: 3, color: darkText),
    subtitle: pw.TextStyle(
        fontSize: 9.5,
        fontStyle: pw.FontStyle.italic,
        color: darkText.shade(0.2)),
    leftColumnHeader: pw.TextStyle(
        color: darkText, fontSize: 11, fontWeight: pw.FontWeight.bold),
    leftColumnBody:
        const pw.TextStyle(color: darkText, fontSize: 9.5, lineSpacing: 2),
    leftColumnSubtext: const pw.TextStyle(color: darkText, fontSize: 9),

    // تمت الإضافة: تحديد الأنماط الصحيحة للقالب الأصفر (نصوص داكنة)
    experienceTitleStyle: pw.TextStyle(
        fontSize: 12, fontWeight: pw.FontWeight.bold, color: darkText),
    experienceCompanyStyle:
        pw.TextStyle(fontSize: 11, color: darkText.shade(0.1)),
    experienceDateStyle: pw.TextStyle(
        fontSize: 10, color: darkText, fontWeight: pw.FontWeight.bold),
  );
}
