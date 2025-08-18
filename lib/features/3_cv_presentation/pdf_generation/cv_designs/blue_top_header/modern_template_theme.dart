// lib/features/3_cv_presentation/pdf_generation/cv_designs/modern_top_header/modern_template_theme.dart
import 'package:cv_pro/features/3_cv_presentation/pdf_generation/core/pdf_template_theme.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

PdfTemplateTheme modernTopHeaderTheme() {
  const primary = PdfColor.fromInt(0xFF1976D2);
  const lightText = PdfColor.fromInt(0xFFFFFFFF);
  const darkText = PdfColor.fromInt(0xFF212121);

  return PdfTemplateTheme(
    primaryColor: primary,
    accentColor: primary,
    lightTextColor: lightText,
    darkTextColor: darkText,
    h1: pw.TextStyle(
        fontSize: 26, fontWeight: pw.FontWeight.bold, color: lightText),
    h2: pw.TextStyle(
        fontSize: 14, fontWeight: pw.FontWeight.bold, color: darkText),
    body: const pw.TextStyle(fontSize: 10, lineSpacing: 3, color: darkText),
    subtitle: pw.TextStyle(
        // التعديل: تم تغيير اللون من الرمادي إلى الأسود
        fontSize: 10,
        fontStyle: pw.FontStyle.italic,
        color: darkText),

    // في هذا القالب، "العمود الأيسر" هو جزء من الجسم الرئيسي الأبيض
    leftColumnHeader: pw.TextStyle(
        color: darkText, fontSize: 11, fontWeight: pw.FontWeight.bold),
    leftColumnBody:
        const pw.TextStyle(color: darkText, fontSize: 9.5, lineSpacing: 2),
    leftColumnSubtext: const pw.TextStyle(
        color: darkText, fontSize: 9), // التعديل: من الرمادي للأسود

    // أنماط الخبرة
    experienceTitleStyle: pw.TextStyle(
        fontSize: 12, fontWeight: pw.FontWeight.bold, color: darkText),
    experienceCompanyStyle: const pw.TextStyle(fontSize: 11, color: darkText),
    experienceDateStyle: pw.TextStyle(
        // التعديل: تم تغيير اللون من الأزرق إلى الأسود
        fontSize: 10,
        color: darkText,
        fontWeight: pw.FontWeight.bold),

    // أنماط التعليم
    educationTitleStyle: pw.TextStyle(
        fontSize: 11, fontWeight: pw.FontWeight.bold, color: darkText),
    educationSchoolStyle: const pw.TextStyle(
        color: darkText, fontSize: 9.5), // التعديل: من الرمادي للأسود
    educationDateStyle: pw.TextStyle(
        // التعديل: تم تغيير اللون من الأزرق إلى الأسود
        fontSize: 9,
        color: darkText,
        fontWeight: pw.FontWeight.bold),

    // أنماط المراجع
    referenceNameStyle:
        pw.TextStyle(fontWeight: pw.FontWeight.bold, color: darkText),
    referenceCompanyStyle: pw.TextStyle(
        // التعديل: من الرمادي للأسود
        fontSize: 9,
        color: darkText,
        fontStyle: pw.FontStyle.italic),
    referenceContactStyle: const pw.TextStyle(
        fontSize: 9, color: darkText), // التعديل: من الرمادي للأسود
  );
}
