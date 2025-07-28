import 'package:cv_pro/features/cv_form/data/models/cv_data.dart';
import 'package:cv_pro/features/pdf_export/templates/corporate_blue/corporate_blue_template_colors.dart';
import 'package:cv_pro/features/pdf_export/templates/corporate_blue/widgets/skill_progress_item.dart';
import 'package:cv_pro/features/pdf_export/templates/creative/widgets/experience_item.dart';
// 🗑️ REMOVED: No longer using the old SectionHeader
// import 'package:cv_pro/features/pdf_export/templates/creative/widgets/section_header.dart';
import 'package:pdf/widgets.dart' as pw;
import 'widgets/section_header_pill.dart'; // ✅ NEW: Import the new pill header

class CorporateBlueRightColumn extends pw.StatelessWidget {
  final CVData data;
  final pw.Font iconFont;

  CorporateBlueRightColumn({
    required this.data,
    required this.iconFont,
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
          pw.SizedBox(height: 20),

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
                            color: CorporateBlueColors.subtleText,
                            fontSize: 9),
                      ),
                    ]),
              )),
          pw.SizedBox(height: 20),

          // Skills Summary
          if (data.skills.isNotEmpty)
            SectionHeaderPill(
              title: 'Skills Summary',
              backgroundColor: CorporateBlueColors.primaryBlueDark,
              textColor: CorporateBlueColors.lightText,
            ),
          ...data.skills.map((skill) => SkillProgressItem(skill: skill)),
        ],
      ),
    );
  }
}