// lib/features/3_cv_presentation/pdf_generation/theme_templates/pdf_template_theme.dart
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

// هذا الكلاس سيحتوي على كل الأنماط الخاصة بقالب واحد
class PdfTemplateTheme {
  // الألوان الأساسية
  final PdfColor primaryColor;
  final PdfColor accentColor;
  final PdfColor lightTextColor;
  final PdfColor darkTextColor;

  // أنماط النصوص العامة
  final pw.TextStyle h1;
  final pw.TextStyle h2;
  final pw.TextStyle body;
  final pw.TextStyle subtitle;

  // أنماط مخصصة للعمود الأيسر
  final pw.TextStyle leftColumnHeader;
  final pw.TextStyle leftColumnBody;
  final pw.TextStyle leftColumnSubtext;

  // تمت الإضافة: أنماط مخصصة ومحددة لويدجت الخبرة
  final pw.TextStyle experienceTitleStyle;
  final pw.TextStyle experienceCompanyStyle;
  final pw.TextStyle experienceDateStyle;

  const PdfTemplateTheme({
    required this.primaryColor,
    required this.accentColor,
    required this.lightTextColor,
    required this.darkTextColor,
    required this.h1,
    required this.h2,
    required this.body,
    required this.subtitle,
    required this.leftColumnHeader,
    required this.leftColumnBody,
    required this.leftColumnSubtext,
    required this.experienceTitleStyle,
    required this.experienceCompanyStyle,
    required this.experienceDateStyle,
  });
}
