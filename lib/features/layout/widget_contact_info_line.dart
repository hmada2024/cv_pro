// features/pdf_export/templates/shared/widgets/contact_info_line.dart
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class ContactInfoLine extends pw.StatelessWidget {
  final pw.IconData iconData;
  final String text;
  final pw.Font iconFont;
  final PdfColor textColor;
  final PdfColor iconColor;

  ContactInfoLine({
    required this.iconData,
    required this.text,
    required this.iconFont,
    // Provide default colors to make it reusable
    textColor,
    iconColor,
  })  : textColor = textColor ?? const PdfColor.fromInt(0xFFFFFFFF),
        iconColor = iconColor ?? const PdfColor.fromInt(0xFF42A5F5);

  @override
  pw.Widget build(pw.Context context) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 6),
      child: pw.Row(
        children: [
          pw.Icon(
            iconData,
            color: iconColor,
            font: iconFont,
            size: 14,
          ),
          pw.SizedBox(width: 10),
          pw.Expanded(
            child: pw.Text(
              text,
              style: pw.TextStyle(color: textColor, fontSize: 9),
            ),
          ),
        ],
      ),
    );
  }
}