// features/pdf_export/templates/corporate_blue/corporate_blue_right_column.dart

import 'package:cv_pro/features/cv_form/data/models/cv_data.dart';
import 'package:cv_pro/features/pdf_export/templates/corporate_blue/corporate_blue_template_colors.dart';
import 'package:cv_pro/features/pdf_export/templates/corporate_blue/widgets/skill_progress_item.dart';
import 'package:cv_pro/features/pdf_export/templates/creative/widgets/experience_item.dart';
import 'package:pdf/widgets.dart' as pw;
import 'widgets/section_header_pill.dart';

class CorporateBlueRightColumn extends pw.StatelessWidget {
  final CVData data;
  final pw.Font iconFont;
  final bool showReferencesNote;

  CorporateBlueRightColumn({
    required this.data,
    required this.iconFont,
    required this.showReferencesNote,
  });

  @override
  pw.Widget build(pw.Context context) {
    return pw.Container(
      padding: const pw.EdgeInsets.fromLTRB(20, 25, 20, 20),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          // Experience
          if (data.experiences.isNotEmpty)
            SectionHeaderPill(
              title: 'Experience',
              backgroundColor: CorporateBlueColors.primaryBlueDark,
              textColor: CorporateBlueColors.lightText,
            ),
          ...data.experiences.map((exp) => ExperienceItem(
                exp,
                iconFont: iconFont,
                positionColor: CorporateBlueColors.darkText,
                companyColor: CorporateBlueColors.subtleText,
              )),
          if (data.experiences.isNotEmpty) pw.SizedBox(height: 20),

          // Education
          if (data.education.isNotEmpty)
            SectionHeaderPill(
              title: 'Education',
              backgroundColor: CorporateBlueColors.primaryBlueDark,
              textColor: CorporateBlueColors.lightText,
            ),
          ...data.education.map((edu) => pw.Padding(
                padding: const pw.EdgeInsets.only(bottom: 10),
                child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        edu.degree,
                        style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                            color: CorporateBlueColors.darkText),
                      ),
                      pw.Text(
                        '${edu.school} / ${edu.startDate.year} - ${edu.endDate.year}',
                        style: const pw.TextStyle(
                            color: CorporateBlueColors.subtleText, fontSize: 9),
                      ),
                    ]),
              )),
          if (data.education.isNotEmpty) pw.SizedBox(height: 20),

          // Skills Summary
          if (data.skills.isNotEmpty)
            SectionHeaderPill(
              title: 'Skills Summary',
              backgroundColor: CorporateBlueColors.primaryBlueDark,
              textColor: CorporateBlueColors.lightText,
            ),
          ...data.skills.map((skill) => SkillProgressItem(skill: skill)),
          if (data.skills.isNotEmpty) pw.SizedBox(height: 20),

          // ✅✅ NEW: The new smart logic for references ✅✅
          _buildReferencesSection(data, showReferencesNote),
        ],
      ),
    );
  }

  pw.Widget _buildReferencesSection(CVData data, bool showReferencesNote) {
    // Case 1: The toggle is ON. The note must be shown.
    if (showReferencesNote) {
      return pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          SectionHeaderPill(
            title: 'References',
            backgroundColor: CorporateBlueColors.primaryBlueDark,
            textColor: CorporateBlueColors.lightText,
          ),
          pw.Text(
            'References available upon request.',
            style: pw.TextStyle(
              fontSize: 10,
              fontStyle: pw.FontStyle.italic,
              color: CorporateBlueColors.subtleText,
            ),
          ),
        ],
      );
    }
    // Case 2: Toggle is OFF AND there are references to show.
    else if (data.references.isNotEmpty) {
      return pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          SectionHeaderPill(
            title: 'References',
            backgroundColor: CorporateBlueColors.primaryBlueDark,
            textColor: CorporateBlueColors.lightText,
          ),
          pw.Wrap(
            spacing: 20,
            runSpacing: 15,
            children:
                data.references.map((ref) => _buildReferenceItem(ref)).toList(),
          ),
        ],
      );
    }
    // Case 3 (Default): Toggle is OFF and no references exist. Show nothing.
    return pw.SizedBox();
  }

  pw.Widget _buildReferenceItem(Reference reference) {
    return pw.SizedBox(
      width: 200,
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            reference.name,
            style: pw.TextStyle(
              fontWeight: pw.FontWeight.bold,
              color: CorporateBlueColors.darkText,
            ),
          ),
          pw.Text(
            '${reference.position}, ${reference.company}',
            style: pw.TextStyle(
              fontSize: 9,
              color: CorporateBlueColors.subtleText,
              fontStyle: pw.FontStyle.italic,
            ),
          ),
          pw.SizedBox(height: 4),
          pw.Text(
            reference.email,
            style: const pw.TextStyle(
              fontSize: 9,
              color: CorporateBlueColors.subtleText,
            ),
          ),
          if (reference.phone != null && reference.phone!.isNotEmpty)
            pw.Text(
              reference.phone!,
              style: const pw.TextStyle(
                fontSize: 9,
                color: CorporateBlueColors.subtleText,
              ),
            ),
        ],
      ),
    );
  }
}
