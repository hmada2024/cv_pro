// lib/features/3_cv_presentation/pdf_generation/layout/widget_reference_item.dart
import 'package:cv_pro/features/2_cv_editor/form/data/models/cv_data.dart';
import 'package:cv_pro/features/3_cv_presentation/pdf_generation/core/pdf_template_theme.dart';
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
          style: theme.referenceNameStyle,
        ),
        pw.Text(
          '${reference.position}, ${reference.company}',
          style: theme.referenceCompanyStyle,
        ),
        pw.SizedBox(height: 4),
        pw.Text(
          reference.email,
          style: theme.referenceContactStyle,
        ),
        if (reference.phone != null && reference.phone!.isNotEmpty)
          pw.Text(
            reference.phone!,
            style: theme.referenceContactStyle,
          ),
      ]),
    );
  }
}
