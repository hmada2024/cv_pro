// lib/features/pdf_export/layout/sections/experience_section_pdf.dart
import 'package:cv_pro/features/2_cv_editor/form/data/models/cv_data.dart';
import 'package:cv_pro/features/3_cv_presentation/pdf_generation/widgets/widget_experience_item.dart';
import 'package:cv_pro/features/3_cv_presentation/pdf_generation/widgets/widget_section_header.dart';
import 'package:cv_pro/features/3_cv_presentation/pdf_generation/core/pdf_template_theme.dart';
import 'package:pdf/widgets.dart' as pw;

class ExperienceSectionPdf extends pw.StatelessWidget {
  final List<Experience> experiences;
  final PdfTemplateTheme theme;
  final pw.Font iconFont;

  ExperienceSectionPdf({
    required this.experiences,
    required this.theme,
    required this.iconFont,
  });

  @override
  pw.Widget build(pw.Context context) {
    if (experiences.isEmpty) return pw.SizedBox();

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.SizedBox(height: 25),
        SectionHeader(title: 'WORK EXPERIENCE', theme: theme),
        ...experiences.map(
            (exp) => ExperienceItem(exp, iconFont: iconFont, theme: theme)),
      ],
    );
  }
}
