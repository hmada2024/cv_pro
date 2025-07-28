import 'package:cv_pro/features/cv_form/data/models/cv_data.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../corporate_blue_template_colors.dart';

class SkillProgressItem extends pw.StatelessWidget {
  final Skill skill;

  SkillProgressItem({required this.skill});

  @override
  pw.Widget build(pw.Context context) {
    const double barHeight = 6.0;

    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 12),
      child: pw.Row(
        children: [
          pw.SizedBox(
            width: 120,
            child: pw.Text(
              skill.name,
              style: const pw.TextStyle(
                fontSize: 10,
                color: CorporateBlueColors.darkText,
              ),
            ),
          ),
          pw.SizedBox(width: 10),
          pw.Expanded(
            child: pw.LayoutBuilder(
              builder: (pw.Context context, pw.BoxConstraints? constraints) {
                if (constraints == null) {
                  return pw.SizedBox();
                }

                final double progressBarWidth =
                    constraints.maxWidth * (skill.level / 100);

                return pw.Stack(
                  children: [
                    pw.Container(
                      height: barHeight,
                      decoration: const pw.BoxDecoration(
                        color: PdfColors.grey200, // ✅ This will now be defined
                        borderRadius:
                            pw.BorderRadius.all(pw.Radius.circular(3)),
                      ),
                    ),
                    pw.Container(
                      height: barHeight,
                      width: progressBarWidth,
                      decoration: const pw.BoxDecoration(
                        color: CorporateBlueColors.accentBlue,
                        borderRadius:
                            pw.BorderRadius.all(pw.Radius.circular(3)),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          pw.SizedBox(width: 10),
          pw.SizedBox(
            width: 30,
            child: pw.Text(
              '${skill.level}%',
              style: pw.TextStyle(
                fontSize: 10,
                fontWeight: pw.FontWeight.bold,
                color: CorporateBlueColors.subtleText,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
