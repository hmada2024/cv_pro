// lib/features/pdf_export/theme_templates/pdf_template_theme.dart
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

// هذا الكلاس سيحتوي على كل الأنماط الخاصة بقالب واحد
class PdfTemplateTheme {
  // الألوان الأساسية
  final PdfColor primaryColor;
  final PdfColor accentColor;
  final PdfColor lightTextColor; // لون النص الفاتح (على خلفية داكنة)
  final PdfColor darkTextColor; // لون النص الداكن (على خلفية فاتحة)

  // أنماط النصوص العامة (للقالب بشكل عام أو للعمود الأيمن في التصاميم المقسمة)
  final pw.TextStyle h1;
  final pw.TextStyle h2;
  final pw.TextStyle body;
  final pw.TextStyle subtitle;

  // أنماط مخصصة للعمود الأيسر (أو أي منطقة ذات خلفية داكنة)
  final pw.TextStyle leftColumnHeader;
  final pw.TextStyle leftColumnBody;
  final pw.TextStyle leftColumnSubtext;

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
  });
}
