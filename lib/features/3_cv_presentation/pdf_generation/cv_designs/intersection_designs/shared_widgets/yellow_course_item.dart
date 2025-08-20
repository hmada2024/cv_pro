// lib/features/3_cv_presentation/pdf_generation/cv_designs/intersection_designs/shared_widgets/yellow_course_item.dart
import 'package:cv_pro/features/2_cv_editor/form/data/models/cv_data.dart';
import 'package:cv_pro/features/3_cv_presentation/pdf_generation/core/pdf_template_theme.dart';
import 'package:intl/intl.dart';
import 'package:pdf/widgets.dart' as pw;

class YellowCourseItem extends pw.StatelessWidget {
  final Course course;
  final PdfTemplateTheme theme;
  final DateFormat formatter = DateFormat('MMM yyyy');

  YellowCourseItem(this.course, {required this.theme});

  @override
  pw.Widget build(pw.Context context) {
    final dateText =
        course.isCurrent ? "Ongoing" : formatter.format(course.completionDate!);

    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 8),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text(
                course.name.toUpperCase(),
                style: theme.educationTitleStyle,
              ),
              pw.Text(
                dateText,
                style: theme.educationDateStyle,
              ),
            ],
          ),
          pw.Text(
            course.institution,
            style: theme.educationSchoolStyle,
          ),
          if (course.description != null && course.description!.isNotEmpty)
            pw.Padding(
              padding: const pw.EdgeInsets.only(top: 4),
              child: pw.Text(
                course.description!,
                style: theme.body,
              ),
            ),
        ],
      ),
    );
  }
}
