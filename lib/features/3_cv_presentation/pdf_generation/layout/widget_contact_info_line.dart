// lib/features/3_cv_presentation/pdf_generation/layout/widget_contact_info_line.dart
import 'package:cv_pro/features/3_cv_presentation/pdf_generation/core/pdf_template_theme.dart';
import 'package:pdf/widgets.dart' as pw;

class ContactInfoLine extends pw.StatelessWidget {
  final pw.IconData iconData;
  final String text;
  final pw.Font iconFont;
  final PdfTemplateTheme theme;
  final bool isLeftColumn;

  ContactInfoLine({
    required this.iconData,
    required this.text,
    required this.iconFont,
    required this.theme,
    this.isLeftColumn = false,
  });

  @override
  pw.Widget build(pw.Context context) {
    final bodyStyle = isLeftColumn ? theme.leftColumnBody : theme.body;
    final iconColor =
        isLeftColumn ? theme.leftColumnBody.color : theme.accentColor;

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
              style: bodyStyle,
            ),
          ),
        ],
      ),
    );
  }
}
