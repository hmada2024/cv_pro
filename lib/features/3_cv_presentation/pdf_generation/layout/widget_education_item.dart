// lib/features/3_cv_presentation/pdf_generation/layout/widget_education_item.dart
import 'package:cv_pro/features/2_cv_editor/form/data/models/cv_data.dart';
import 'package:cv_pro/features/3_cv_presentation/pdf_generation/theme_templates/pdf_template_theme.dart';
import 'package:intl/intl.dart';
import 'package:pdf/widgets.dart' as pw;

class EducationItem extends pw.StatelessWidget {
  final Education education;
  final PdfTemplateTheme theme;
  final bool isLeftColumn;
  final DateFormat formatter = DateFormat('yyyy');

  EducationItem(
    this.education, {
    required this.theme,
    this.isLeftColumn = false,
  });

  @override
  pw.Widget build(pw.Context context) {
    final dateRange =
        '${formatter.format(education.startDate)} - ${education.isCurrent ? "Present" : formatter.format(education.endDate!)}';

    final titleStyle = isLeftColumn
        ? theme.leftColumnHeader.copyWith(fontSize: 11)
        : theme.experienceTitleStyle.copyWith(fontSize: 11);

    final subtitleStyle =
        isLeftColumn ? theme.leftColumnSubtext : theme.leftColumnSubtext;

    final dateStyle = isLeftColumn
        ? theme.leftColumnSubtext.copyWith(fontSize: 9)
        : theme.experienceDateStyle.copyWith(fontSize: 9);

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
                  '${education.level.toDisplayString()} ${education.degreeName}',
                  style: titleStyle,
                ),
                pw.Text(
                  education.school,
                  style: subtitleStyle,
                ),
              ],
            ),
          ),
          pw.SizedBox(width: 10),
          pw.Text(
            dateRange.toUpperCase(),
            style: dateStyle,
          ),
        ],
      ),
    );
  }
}
