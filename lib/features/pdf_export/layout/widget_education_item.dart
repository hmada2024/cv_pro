// lib/features/pdf_export/layout/widget_education_item.dart
import 'package:cv_pro/features/cv_form/data/models/cv_data.dart';
import 'package:cv_pro/features/pdf_export/theme_templates/pdf_template_theme.dart';
import 'package:intl/intl.dart';
import 'package:pdf/widgets.dart' as pw;

class EducationItem extends pw.StatelessWidget {
  final Education education;
  final PdfTemplateTheme theme;
  final DateFormat formatter = DateFormat('yyyy');

  EducationItem(this.education, {required this.theme});

  @override
  pw.Widget build(pw.Context context) {
    final dateRange =
        '${formatter.format(education.startDate)} - ${education.isCurrent ? "Present" : formatter.format(education.endDate!)}';

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
                  // التغيير: استخدام نمط العنوان من الثيم
                  style: theme.leftColumnHeader,
                ),
                pw.Text(
                  education.school,
                  // التغيير: استخدام النمط الفرعي من الثيم
                  style: theme.leftColumnSubtext,
                ),
              ],
            ),
          ),
          pw.SizedBox(width: 10),
          pw.Text(
            dateRange.toUpperCase(),
            style: pw.TextStyle(color: theme.accentColor, fontSize: 8),
          ),
        ],
      ),
    );
  }
}
