import 'package:pdf/pdf.dart';

// ألوان مخصصة لقالب Corporate Blue
abstract class CorporateBlueColors {
  static const PdfColor primaryBlue = PdfColor.fromInt(0xFF003D7A);
  static const PdfColor accentBlue = PdfColor.fromInt(0xFF007BFF);
  static const PdfColor backgroundDark = PdfColor.fromInt(0xFF1F1F1F);
  static const PdfColor lightText = PdfColors.white;
  static const PdfColor darkText = PdfColor.fromInt(0xFF333333);
  static const PdfColor subtleText = PdfColor.fromInt(0xFF888888);
}
