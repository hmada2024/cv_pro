// lib/features/3_cv_presentation/pdf_generation/layout/widget_experience_item.dart
import 'package:cv_pro/features/2_cv_editor/form/data/models/cv_data.dart';
import 'package:cv_pro/features/3_cv_presentation/pdf_generation/core/pdf_template_theme.dart';
import 'package:intl/intl.dart';
import 'package:pdf/widgets.dart' as pw;

class ExperienceItem extends pw.StatelessWidget {
  final Experience experience;
  final pw.Font iconFont;
  final PdfTemplateTheme theme;
  final DateFormat formatter = DateFormat('MMM yyyy');

  ExperienceItem(
    this.experience, {
    required this.iconFont,
    required this.theme,
  });

  @override
  pw.Widget build(pw.Context context) {
    final descriptionLines = experience.description
        .split('\n')
        .where((line) => line.trim().isNotEmpty)
        .map((line) => pw.Padding(
              padding: const pw.EdgeInsets.only(bottom: 3),
              child: pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Container(
                    margin: const pw.EdgeInsets.only(top: 3, right: 8),
                    child: pw.Icon(
                      const pw.IconData(0xe834),
                      font: iconFont,
                      size: 9,
                      // AUDIT IMPROVEMENT: Tie icon color to the body text color
                      color: theme.body.color,
                    ),
                  ),
                  pw.Expanded(
                    child: pw.Text(
                      line.trim().replaceFirst('•', '').trim(),
                      textAlign: pw.TextAlign.justify,
                      style: theme.body,
                    ),
                  ),
                ],
              ),
            ))
        .toList();

    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 16),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Expanded(
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      experience.position.toUpperCase(),
                      style: theme.experienceTitleStyle,
                    ),
                    pw.Text(
                      experience.companyName,
                      style: theme.experienceCompanyStyle,
                    ),
                  ],
                ),
              ),
              pw.SizedBox(width: 10),
              pw.Text(
                '${formatter.format(experience.startDate)} - ${experience.isCurrent ? "Present" : formatter.format(experience.endDate!)}',
                style: theme.experienceDateStyle,
              ),
            ],
          ),
          pw.SizedBox(height: 6),
          ...descriptionLines,
        ],
      ),
    );
  }
}
