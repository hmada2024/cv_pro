import 'package:pdf/widgets.dart' as pw;
import '../modern_template_colors.dart';

class ContactInfoLine extends pw.StatelessWidget {
  final pw.IconData iconData;
  final String text;
  final pw.Font iconFont;

  ContactInfoLine({
    required this.iconData,
    required this.text,
    required this.iconFont,
  });

  @override
  pw.Widget build(pw.Context context) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 6),
      child: pw.Row(
        children: [
          pw.Icon(
            iconData,
            color: ModernTemplateColors.accent,
            font: iconFont,
            size: 14,
          ),
          pw.SizedBox(width: 10),
          pw.Expanded(
            child: pw.Text(
              text,
              style: const pw.TextStyle(color: ModernTemplateColors.lightText, fontSize: 9),
            ),
          ),
        ],
      ),
    );
  }
}