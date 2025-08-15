// features/pdf_export/layout/pdf_right_column.dart
import 'package:cv_pro/features/cv_form/data/models/cv_data.dart';
import 'package:pdf/widgets.dart' as pw;
import 'pdf_layout_colors.dart';
import 'widget_experience_item.dart';
import 'widget_section_header.dart';

class PdfRightColumn extends pw.StatelessWidget {
  final CVData data;
  final pw.Font iconFont;
  final bool showReferencesNote;
  PdfRightColumn({
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
              color: PdfLayoutColors.primary,
            ),
          ),
          pw.SizedBox(height: 4),
          pw.Text(
            data.personalInfo.jobTitle.toUpperCase(),
            style: const pw.TextStyle(
                fontSize: 14, color: PdfLayoutColors.darkText),
          ),
          pw.SizedBox(height: 25),
          if (data.personalInfo.summary.isNotEmpty)
            SectionHeader(
                title: 'PROFILE',
                titleColor: PdfLayoutColors.primary,
                lineColor: PdfLayoutColors.accent),
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
                titleColor: PdfLayoutColors.primary,
                lineColor: PdfLayoutColors.accent),
          ...sortedExperience.map((exp) => ExperienceItem(
                exp,
                iconFont: iconFont,
                positionColor: PdfLayoutColors.primary,
                dateColor: PdfLayoutColors.primary,
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
              titleColor: PdfLayoutColors.primary,
              lineColor: PdfLayoutColors.accent,
            ),
            pw.Text(
              'References available upon request.',
              style: const pw.TextStyle(
                  fontSize: 10, color: PdfLayoutColors.darkText),
            ),
          ]);
    } else if (data.references.isNotEmpty) {
      return pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.SizedBox(height: 25),
          SectionHeader(
            title: 'REFERENCES',
            titleColor: PdfLayoutColors.primary,
            lineColor: PdfLayoutColors.accent,
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
            color: PdfLayoutColors.primary,
          ),
        ),
        pw.Text(
          '${reference.position}, ${reference.company}',
          style:
              const pw.TextStyle(fontSize: 9, color: PdfLayoutColors.darkText),
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
