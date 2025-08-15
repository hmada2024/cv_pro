// features/pdf_export/layout/widget_education_item.dart
import 'package:cv_pro/features/cv_form/data/models/cv_data.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'pdf_layout_colors.dart';

class EducationItem extends pw.StatelessWidget {
  final Education education;
  final DateFormat formatter = DateFormat('yyyy');

  EducationItem(this.education);

  String _educationLevelToString(EducationLevel level) {
    switch (level) {
      case EducationLevel.bachelor:
        return "Bachelor";
      case EducationLevel.master:
        return "Master";
      case EducationLevel.doctor:
        return 'Doctorate';
    }
  }

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
                  '${_educationLevelToString(education.level)} ${education.degreeName}',
                  style: pw.TextStyle(
                      color: PdfColors.white,
                      fontSize: 10,
                      fontWeight: pw.FontWeight.bold),
                ),
                pw.Text(
                  education.school,
                  style: const pw.TextStyle(
                      color: PdfLayoutColors.lightText, fontSize: 9),
                ),
              ],
            ),
          ),
          pw.SizedBox(width: 10),
          pw.Text(
            dateRange.toUpperCase(),
            style:
                const pw.TextStyle(color: PdfLayoutColors.accent, fontSize: 8),
          ),
        ],
      ),
    );
  }
}
