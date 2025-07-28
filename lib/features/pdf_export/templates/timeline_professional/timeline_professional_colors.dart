import 'package:pdf/pdf.dart';

abstract class TimelineProfessionalColors {
  // الألوان الرمادية للقالب
  static const PdfColor primaryGray = PdfColor.fromInt(0xFF4A4A4A);
  static const PdfColor secondaryGray = PdfColor.fromInt(0xFF3D3D3D);
  static const PdfColor backgroundGray = PdfColor.fromInt(0xFF333333);

  // ألوان النصوص
  static const PdfColor lightText = PdfColors.white;
  static const PdfColor darkText = PdfColor.fromInt(0xFF212121);
  
  // لون الخط الزمني
  static const PdfColor timelineLine = PdfColor.fromInt(0xFFBDBDBD);
}