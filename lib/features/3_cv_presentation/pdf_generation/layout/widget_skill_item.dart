// lib/features/3_cv_presentation/pdf_generation/layout/widget_skill_item.dart
import 'package:cv_pro/features/2_cv_editor/form/data/models/cv_data.dart';
import 'package:cv_pro/features/3_cv_presentation/pdf_generation/theme_templates/pdf_template_theme.dart';
import 'package:pdf/widgets.dart' as pw;

class SkillItem extends pw.StatelessWidget {
  final Skill skill;
  final PdfTemplateTheme theme;
  final bool isLeftColumn;

  SkillItem(
    this.skill, {
    required this.theme,
    this.isLeftColumn = false,
  });

  @override
  pw.Widget build(pw.Context context) {
    final bodyStyle = isLeftColumn ? theme.leftColumnBody : theme.body;
    final iconColor =
        isLeftColumn ? theme.leftColumnBody.color : theme.accentColor;

    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 4),
      child: pw.Row(
        children: [
          pw.Container(
            width: 6,
            height: 6,
            decoration: pw.BoxDecoration(
              color: iconColor,
              shape: pw.BoxShape.circle,
            ),
          ),
          pw.SizedBox(width: 8),
          pw.Expanded(
            child: pw.Text(
              skill.name,
              style: bodyStyle,
            ),
          ),
        ],
      ),
    );
  }
}
