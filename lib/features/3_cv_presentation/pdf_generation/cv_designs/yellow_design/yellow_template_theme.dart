// lib/features/3_cv_presentation/pdf_generation/cv_designs/yellow_design/yellow_template_theme.dart
import 'package:cv_pro/features/3_cv_presentation/pdf_generation/theme_templates/pdf_template_theme.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

PdfTemplateTheme yellowTemplateTheme() {
  const primary = PdfColor.fromInt(0xFFFDB416);
  const darkBg = PdfColor.fromInt(0xFF1A1A1A);
  const lightText = PdfColors.white;
  const darkText = PdfColor.fromInt(0xFF1A1A1A);
  const subtleDarkText = PdfColor.fromInt(0xFF4D4D4D);

  return PdfTemplateTheme(
    primaryColor: primary,
    accentColor: darkBg,
    lightTextColor: lightText,
    darkTextColor: darkText,
    h1: pw.TextStyle(
      fontSize: 32, // زيادة حجم الخط للاسم
      fontWeight: pw.FontWeight.bold,
      color: lightText,
      letterSpacing: 2,
    ),
    h2: pw.TextStyle(
        fontSize: 13,
        fontWeight: pw.FontWeight.bold,
        color: darkText,
        letterSpacing: 1),
    body: const pw.TextStyle(fontSize: 9.5, lineSpacing: 3, color: darkText),
    subtitle: pw.TextStyle(
        fontSize: 9.5, fontStyle: pw.FontStyle.italic, color: subtleDarkText),
    leftColumnHeader: pw.TextStyle(
        color: darkText,
        fontSize: 12, // تكبير خط عناوين العمود الأيسر
        fontWeight: pw.FontWeight.bold),
    leftColumnBody:
        const pw.TextStyle(color: darkText, fontSize: 10, lineSpacing: 2),
    leftColumnSubtext: const pw.TextStyle(color: darkText, fontSize: 9),

    // Experience Styles
    experienceTitleStyle: pw.TextStyle(
        fontSize: 11, fontWeight: pw.FontWeight.bold, color: darkText),
    experienceCompanyStyle:
        const pw.TextStyle(fontSize: 10, color: subtleDarkText),
    experienceDateStyle: pw.TextStyle(
        fontSize: 10, color: darkText, fontWeight: pw.FontWeight.bold),

    // Education Styles
    educationTitleStyle: pw.TextStyle(
        fontSize: 11, fontWeight: pw.FontWeight.bold, color: darkText),
    educationSchoolStyle:
        const pw.TextStyle(fontSize: 10, color: subtleDarkText),
    educationDateStyle: pw.TextStyle(
        fontSize: 9, color: darkText, fontWeight: pw.FontWeight.bold),

    // Reference Styles
    referenceNameStyle:
        pw.TextStyle(fontWeight: pw.FontWeight.bold, color: darkText),
    referenceCompanyStyle: pw.TextStyle(
        fontSize: 9, color: subtleDarkText, fontStyle: pw.FontStyle.italic),
    referenceContactStyle:
        const pw.TextStyle(fontSize: 9, color: subtleDarkText),
  );
}
