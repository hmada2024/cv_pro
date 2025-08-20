// lib/features/3_cv_presentation/pdf_generation/shared/sections/courses_section_pdf.dart
import 'package:cv_pro/features/2_cv_editor/form/data/models/cv_data.dart';
import 'package:cv_pro/features/3_cv_presentation/pdf_generation/shared/widgets/widget_course_item.dart';
import 'package:cv_pro/features/3_cv_presentation/pdf_generation/shared/widgets/widget_section_header.dart';
import 'package:cv_pro/features/3_cv_presentation/pdf_generation/core/pdf_template_theme.dart';
import 'package:pdf/widgets.dart' as pw;

class CoursesSectionPdf extends pw.StatelessWidget {
  final List<Course> courses;
  final PdfTemplateTheme theme;
  final bool isLeftColumn;

  CoursesSectionPdf({
    required this.courses,
    required this.theme,
    this.isLeftColumn = false,
  });

  @override
  pw.Widget build(pw.Context context) {
    if (courses.isEmpty) return pw.SizedBox();

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.SizedBox(height: 20),
        SectionHeader(
            title: 'COURSES', theme: theme, isLeftColumn: isLeftColumn),
        ...courses.map(
          (course) => WidgetCourseItem(course, theme: theme),
        ),
      ],
    );
  }
}
