import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../template_02_colors.dart';

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
    this.textColor = ModernTemplateColors.lightText,
    this.iconColor = ModernTemplateColors.accent,
  });

  @override
  pw.Widget build(pw.Context context) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 6),
      child: pw.Row(
        children: [
          pw.Icon(
            iconData,
            color: iconColor, // استخدام اللون الممرر
            font: iconFont,
            size: 14,
          ),
          pw.SizedBox(width: 10),
          pw.Expanded(
            child: pw.Text(
              text,
              style: pw.TextStyle(
                  color: textColor, fontSize: 9), // استخدام اللون الممرر
            ),
          ),
        ],
      ),
    );
  }
}
