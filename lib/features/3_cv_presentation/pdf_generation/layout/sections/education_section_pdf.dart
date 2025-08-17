// lib/features/3_cv_presentation/pdf_generation/layout/sections/education_section_pdf.dart
import 'package:cv_pro/features/2_cv_editor/form/data/models/cv_data.dart';
import 'package:cv_pro/features/3_cv_presentation/pdf_generation/layout/widget_education_item.dart';
import 'package:cv_pro/features/3_cv_presentation/pdf_generation/layout/widget_section_header.dart';
import 'package:cv_pro/features/3_cv_presentation/pdf_generation/theme_templates/pdf_template_theme.dart';
import 'package:pdf/widgets.dart' as pw;

class EducationSectionPdf extends pw.StatelessWidget {
  final List<Education> educationList;
  final PdfTemplateTheme theme;
  // تمت الإضافة: لتحديد ما إذا كان القسم في العمود ذي النمط البديل
  final bool isLeftColumn;

  EducationSectionPdf({
    required this.educationList,
    required this.theme,
    this.isLeftColumn = false, // القيمة الافتراضية هي false
  });

  @override
  pw.Widget build(pw.Context context) {
    if (educationList.isEmpty) return pw.SizedBox();

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.SizedBox(height: 20),
        // تم التصحيح: استخدام المتغير لتحديد نمط العنوان
        SectionHeader(
            title: 'EDUCATION', theme: theme, isLeftColumn: isLeftColumn),
        ...educationList.map(
          // تم التصحيح: تمرير المتغير إلى الويدجت الفرعية
          (edu) => EducationItem(edu, theme: theme, isLeftColumn: isLeftColumn),
        ),
      ],
    );
  }
}
