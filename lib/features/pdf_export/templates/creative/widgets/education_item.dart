import 'package:cv_pro/features/cv_form/data/models/cv_data.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart'; // ✅✅ تم التصحيح: استيراد مكتبة pdf.dart
import 'package:pdf/widgets.dart' as pw;
import '../creative_template_colors.dart';

class EducationItem extends pw.StatelessWidget {
  final Education education;
  final DateFormat formatter = DateFormat('yyyy');

  EducationItem(this.education);

  @override
  pw.Widget build(pw.Context context) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 10),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            '${formatter.format(education.startDate)} - ${formatter.format(education.endDate)}',
            style: const pw.TextStyle(color: ModernTemplateColors.accent, fontSize: 8),
          ),
          pw.Text(
            education.degree,
            style: pw.TextStyle(
                // ✅✅ تم التصحيح: إزالة البادئة pw. ✅✅
                color: PdfColors.white,
                fontSize: 10,
                fontWeight: pw.FontWeight.bold),
          ),
          pw.Text(
            education.school,
            style: const pw.TextStyle(color: ModernTemplateColors.lightText, fontSize: 9),
          ),
        ],
      ),
    );
  }
}