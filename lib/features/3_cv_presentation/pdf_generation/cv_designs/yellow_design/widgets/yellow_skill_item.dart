// lib/features/3_cv_presentation/pdf_generation/cv_designs/yellow_design/widgets/yellow_skill_item.dart
import 'package:cv_pro/features/2_cv_editor/form/data/models/cv_data.dart';
import 'package:cv_pro/features/3_cv_presentation/pdf_generation/theme_templates/pdf_template_theme.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class YellowSkillItem extends pw.StatelessWidget {
  final Skill skill;
  final PdfTemplateTheme theme;

  YellowSkillItem(this.skill, {required this.theme});

  int _getSkillLevelAsInt(String? level) {
    switch (level?.toLowerCase()) {
      case 'beginner':
        return 1;
      case 'intermediate':
        return 2;
      case 'advanced':
        return 3;
      case 'upper-intermediate':
        return 4;
      case 'expert':
        return 5;
      default:
        return 3; // Default to intermediate
    }
  }

  @override
  pw.Widget build(pw.Context context) {
    final level = _getSkillLevelAsInt(skill.level);
    const totalDots = 5;

    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 8),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(skill.name, style: theme.leftColumnBody),
          pw.SizedBox(height: 4),
          pw.Row(
            children: List.generate(totalDots, (index) {
              return pw.Container(
                width: 8,
                height: 8,
                margin: const pw.EdgeInsets.only(right: 4),
                decoration: pw.BoxDecoration(
                  color:
                      index < level ? theme.darkTextColor : PdfColors.grey400,
                  shape: pw.BoxShape.circle,
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
