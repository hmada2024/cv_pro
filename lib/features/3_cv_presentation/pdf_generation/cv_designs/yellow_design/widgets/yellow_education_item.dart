// lib/features/3_cv_presentation/pdf_generation/cv_designs/yellow_design/widgets/yellow_education_item.dart
import 'package:cv_pro/features/2_cv_editor/form/data/models/cv_data.dart';
import 'package:cv_pro/features/3_cv_presentation/pdf_generation/core/pdf_template_theme.dart';
import 'package:intl/intl.dart';
import 'package:pdf/widgets.dart' as pw;

class YellowEducationItem extends pw.StatelessWidget {
  final Education education;
  final PdfTemplateTheme theme;
  final DateFormat formatter = DateFormat('yyyy');

  YellowEducationItem(this.education, {required this.theme});

  @override
  pw.Widget build(pw.Context context) {
    final dateRange =
        '${formatter.format(education.startDate)} - ${education.isCurrent ? "Present" : formatter.format(education.endDate!)}';

    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 8),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text(
                '${education.level.toDisplayString().toUpperCase()} ${education.degreeName.toUpperCase()}',
                style: theme.educationTitleStyle,
              ),
              pw.Text(
                dateRange,
                style: theme.educationDateStyle,
              ),
            ],
          ),
          pw.Text(
            education.school,
            style: theme.educationSchoolStyle,
          ),
        ],
      ),
    );
  }
}
