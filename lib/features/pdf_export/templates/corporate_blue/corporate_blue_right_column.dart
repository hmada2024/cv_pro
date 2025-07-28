import 'package:cv_pro/features/cv_form/data/models/cv_data.dart';
import 'package:cv_pro/features/pdf_export/templates/corporate_blue/corporate_blue_template_colors.dart';
import 'package:cv_pro/features/pdf_export/templates/corporate_blue/widgets/skill_progress_item.dart';
import 'package:cv_pro/features/pdf_export/templates/creative/widgets/experience_item.dart';
import 'package:cv_pro/features/pdf_export/templates/creative/widgets/section_header.dart';
import 'package:pdf/widgets.dart' as pw;

class CorporateBlueRightColumn extends pw.StatelessWidget {
  final CVData data;
  final pw.Font iconFont; // ✅ NEW: Added to pass down

  CorporateBlueRightColumn({
    required this.data,
    required this.iconFont, // ✅ NEW: Made it required
  });

  @override
  pw.Widget build(pw.Context context) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(20),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          // Experience
          if (data.experiences.isNotEmpty)
            SectionHeader(
              title: 'EXPERIENCE',
              titleColor: CorporateBlueColors.darkText,
              lineColor: CorporateBlueColors.accentBlue,
            ),
          // ✅ UPDATED: Pass the iconFont to each ExperienceItem
          ...data.experiences.map((exp) => ExperienceItem(
                exp,
                iconFont: iconFont,
                positionColor: CorporateBlueColors.darkText,
                companyColor: CorporateBlueColors.subtleText,
              )),
          pw.SizedBox(height: 15),

          // Education
          if (data.education.isNotEmpty)
            SectionHeader(
              title: 'EDUCATION',
              titleColor: CorporateBlueColors.darkText,
              lineColor: CorporateBlueColors.accentBlue,
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
                        edu.school,
                        style: const pw.TextStyle(
                            color: CorporateBlueColors.subtleText),
                      ),
                    ]),
              )),
          pw.SizedBox(height: 15),

          // Skills Summary
          if (data.skills.isNotEmpty)
            SectionHeader(
              title: 'SKILLS SUMMARY',
              titleColor: CorporateBlueColors.darkText,
              lineColor: CorporateBlueColors.accentBlue,
            ),
          ...data.skills.map((skill) => SkillProgressItem(skill: skill)),
        ],
      ),
    );
  }
}