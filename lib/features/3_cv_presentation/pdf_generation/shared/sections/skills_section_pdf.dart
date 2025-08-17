// lib/features/3_cv_presentation/pdf_generation/layout/sections/skills_section_pdf.dart
import 'package:cv_pro/features/2_cv_editor/form/data/models/cv_data.dart';
import 'package:cv_pro/features/3_cv_presentation/pdf_generation/shared/widgets/widget_section_header.dart';
import 'package:cv_pro/features/3_cv_presentation/pdf_generation/shared/widgets/widget_skill_item.dart';
import 'package:cv_pro/features/3_cv_presentation/pdf_generation/core/pdf_template_theme.dart';
import 'package:pdf/widgets.dart' as pw;

class SkillsSectionPdf extends pw.StatelessWidget {
  final List<Skill> skills;
  final PdfTemplateTheme theme;
  final bool isLeftColumn;

  SkillsSectionPdf({
    required this.skills,
    required this.theme,
    this.isLeftColumn = false,
  });

  @override
  pw.Widget build(pw.Context context) {
    if (skills.isEmpty) return pw.SizedBox();

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.SizedBox(height: 20),
        SectionHeader(
            title: 'SKILLS', theme: theme, isLeftColumn: isLeftColumn),
        ...skills.map((skill) =>
            SkillItem(skill, theme: theme, isLeftColumn: isLeftColumn)),
      ],
    );
  }
}
