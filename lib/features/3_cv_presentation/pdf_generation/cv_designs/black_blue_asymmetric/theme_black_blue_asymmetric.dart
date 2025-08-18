// lib/features/3_cv_presentation/pdf_generation/cv_designs/black_blue_asymmetric/theme_black_blue_asymmetric.dart
import 'package:cv_pro/features/3_cv_presentation/pdf_generation/core/pdf_template_theme.dart';
import 'package:cv_pro/features/3_cv_presentation/pdf_generation/cv_designs/intersection_designs/yellow_intersection/theme_yellow_intersection.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

// نستنسخ نفس هيكل الثيم الأصفر لتضمين الأنماط المخصصة
// هذا يضمن أن لوحة البناء ستجد كل ما تحتاجه
class BlackBluePdfTemplateTheme extends YellowPdfTemplateTheme {
  const BlackBluePdfTemplateTheme({
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
    required super.jobTitleStyle,
  });
}

PdfTemplateTheme blackBlueAsymmetricTheme() {
  // تعريف الألوان الجديدة
  const primaryBlue =
      PdfColor.fromInt(0xFF2C3E50); // اللون الأزرق للعمود الرأسي
  const accentBlack =
      PdfColor.fromInt(0xFF1A1A1A); // اللون الأسود للشريط الأفقي
  const lightText = PdfColors.white;
  const darkText = PdfColor.fromInt(0xFF1A1A1A);
  const subtleDarkText = PdfColor.fromInt(0xFF4D4D4D);

  return BlackBluePdfTemplateTheme(
    // تبديل الألوان
    primaryColor: primaryBlue,
    accentColor: accentBlack,
    lightTextColor: lightText,
    darkTextColor: darkText,
    // تعديل الأنماط بناءً على الألوان الجديدة
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
        color: lightText, // النص في العمود الأزرق سيكون أبيض
        fontSize: 12,
        fontWeight: pw.FontWeight.bold,
        letterSpacing: 1.5),
    leftColumnBody:
        const pw.TextStyle(color: lightText, fontSize: 10, lineSpacing: 2),
    leftColumnSubtext: const pw.TextStyle(color: lightText, fontSize: 9),
    experienceTitleStyle: pw.TextStyle(
        fontSize: 11, fontWeight: pw.FontWeight.bold, color: darkText),
    experienceCompanyStyle:
        const pw.TextStyle(fontSize: 10, color: subtleDarkText),
    experienceDateStyle: pw.TextStyle(
        fontSize: 9, color: subtleDarkText, fontStyle: pw.FontStyle.italic),
    educationTitleStyle: pw.TextStyle(
        fontSize: 11, fontWeight: pw.FontWeight.bold, color: darkText),
    educationSchoolStyle:
        const pw.TextStyle(fontSize: 10, color: subtleDarkText),
    educationDateStyle: pw.TextStyle(
        fontSize: 9, color: subtleDarkText, fontStyle: pw.FontStyle.italic),
    referenceNameStyle:
        pw.TextStyle(fontWeight: pw.FontWeight.bold, color: darkText),
    referenceCompanyStyle: pw.TextStyle(
        fontSize: 9, color: subtleDarkText, fontStyle: pw.FontStyle.italic),
    referenceContactStyle:
        const pw.TextStyle(fontSize: 9, color: subtleDarkText),
  );
}
