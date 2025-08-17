// lib/features/pdf_export/theme_templates/pdf_template_theme.dart
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

// هذا الكلاس سيحتوي على كل الأنماط الخاصة بقالب واحد
class PdfTemplateTheme {
  final PdfColor primaryColor;
  final PdfColor accentColor;
  final PdfColor lightTextColor;
  final PdfColor darkTextColor;

  // أنماط النصوص
  final pw.TextStyle h1;
  final pw.TextStyle h2;
  final pw.TextStyle body;
  final pw.TextStyle subtitle;

  const PdfTemplateTheme({
    required this.primaryColor,
    required this.accentColor,
    required this.lightTextColor,
    required this.darkTextColor,
    required this.h1,
    required this.h2,
    required this.body,
    required this.subtitle,
  });
}
