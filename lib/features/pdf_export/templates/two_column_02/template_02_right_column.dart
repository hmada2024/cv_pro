// features/pdf_export/templates/two_column_02/template_02_right_column.dart
import 'package:cv_pro/features/cv_form/data/models/cv_data.dart';
import 'package:pdf/widgets.dart' as pw;
import 'template_02_colors.dart'; // ✅ UPDATED IMPORT
import 'widgets/experience_item.dart';
import 'widgets/section_header.dart';

class Template02RightColumn extends pw.StatelessWidget {
  // ✅ UPDATED CLASS NAME
  final CVData data;
  final pw.Font iconFont;
  final bool showReferencesNote;
  Template02RightColumn({
    // ✅ UPDATED CONSTRUCTOR
    required this.data,
    required this.iconFont,
    required this.showReferencesNote,
  });
  @override
  pw.Widget build(pw.Context context) {
    return pw.Container(
      padding: const pw.EdgeInsets.fromLTRB(25, 35, 25, 25),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            data.personalInfo.name.toUpperCase(),
            style: pw.TextStyle(
              fontSize: 26,
              fontWeight: pw.FontWeight.bold,
              color: Template02Colors.primary,
            ),
          ),
          pw.SizedBox(height: 4),
          pw.Text(
            data.personalInfo.jobTitle.toUpperCase(),
            style: const pw.TextStyle(
                fontSize: 14, color: Template02Colors.darkText),
          ),
          pw.SizedBox(height: 25),
          if (data.personalInfo.summary.isNotEmpty)
            SectionHeader(
                title: 'PROFILE',
                titleColor: Template02Colors.primary,
                lineColor: Template02Colors.accent),
          if (data.personalInfo.summary.isNotEmpty)
            pw.Text(
              data.personalInfo.summary,
              style: const pw.TextStyle(fontSize: 10, lineSpacing: 3),
              textAlign: pw.TextAlign.justify,
            ),
          if (data.personalInfo.summary.isNotEmpty) pw.SizedBox(height: 25),
          if (data.experiences.isNotEmpty)
            SectionHeader(
                title: 'WORK EXPERIENCE',
                titleColor: Template02Colors.primary,
                lineColor: Template02Colors.accent),
          ...data.experiences.map((exp) => ExperienceItem(
                exp,
                iconFont: iconFont,
                positionColor: Template02Colors.primary,
              )),
          _buildReferencesSection(data, showReferencesNote),
        ],
      ),
    );
  }

  pw.Widget _buildReferencesSection(CVData data, bool showReferencesNote) {
// ... (rest of file is the same and correct)
    if (showReferencesNote) {
      return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.SizedBox(height: 25),
            SectionHeader(
              title: 'REFERENCES',
              titleColor: Template02Colors.primary,
              lineColor: Template02Colors.accent,
            ),
            pw.Text(
              'References available upon request.',
              style: pw.TextStyle(
                  fontSize: 10,
                  fontStyle: pw.FontStyle.italic,
                  color: Template02Colors.darkText),
            ),
          ]);
    } else if (data.references.isNotEmpty) {
      return pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.SizedBox(height: 25),
          SectionHeader(
            title: 'REFERENCES',
            titleColor: Template02Colors.primary,
            lineColor: Template02Colors.accent,
          ),
          pw.Wrap(
            spacing: 20,
            runSpacing: 10,
            children:
                data.references.map((ref) => _buildReferenceItem(ref)).toList(),
          ),
        ],
      );
    }
    return pw.SizedBox();
  }

  pw.Widget _buildReferenceItem(Reference reference) {
    return pw.SizedBox(
      width: 200,
      child:
          pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
        pw.Text(
          reference.name,
          style: pw.TextStyle(
            fontWeight: pw.FontWeight.bold,
            color: Template02Colors.primary,
          ),
        ),
        pw.Text(
          '${reference.position}, ${reference.company}',
          style: pw.TextStyle(
              fontSize: 9,
              color: Template02Colors.darkText,
              fontStyle: pw.FontStyle.italic),
        ),
        pw.SizedBox(height: 4),
        pw.Text(
          reference.email,
          style: const pw.TextStyle(
            fontSize: 9,
            color: Template02Colors.darkText,
          ),
        ),
        if (reference.phone != null && reference.phone!.isNotEmpty)
          pw.Text(
            reference.phone!,
            style: const pw.TextStyle(
              fontSize: 9,
              color: Template02Colors.darkText,
            ),
          ),
      ]),
    );
  }
}
