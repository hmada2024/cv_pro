import 'package:cv_pro/features/cv_form/data/models/cv_data.dart';
import 'package:pdf/widgets.dart' as pw;
import 'modern_template_colors.dart';
import 'widgets/experience_item.dart';
import 'widgets/section_header.dart';

class RightColumn extends pw.StatelessWidget {
  final CVData data;

  RightColumn({required this.data});

  @override
  pw.Widget build(pw.Context context) {
    return pw.Container(
      padding: const pw.EdgeInsets.fromLTRB(25, 35, 25, 25),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          // Name and Title - with smaller font size
          pw.Text(
            data.personalInfo.name.toUpperCase(),
            style: pw.TextStyle(
              fontSize: 26, // Reduced font size
              fontWeight: pw.FontWeight.bold,
              color: ModernTemplateColors.primary,
            ),
          ),
          pw.SizedBox(height: 4),
          pw.Text(
            data.personalInfo.jobTitle.toUpperCase(),
            style: const pw.TextStyle(fontSize: 14, color: ModernTemplateColors.darkText),
          ),
          pw.SizedBox(height: 25),

          // Profile Section
          if (data.personalInfo.summary.isNotEmpty)
            SectionHeader(title: 'PROFILE', type: HeaderType.forRightColumn),
          if (data.personalInfo.summary.isNotEmpty)
            pw.Text(
              data.personalInfo.summary,
              style: const pw.TextStyle(fontSize: 10, lineSpacing: 3),
              textAlign: pw.TextAlign.justify,
            ),
          if (data.personalInfo.summary.isNotEmpty)
            pw.SizedBox(height: 25),

          // Work Experience
          if (data.experiences.isNotEmpty)
            SectionHeader(title: 'WORK EXPERIENCE', type: HeaderType.forRightColumn),
          ...data.experiences.map((exp) => ExperienceItem(exp)),
        ],
      ),
    );
  }
}