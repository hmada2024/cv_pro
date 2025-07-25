import 'package:pdf/pdf.dart';

// ألوان مخصصة للقالب العصري
abstract class ModernTemplateColors {
  static const PdfColor primary = PdfColor.fromInt(0xFF2C3E50);
  static const PdfColor accent = PdfColor.fromInt(0xFF3498DB);
  static const PdfColor lightText = PdfColor.fromInt(0xFFBDC3C7); // لتحسين التباين
  static const PdfColor darkText = PdfColor.fromInt(0xFF7F8C8D);
}
