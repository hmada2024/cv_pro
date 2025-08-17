// lib/features/pdf_export/layout/widget_skill_item.dart
import 'package:cv_pro/features/cv_form/data/models/cv_data.dart';
import 'package:cv_pro/features/pdf_export/theme_templates/pdf_template_theme.dart';
import 'package:pdf/widgets.dart' as pw;

class SkillItem extends pw.StatelessWidget {
  final Skill skill;
  final PdfTemplateTheme theme;

  SkillItem(this.skill, {required this.theme});

  @override
  pw.Widget build(pw.Context context) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 4),
      child: pw.Row(
        children: [
          pw.Container(
            width: 6,
            height: 6,
            decoration: pw.BoxDecoration(
              color: theme.accentColor,
              shape: pw.BoxShape.circle,
            ),
          ),
          pw.SizedBox(width: 8),
          pw.Expanded(
            child: pw.Text(
              '${skill.name} (${skill.level})',
              style: pw.TextStyle(color: theme.lightTextColor, fontSize: 10),
            ),
          ),
        ],
      ),
    );
  }
}
