import 'package:cv_pro/features/cv_form/data/models/cv_data.dart';
import 'package:pdf/widgets.dart' as pw;
import '../../modern/widgets/experience_item.dart';
import '../../modern/widgets/section_header.dart';
import 'skill_progress_item.dart';
import '../corporate_blue_template_colors.dart';

class CorporateBlueRightColumn extends pw.StatelessWidget {
  final CVData data;

  CorporateBlueRightColumn({required this.data});

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
          ...data.experiences.map((exp) => ExperienceItem(
                exp,
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