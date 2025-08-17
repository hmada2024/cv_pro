// lib/features/3_cv_presentation/pdf_generation/cv_designs/modern_top_header/modern_template_theme.dart
import 'package:cv_pro/features/3_cv_presentation/pdf_generation/theme_templates/pdf_template_theme.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

PdfTemplateTheme modernTopHeaderTheme() {
  const primary = PdfColor.fromInt(0xFF1976D2);
  const accent = PdfColor.fromInt(0xFF1976D2); // Can be same as primary
  const lightText = PdfColor.fromInt(0xFFFFFFFF);
  const darkText = PdfColor.fromInt(0xFF212121);
  const subtleText = PdfColor.fromInt(0xFF757575);

  return PdfTemplateTheme(
    primaryColor: primary,
    accentColor: accent,
    lightTextColor: lightText,
    darkTextColor: darkText,
    h1: pw.TextStyle(
        fontSize: 26, fontWeight: pw.FontWeight.bold, color: lightText),
    h2: pw.TextStyle(
        fontSize: 14, fontWeight: pw.FontWeight.bold, color: darkText),
    body: const pw.TextStyle(fontSize: 10, lineSpacing: 3, color: darkText),
    subtitle: pw.TextStyle(
        fontSize: 10, fontStyle: pw.FontStyle.italic, color: subtleText),
    // FIX: Using darkText for headers in the body area improves contrast
    leftColumnHeader: pw.TextStyle(
        color: darkText, fontSize: 11, fontWeight: pw.FontWeight.bold),
    leftColumnBody:
        const pw.TextStyle(color: darkText, fontSize: 9.5, lineSpacing: 2),
    leftColumnSubtext: const pw.TextStyle(color: subtleText, fontSize: 9),
    // FIX: Use darkText for titles, keep accent for dates for a balanced look
    experienceTitleStyle: pw.TextStyle(
        fontSize: 12, fontWeight: pw.FontWeight.bold, color: darkText),
    experienceCompanyStyle: const pw.TextStyle(fontSize: 11, color: darkText),
    experienceDateStyle: pw.TextStyle(
        fontSize: 10, color: accent, fontWeight: pw.FontWeight.bold),
    // FIX: Reference styles adjusted for readability
    referenceNameStyle:
        pw.TextStyle(fontWeight: pw.FontWeight.bold, color: darkText),
    referenceCompanyStyle: pw.TextStyle(
        fontSize: 9, color: subtleText, fontStyle: pw.FontStyle.italic),
    referenceContactStyle: const pw.TextStyle(fontSize: 9, color: subtleText),
  );
}
