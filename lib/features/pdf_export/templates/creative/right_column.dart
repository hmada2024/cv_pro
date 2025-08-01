import 'package:cv_pro/features/cv_form/data/models/cv_data.dart';
import 'package:pdf/widgets.dart' as pw;
import 'creative_template_colors.dart';
import 'widgets/experience_item.dart';
import 'widgets/section_header.dart';

class RightColumn extends pw.StatelessWidget {
  final CVData data;
  final pw.Font iconFont;
  final bool showReferencesNote; // ✅ NEW

  RightColumn({
    required this.data,
    required this.iconFont,
    required this.showReferencesNote, // ✅ NEW
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
              color: ModernTemplateColors.primary,
            ),
          ),
          pw.SizedBox(height: 4),
          pw.Text(
            data.personalInfo.jobTitle.toUpperCase(),
            style: const pw.TextStyle(
                fontSize: 14, color: ModernTemplateColors.darkText),
          ),
          pw.SizedBox(height: 25),
          if (data.personalInfo.summary.isNotEmpty)
            SectionHeader(
                title: 'PROFILE',
                titleColor: ModernTemplateColors.primary,
                lineColor: ModernTemplateColors.accent),
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
                titleColor: ModernTemplateColors.primary,
                lineColor: ModernTemplateColors.accent),
          ...data.experiences.map((exp) => ExperienceItem(
                exp,
                iconFont: iconFont,
                positionColor: ModernTemplateColors.primary,
              )),

          // ✅✅ UPDATED: The new smart logic for references ✅✅
          _buildReferencesSection(data, showReferencesNote),
        ],
      ),
    );
  }

  pw.Widget _buildReferencesSection(CVData data, bool showReferencesNote) {
    // Case 1: The user has added references. Display them.
    if (data.references.isNotEmpty) {
      return pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.SizedBox(height: 25),
          SectionHeader(
            title: 'REFERENCES',
            titleColor: ModernTemplateColors.primary,
            lineColor: ModernTemplateColors.accent,
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
    // Case 2: No references, but the user wants to show the note.
    else if (showReferencesNote) {
      return pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.SizedBox(height: 25),
          SectionHeader(
            title: 'REFERENCES',
            titleColor: ModernTemplateColors.primary,
            lineColor: ModernTemplateColors.accent,
          ),
          pw.Text(
            'References available upon request.',
            style: pw.TextStyle(
                fontSize: 10,
                fontStyle: pw.FontStyle.italic,
                color: ModernTemplateColors.darkText),
          ),
        ],
      );
    }
    // Case 3 (Default): No references and the switch is off. Show nothing.
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
            color: ModernTemplateColors.primary,
          ),
        ),
        pw.Text(
          '${reference.position}, ${reference.company}',
          style: pw.TextStyle(
              fontSize: 9,
              color: ModernTemplateColors.darkText,
              fontStyle: pw.FontStyle.italic),
        ),
        pw.SizedBox(height: 4),
        pw.Text(
          reference.email,
          style: const pw.TextStyle(
            fontSize: 9,
            color: ModernTemplateColors.darkText,
          ),
        ),
        if (reference.phone != null && reference.phone!.isNotEmpty)
          pw.Text(
            reference.phone!,
            style: const pw.TextStyle(
              fontSize: 9,
              color: ModernTemplateColors.darkText,
            ),
          ),
      ]),
    );
  }
}
