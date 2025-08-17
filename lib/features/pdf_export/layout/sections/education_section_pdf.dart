// lib/features/pdf_export/layout/sections/education_section_pdf.dart
import 'package:cv_pro/features/cv_form/data/models/cv_data.dart';
import 'package:cv_pro/features/pdf_export/layout/widget_education_item.dart';
import 'package:cv_pro/features/pdf_export/layout/widget_section_header.dart';
import 'package:cv_pro/features/pdf_export/theme_templates/pdf_template_theme.dart';
import 'package:pdf/widgets.dart' as pw;

class EducationSectionPdf extends pw.StatelessWidget {
  final List<Education> educationList;
  final PdfTemplateTheme theme;

  EducationSectionPdf({required this.educationList, required this.theme});

  @override
  pw.Widget build(pw.Context context) {
    if (educationList.isEmpty) return pw.SizedBox();

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.SizedBox(height: 20),
        // التغيير: تمرير isLeftColumn بشكل صريح
        SectionHeader(title: 'EDUCATION', theme: theme, isLeftColumn: true),
        ...educationList.map((edu) => EducationItem(edu, theme: theme)),
      ],
    );
  }
}
