// features/pdf_export/templates/two_column_02/template_02_right_column.dart
import 'package:cv_pro/features/cv_form/data/models/cv_data.dart';
import 'package:cv_pro/features/pdf_export/my_forms/shared/widgets/experience_item.dart';
import 'package:cv_pro/features/pdf_export/my_forms/shared/widgets/section_header.dart';
import 'package:cv_pro/features/pdf_export/my_forms/two_column_02/colors_template_02.dart';
import 'package:pdf/widgets.dart' as pw;

class Template02RightColumn extends pw.StatelessWidget {
  final CVData data;
  final pw.Font iconFont;
  final bool showReferencesNote;
  Template02RightColumn({
    required this.data,
    required this.iconFont,
    required this.showReferencesNote,
  });
  @override
  pw.Widget build(pw.Context context) {
    final sortedExperience = List<Experience>.from(data.experiences)
      ..sort((a, b) {
        if (a.isCurrent && !b.isCurrent) return -1;
        if (!a.isCurrent && b.isCurrent) return 1;
        if (!a.isCurrent && !b.isCurrent) {
          return b.endDate!.compareTo(a.endDate!);
        }
        return b.startDate.compareTo(a.startDate);
      });

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
          if (sortedExperience.isNotEmpty)
            SectionHeader(
                title: 'WORK EXPERIENCE',
                titleColor: Template02Colors.primary,
                lineColor: Template02Colors.accent),
          ...sortedExperience.map((exp) => ExperienceItem(
                exp,
                iconFont: iconFont,
                positionColor: Template02Colors.primary,
                dateColor: Template02Colors.primary,
              )),
          _buildReferencesSection(data, showReferencesNote),
        ],
      ),
    );
  }

  pw.Widget _buildReferencesSection(CVData data, bool showReferencesNote) {
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
