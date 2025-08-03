// features/pdf_export/templates/two_column_02/widgets/contact_info_line.dart
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../../two_column_02/template_02_colors.dart';

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
    this.textColor = Template02Colors.lightText,
    this.iconColor = Template02Colors.accent,
  });

  // ✅✅ FIXED: The entire build method was missing. It has been restored. ✅✅
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