// lib/features/3_cv_presentation/pdf_generation/cv_designs/formal_single_column/theme_formal_single_column.dart
import 'package:cv_pro/features/3_cv_presentation/pdf_generation/core/pdf_template_theme.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

PdfTemplateTheme formalSingleColumnTheme() {
  const darkText = PdfColors.black;
  const lightText = PdfColors.white; // Mostly for background consistency

  return PdfTemplateTheme(
    primaryColor: darkText,
    accentColor: darkText, // Accent is also black for the divider lines
    lightTextColor: lightText,
    darkTextColor: darkText,

    // Main title styles
    h1: pw.TextStyle(
        fontSize: 24, fontWeight: pw.FontWeight.bold, color: darkText),
    h2: pw.TextStyle(
        fontSize: 14, fontWeight: pw.FontWeight.bold, color: darkText),

    // Body text styles
    body: const pw.TextStyle(fontSize: 10, lineSpacing: 3, color: darkText),
    subtitle: pw.TextStyle(
        fontSize: 10, fontStyle: pw.FontStyle.italic, color: darkText),

    // These are not used but required by the contract
    leftColumnHeader: const pw.TextStyle(),
    leftColumnBody: const pw.TextStyle(),
    leftColumnSubtext: const pw.TextStyle(),

    // Experience styles
    experienceTitleStyle: pw.TextStyle(
        fontSize: 11, fontWeight: pw.FontWeight.bold, color: darkText),
    experienceCompanyStyle: const pw.TextStyle(fontSize: 10, color: darkText),
    experienceDateStyle: pw.TextStyle(
        fontSize: 9.5, fontStyle: pw.FontStyle.italic, color: darkText),

    // Education styles
    educationTitleStyle: pw.TextStyle(
        fontSize: 11, fontWeight: pw.FontWeight.bold, color: darkText),
    educationSchoolStyle: const pw.TextStyle(fontSize: 10, color: darkText),
    educationDateStyle: pw.TextStyle(
        fontSize: 9.5, fontStyle: pw.FontStyle.italic, color: darkText),

    // Reference styles
    referenceNameStyle:
        pw.TextStyle(fontWeight: pw.FontWeight.bold, color: darkText),
    referenceCompanyStyle: pw.TextStyle(
        fontSize: 9, color: darkText, fontStyle: pw.FontStyle.italic),
    referenceContactStyle: const pw.TextStyle(fontSize: 9, color: darkText),
  );
}
