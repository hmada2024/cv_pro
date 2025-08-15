// lib/features/pdf_export/layout/widget_reference_item.dart

import 'package:cv_pro/features/cv_form/data/models/cv_data.dart';
import 'package:pdf/widgets.dart' as pw;
import 'pdf_layout_colors.dart';

class ReferenceItem extends pw.StatelessWidget {
  final Reference reference;

  ReferenceItem(this.reference);

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
            color: PdfLayoutColors.primary,
          ),
        ),
        pw.Text(
          '${reference.position}, ${reference.company}',
          style: pw.TextStyle(
            fontSize: 9,
            color: PdfLayoutColors.darkText,
            fontStyle: pw.FontStyle.italic,
          ),
        ),
        pw.SizedBox(height: 4),
        pw.Text(
          reference.email,
          style: const pw.TextStyle(
            fontSize: 9,
            color: PdfLayoutColors.darkText,
          ),
        ),
        if (reference.phone != null && reference.phone!.isNotEmpty)
          pw.Text(
            reference.phone!,
            style: const pw.TextStyle(
              fontSize: 9,
              color: PdfLayoutColors.darkText,
            ),
          ),
      ]),
    );
  }
}
