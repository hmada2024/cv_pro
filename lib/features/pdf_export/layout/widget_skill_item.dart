// features/pdf_export/layout/widget_skill_item.dart
import 'package:cv_pro/features/cv_form/data/models/cv_data.dart';
import 'package:pdf/widgets.dart' as pw;
import 'pdf_layout_colors.dart';

class SkillItem extends pw.StatelessWidget {
  final Skill skill;

  SkillItem(this.skill);

  @override
  pw.Widget build(pw.Context context) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 4),
      child: pw.Row(
        children: [
          pw.Container(
            width: 6,
            height: 6,
            decoration: const pw.BoxDecoration(
              color: PdfLayoutColors.accent,
              shape: pw.BoxShape.circle,
            ),
          ),
          pw.SizedBox(width: 8),
          pw.Expanded(
            child: pw.Text(
              '${skill.name} (${skill.level})',
              style: const pw.TextStyle(
                  color: PdfLayoutColors.lightText, fontSize: 10),
            ),
          ),
        ],
      ),
    );
  }
}
