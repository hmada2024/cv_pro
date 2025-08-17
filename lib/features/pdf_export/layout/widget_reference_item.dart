// lib/features/pdf_export/layout/widget_reference_item.dart
import 'package:cv_pro/features/cv_form/data/models/cv_data.dart';
import 'package:cv_pro/features/pdf_export/theme_templates/pdf_template_theme.dart';
import 'package:pdf/widgets.dart' as pw;

class ReferenceItem extends pw.StatelessWidget {
  final Reference reference;
  final PdfTemplateTheme theme;

  ReferenceItem(this.reference, {required this.theme});

  @override
  pw.Widget build(pw.Context context) {
    return pw.SizedBox(
      width: 200,
      child:
          pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
        pw.Text(
          reference.name,
          style: pw.TextStyle(
            fontWeight: pw.FontWeight.bold,
            color: theme.primaryColor,
          ),
        ),
        pw.Text(
          '${reference.position}, ${reference.company}',
          style: pw.TextStyle(
            fontSize: 9,
            color: theme.darkTextColor,
            fontStyle: pw.FontStyle.italic,
          ),
        ),
        pw.SizedBox(height: 4),
        pw.Text(
          reference.email,
          style: pw.TextStyle(
            fontSize: 9,
            color: theme.darkTextColor,
          ),
        ),
        if (reference.phone != null && reference.phone!.isNotEmpty)
          pw.Text(
            reference.phone!,
            style: pw.TextStyle(
              fontSize: 9,
              color: theme.darkTextColor,
            ),
          ),
      ]),
    );
  }
}
