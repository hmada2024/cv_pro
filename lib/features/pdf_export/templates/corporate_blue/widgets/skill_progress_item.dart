import 'package:cv_pro/features/cv_form/data/models/cv_data.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../corporate_blue_template_colors.dart';

class SkillProgressItem extends pw.StatelessWidget {
  final Skill skill;

  SkillProgressItem({required this.skill});

  @override
  pw.Widget build(pw.Context context) {
    const barHeight = 8.0;

    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 10),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text(
                skill.name,
                style: const pw.TextStyle(
                    fontSize: 10, color: CorporateBlueColors.darkText),
              ),
              pw.Text(
                '${skill.level}%',
                style: const pw.TextStyle(
                    fontSize: 10, color: CorporateBlueColors.subtleText),
              ),
            ],
          ),
          pw.SizedBox(height: 4),
          pw.Stack(
            children: [
              // Background bar
              pw.Container(
                height: barHeight,
                decoration: const pw.BoxDecoration(
                  color: PdfColors.grey200,
                  borderRadius: pw.BorderRadius.all(pw.Radius.circular(4)),
                ),
              ),
              // Progress bar
              pw.Container(
                height: barHeight,
                width: (skill.level / 100) *
                    PdfPageFormat.a4.availableWidth, // Use a fraction of width
                decoration: const pw.BoxDecoration(
                  color: CorporateBlueColors.accentBlue,
                  borderRadius: pw.BorderRadius.all(pw.Radius.circular(4)),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
