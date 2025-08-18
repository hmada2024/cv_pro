// lib/features/3_cv_presentation/pdf_generation/cv_designs/yellow_design/yellow_template_theme.dart
import 'package:cv_pro/features/3_cv_presentation/pdf_generation/core/pdf_template_theme.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

// Custom theme class to include specific styles like jobTitleStyle
class YellowPdfTemplateTheme extends PdfTemplateTheme {
  final pw.TextStyle jobTitleStyle;

  const YellowPdfTemplateTheme({
    required super.primaryColor,
    required super.accentColor,
    required super.lightTextColor,
    required super.darkTextColor,
    required super.h1,
    required super.h2,
    required super.body,
    required super.subtitle,
    required super.leftColumnHeader,
    required super.leftColumnBody,
    required super.leftColumnSubtext,
    required super.experienceTitleStyle,
    required super.experienceCompanyStyle,
    required super.experienceDateStyle,
    required super.educationTitleStyle,
    required super.educationSchoolStyle,
    required super.educationDateStyle,
    required super.referenceNameStyle,
    required super.referenceCompanyStyle,
    required super.referenceContactStyle,
    required this.jobTitleStyle,
  });
}

PdfTemplateTheme yellowTemplateTheme() {
  const primary = PdfColor.fromInt(0xFFFDB416);
  const darkBg = PdfColor.fromInt(0xFF1A1A1A);
  const lightText = PdfColors.white;
  const darkText = PdfColor.fromInt(0xFF1A1A1A);
  const subtleDarkText = PdfColor.fromInt(0xFF4D4D4D);

  return YellowPdfTemplateTheme(
    primaryColor: primary,
    accentColor: darkBg,
    lightTextColor: lightText,
    darkTextColor: darkText,
    h1: pw.TextStyle(
      fontSize: 28,
      fontWeight: pw.FontWeight.bold,
      color: lightText,
      letterSpacing: 2,
    ),
    h2: pw.TextStyle(
        fontSize: 13,
        fontWeight: pw.FontWeight.bold,
        color: darkText,
        letterSpacing: 1.5),
    body: const pw.TextStyle(
        fontSize: 9.5, lineSpacing: 3, color: subtleDarkText),
    jobTitleStyle: pw.TextStyle(
      color: lightText.shade(0.9),
      fontSize: 12,
      letterSpacing: 2,
    ),
    subtitle: pw.TextStyle(
        fontSize: 9.5, fontStyle: pw.FontStyle.italic, color: subtleDarkText),
    leftColumnHeader: pw.TextStyle(
        color: darkText,
        fontSize: 12,
        fontWeight: pw.FontWeight.bold,
        letterSpacing: 1.5),
    leftColumnBody:
        const pw.TextStyle(color: darkText, fontSize: 10, lineSpacing: 2),
    leftColumnSubtext: const pw.TextStyle(color: darkText, fontSize: 9),

    // Experience Styles
    experienceTitleStyle: pw.TextStyle(
        fontSize: 11, fontWeight: pw.FontWeight.bold, color: darkText),
    experienceCompanyStyle:
        const pw.TextStyle(fontSize: 10, color: subtleDarkText),
    experienceDateStyle: pw.TextStyle(
        fontSize: 9, color: subtleDarkText, fontStyle: pw.FontStyle.italic),

    // Education Styles
    educationTitleStyle: pw.TextStyle(
        fontSize: 11, fontWeight: pw.FontWeight.bold, color: darkText),
    educationSchoolStyle:
        const pw.TextStyle(fontSize: 10, color: subtleDarkText),
    educationDateStyle: pw.TextStyle(
        fontSize: 9, color: subtleDarkText, fontStyle: pw.FontStyle.italic),

    // Reference Styles (not used in this layout, but kept for consistency)
    referenceNameStyle:
        pw.TextStyle(fontWeight: pw.FontWeight.bold, color: darkText),
    referenceCompanyStyle: pw.TextStyle(
        fontSize: 9, color: subtleDarkText, fontStyle: pw.FontStyle.italic),
    referenceContactStyle:
        const pw.TextStyle(fontSize: 9, color: subtleDarkText),
  );
}
