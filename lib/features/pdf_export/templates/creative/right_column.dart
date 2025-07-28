import 'package:cv_pro/features/cv_form/data/models/cv_data.dart';
import 'package:pdf/widgets.dart' as pw;
import 'creative_template_colors.dart';
import 'widgets/experience_item.dart';
import 'widgets/section_header.dart';

class RightColumn extends pw.StatelessWidget {
  final CVData data;
  final pw.Font iconFont; // ✅ NEW: Added to pass down to children

  RightColumn({
    required this.data,
    required this.iconFont, // ✅ NEW: Made it required
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
          // ✅ UPDATED: Pass the iconFont to each ExperienceItem
          ...data.experiences.map((exp) => ExperienceItem(
                exp,
                iconFont: iconFont,
                positionColor: ModernTemplateColors.primary,
              )),
        ],
      ),
    );
  }
}
