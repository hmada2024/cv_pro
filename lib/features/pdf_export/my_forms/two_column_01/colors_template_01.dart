// features/pdf_export/templates/two_column_01/template_01_colors.dart
import 'package:pdf/pdf.dart';

abstract class Template01Colors {
  static const PdfColor primaryBlueDark = PdfColor.fromInt(0xFF0D47A1);
  static const PdfColor primaryBlueLight = PdfColor.fromInt(0xFF1976D2);
  static const PdfColor accentBlue = PdfColor.fromInt(0xFF42A5F5);
  static const PdfColor backgroundDark = PdfColor.fromInt(0xFF212121);
  static const PdfColor lightText = PdfColors.white;
  static const PdfColor darkText = PdfColor.fromInt(0xFF333333);
  static const PdfColor subtleText = PdfColor.fromInt(0xFF757575);
}