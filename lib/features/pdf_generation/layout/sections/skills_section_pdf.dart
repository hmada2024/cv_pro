// lib/features/pdf_export/layout/sections/skills_section_pdf.dart
import 'package:cv_pro/features/form/data/models/cv_data.dart';
import 'package:cv_pro/features/pdf_generation/layout/widget_section_header.dart';
import 'package:cv_pro/features/pdf_generation/layout/widget_skill_item.dart';
import 'package:cv_pro/features/pdf_generation/theme_templates/pdf_template_theme.dart';
import 'package:pdf/widgets.dart' as pw;

class SkillsSectionPdf extends pw.StatelessWidget {
  final List<Skill> skills;
  final PdfTemplateTheme theme;

  SkillsSectionPdf({required this.skills, required this.theme});

  @override
  pw.Widget build(pw.Context context) {
    if (skills.isEmpty) return pw.SizedBox();

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.SizedBox(height: 20),
        // التغيير: تمرير isLeftColumn بشكل صريح
        SectionHeader(title: 'SKILLS', theme: theme, isLeftColumn: true),
        ...skills.map((skill) => SkillItem(skill, theme: theme)),
      ],
    );
  }
}
