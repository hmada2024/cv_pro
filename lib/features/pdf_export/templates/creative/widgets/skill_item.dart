import 'package:pdf/widgets.dart' as pw;
import '../creative_template_colors.dart';

class SkillItem extends pw.StatelessWidget {
  final String skill;

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
          pw.Text(
            skill,
            style: const pw.TextStyle(color: ModernTemplateColors.lightText, fontSize: 10),
          ),
        ],
      ),
    );
  }
}