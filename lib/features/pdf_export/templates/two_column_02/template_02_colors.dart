// features/pdf_export/templates/two_column_02/template_02_colors.dart
import 'package.pdf/pdf.dart';

abstract class Template02Colors { // ✅ UPDATED CLASS NAME
  static const PdfColor primary = PdfColor.fromInt(0xFF2C3E50);
  static const PdfColor accent = PdfColor.fromInt(0xFF3498DB);
  static const PdfColor lightText = PdfColor.fromInt(0xFFBDC3C7);
  static const PdfColor darkText = PdfColor.fromInt(0xFF7F8C8D);
}