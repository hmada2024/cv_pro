// lib/features/3_cv_presentation/pdf_generation/cv_designs/yellow_design/widgets/yellow_experience_item.dart
import 'package:cv_pro/features/2_cv_editor/form/data/models/cv_data.dart';
import 'package:cv_pro/features/3_cv_presentation/pdf_generation/core/pdf_template_theme.dart';
import 'package:intl/intl.dart';
import 'package:pdf/widgets.dart' as pw;

class YellowExperienceItem extends pw.StatelessWidget {
  final Experience experience;
  final PdfTemplateTheme theme;
  final DateFormat formatter = DateFormat('MMM yyyy');

  YellowExperienceItem(this.experience, {required this.theme});

  @override
  pw.Widget build(pw.Context context) {
    final descriptionLines = experience.description
        .split('\n')
        .where((line) => line.trim().isNotEmpty)
        .map((line) => pw.Padding(
              padding: const pw.EdgeInsets.only(left: 8, bottom: 3),
              child: pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Container(
                    margin: const pw.EdgeInsets.only(top: 4, right: 8),
                    width: 5,
                    height: 5,
                    decoration: pw.BoxDecoration(
                        color: theme.darkTextColor, shape: pw.BoxShape.circle),
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
          pw.Text(
            experience.position.toUpperCase(),
            style: theme.experienceTitleStyle,
          ),
          pw.Text(
            '${experience.companyName} | ${formatter.format(experience.startDate)} - ${experience.isCurrent ? "Present" : formatter.format(experience.endDate!)}',
            style: theme.experienceCompanyStyle,
          ),
          pw.SizedBox(height: 8),
          ...descriptionLines,
        ],
      ),
    );
  }
}
