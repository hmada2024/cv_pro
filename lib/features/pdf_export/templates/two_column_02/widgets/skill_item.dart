import 'package:cv_pro/features/cv_form/data/models/cv_data.dart';
import 'package:pdf/widgets.dart' as pw;
import '../template_02_colors.dart';

class SkillItem extends pw.StatelessWidget {
  // ✅✅ UPDATED: Now accepts the full Skill object ✅✅
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
              color: ModernTemplateColors.accent,
              shape: pw.BoxShape.circle,
            ),
          ),
          pw.SizedBox(width: 8),
          // ✅✅ UPDATED: Displays both the name and the level ✅✅
          pw.Expanded(
            child: pw.Text(
              '${skill.name} (${skill.level})',
              style: const pw.TextStyle(
                  color: ModernTemplateColors.lightText, fontSize: 10),
            ),
          ),
        ],
      ),
    );
  }
}