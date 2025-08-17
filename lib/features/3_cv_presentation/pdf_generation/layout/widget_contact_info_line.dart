// lib/features/pdf_export/layout/widget_contact_info_line.dart
import 'package:cv_pro/features/3_cv_presentation/pdf_generation/theme_templates/pdf_template_theme.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class ContactInfoLine extends pw.StatelessWidget {
  final pw.IconData iconData;
  final String text;
  final pw.Font iconFont;
  final PdfTemplateTheme theme;

  ContactInfoLine({
    required this.iconData,
    required this.text,
    required this.iconFont,
    required this.theme,
  });

  @override
  pw.Widget build(pw.Context context) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 6),
      child: pw.Row(
        children: [
          pw.Icon(
            iconData,
            color: theme.accentColor,
            font: iconFont,
            size: 14,
          ),
          pw.SizedBox(width: 10),
          pw.Expanded(
            child: pw.Text(
              text,
              style: const pw.TextStyle(color: PdfColors.white, fontSize: 9),
            ),
          ),
        ],
      ),
    );
  }
}
