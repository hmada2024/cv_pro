// lib/features/pdf_export/layout/sections/references_section_pdf.dart
import 'package:cv_pro/features/2_cv_editor/form/data/models/cv_data.dart';
import 'package:cv_pro/features/3_cv_presentation/pdf_generation/layout/widget_reference_item.dart';
import 'package:cv_pro/features/3_cv_presentation/pdf_generation/layout/widget_section_header.dart';
import 'package:cv_pro/features/3_cv_presentation/pdf_generation/core/pdf_template_theme.dart';
import 'package:pdf/widgets.dart' as pw;

class ReferencesSectionPdf extends pw.StatelessWidget {
  final List<Reference> references;
  final PdfTemplateTheme theme;
  final bool showReferencesNote;

  ReferencesSectionPdf({
    required this.references,
    required this.theme,
    required this.showReferencesNote,
  });

  @override
  pw.Widget build(pw.Context context) {
    if (showReferencesNote) {
      return pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.SizedBox(height: 25),
          SectionHeader(title: 'REFERENCES', theme: theme),
          pw.Text('References available upon request.', style: theme.subtitle),
        ],
      );
    }

    if (references.isEmpty) return pw.SizedBox();

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.SizedBox(height: 25),
        SectionHeader(title: 'REFERENCES', theme: theme),
        pw.Wrap(
          spacing: 20,
          runSpacing: 10,
          children: references
              .map((ref) => ReferenceItem(ref, theme: theme))
              .toList(),
        ),
      ],
    );
  }
}
