import 'package:cv_pro/features/cv_form/data/models/cv_data.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../creative_template_colors.dart';

class ExperienceItem extends pw.StatelessWidget {
  final Experience experience;
  final DateFormat formatter = DateFormat('MMM yyyy');
  // ✅✅ تم التحديث: إضافة مرونة في الألوان ✅✅
  final PdfColor positionColor;
  final PdfColor companyColor;

  ExperienceItem(
    this.experience, {
    // ✅✅ تم التحديث: قيم افتراضية للحفاظ على التوافقية ✅✅
    this.positionColor = PdfColors.black,
    this.companyColor = ModernTemplateColors.darkText,
  });

  @override
  pw.Widget build(pw.Context context) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 16),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text(
                experience.position.toUpperCase(),
                style: pw.TextStyle(
                  fontSize: 12,
                  fontWeight: pw.FontWeight.bold,
                  color: positionColor, // استخدام اللون الممرر
                ),
              ),
              pw.Text(
                '${formatter.format(experience.startDate)} - ${formatter.format(experience.endDate)}',
                style: const pw.TextStyle(
                    fontSize: 9, color: ModernTemplateColors.darkText),
              ),
            ],
          ),
          pw.Text(
            experience.companyName,
            style: pw.TextStyle(
              fontSize: 11,
              color: companyColor, // استخدام اللون الممرر
              fontStyle: pw.FontStyle.italic,
            ),
          ),
          pw.SizedBox(height: 6),
          pw.Text(
            experience.description,
            textAlign: pw.TextAlign.justify,
            style: const pw.TextStyle(fontSize: 10, lineSpacing: 2),
          ),
        ],
      ),
    );
  }
}
