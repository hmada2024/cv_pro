// lib/features/3_cv_presentation/pdf_generation/shared/widgets/widget_course_item.dart
import 'package:cv_pro/features/2_cv_editor/form/data/models/cv_data.dart';
import 'package:cv_pro/features/3_cv_presentation/pdf_generation/core/pdf_template_theme.dart';
import 'package:intl/intl.dart';
import 'package:pdf/widgets.dart' as pw;

class WidgetCourseItem extends pw.StatelessWidget {
  final Course course;
  final PdfTemplateTheme theme;
  final DateFormat formatter = DateFormat('MMM yyyy');

  WidgetCourseItem(
    this.course, {
    required this.theme,
  });

  @override
  pw.Widget build(pw.Context context) {
    final dateText =
        course.isCurrent ? "Ongoing" : formatter.format(course.completionDate!);

    // Re-use education styles for consistency
    final titleStyle = theme.educationTitleStyle;
    final subtitleStyle = theme.educationSchoolStyle;
    final dateStyle = theme.educationDateStyle;

    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 10),
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Expanded(
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  course.name,
                  style: titleStyle,
                ),
                pw.Text(
                  course.institution,
                  style: subtitleStyle,
                ),
              ],
            ),
          ),
          pw.SizedBox(width: 10),
          pw.Text(
            dateText.toUpperCase(),
            style: dateStyle,
          ),
        ],
      ),
    );
  }
}
