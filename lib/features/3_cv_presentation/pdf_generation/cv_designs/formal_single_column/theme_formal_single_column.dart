// lib/features/3_cv_presentation/pdf_generation/cv_designs/formal_single_column/theme_formal_single_column.dart
import 'package:cv_pro/features/3_cv_presentation/pdf_generation/core/pdf_template_theme.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

PdfTemplateTheme formalSingleColumnTheme() {
  const darkText = PdfColors.black;
  const lightText = PdfColors.white;
  const subtleText = PdfColor.fromInt(0xFF333333);

  return PdfTemplateTheme(
    primaryColor: darkText,
    accentColor: darkText,
    lightTextColor: lightText,
    darkTextColor: darkText,

    // Main title styles for header
    h1: pw.TextStyle(
        fontSize: 30, // <-- تعديل: زيادة كبيرة في حجم الاسم
        fontWeight: pw.FontWeight.bold,
        color: darkText),
    h2: const pw.TextStyle(
        fontSize: 16, color: subtleText), // <-- تعديل: حجم أقل ووزن عادي

    // Body text styles
    body: const pw.TextStyle(fontSize: 10, lineSpacing: 2.5, color: subtleText),
    subtitle: pw.TextStyle(
        fontSize: 10, fontStyle: pw.FontStyle.italic, color: darkText),

    leftColumnHeader: const pw.TextStyle(),
    leftColumnBody: const pw.TextStyle(),
    leftColumnSubtext: const pw.TextStyle(),

    // Experience styles
    experienceTitleStyle: pw.TextStyle(
        // <-- تعديل: ليكون بأحرف كبيرة
        fontSize: 11,
        fontWeight: pw.FontWeight.bold,
        color: darkText,
        letterSpacing: 0.5),
    experienceCompanyStyle:
        const pw.TextStyle(fontSize: 10.5, color: subtleText),
    experienceDateStyle: pw.TextStyle(
        fontSize: 10, fontStyle: pw.FontStyle.italic, color: subtleText),

    // Education styles
    educationTitleStyle: pw.TextStyle(
        fontSize: 11, fontWeight: pw.FontWeight.bold, color: darkText),
    educationSchoolStyle: const pw.TextStyle(fontSize: 10.5, color: subtleText),
    educationDateStyle: pw.TextStyle(
        fontSize: 10, fontStyle: pw.FontStyle.italic, color: subtleText),

    // Reference styles
    referenceNameStyle:
        pw.TextStyle(fontWeight: pw.FontWeight.bold, color: darkText),
    referenceCompanyStyle: pw.TextStyle(
        fontSize: 9, color: darkText, fontStyle: pw.FontStyle.italic),
    referenceContactStyle: const pw.TextStyle(fontSize: 9, color: darkText),
  );
}
