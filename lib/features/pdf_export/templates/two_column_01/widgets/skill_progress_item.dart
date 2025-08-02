// features/pdf_export/templates/two_column_01/widgets/skill_progress_item.dart
import 'package:cv_pro/features/cv_form/data/models/cv_data.dart';
import 'package:pdf/widgets.dart' as pw;
import '../template_01_colors.dart'; // ✅ FIXED IMPORT

class SkillProgressItem extends pw.StatelessWidget {
  final Skill skill;
  SkillProgressItem({required this.skill});
  @override
  pw.Widget build(pw.Context context) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 6),
      child: pw.Row(
        children: [
          pw.Container(
            width: 8,
            height: 8,
            decoration: const pw.BoxDecoration(
              color: Template01Colors.accentBlue, // ✅ FIXED CLASS NAME
              shape: pw.BoxShape.circle,
            ),
          ),
          pw.SizedBox(width: 10),
          pw.Text(
            '${skill.name} - ',
            style: pw.TextStyle(
              fontSize: 10,
              color: Template01Colors.darkText, // ✅ FIXED CLASS NAME
              fontWeight: pw.FontWeight.bold,
            ),
          ),
          pw.Text(
            skill.level,
            style: const pw.TextStyle(
              fontSize: 10,
              color: Template01Colors.subtleText, // ✅ FIXED CLASS NAME
            ),
          ),
        ],
      ),
    );
  }
}
