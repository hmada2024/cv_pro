// features/pdf_export/templates/two_column_02/widgets/experience_item.dart
import 'package:cv_pro/features/cv_form/data/models/cv_data.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../template_02_colors.dart'; // ✅ FIXED IMPORT

class ExperienceItem extends pw.StatelessWidget {
  final Experience experience;
  final pw.Font iconFont;
  final DateFormat formatter = DateFormat('MMM yyyy');
  final PdfColor positionColor;
  final PdfColor companyColor;

  ExperienceItem(
    this.experience, {
    required this.iconFont,
    this.positionColor = PdfColors.black,
    this.companyColor = Template02Colors.darkText, // ✅ FIXED CLASS NAME
  });

  @override
  pw.Widget build(pw.Context context) {
    // ... same content as before, it was correct ...
    final descriptionLines = experience.description
        .split('\n')
        .where((line) => line.trim().isNotEmpty)
        .map((line) => pw.Padding(
              padding: const pw.EdgeInsets.only(bottom: 3),
              child: pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Container(
                    margin: const pw.EdgeInsets.only(top: 3, right: 8),
                    child: pw.Icon(
                      const pw.IconData(0xe834), // Material Icon: check_box
                      font: iconFont,
                      size: 9,
                      color: companyColor,
                    ),
                  ),
                  pw.Expanded(
                    child: pw.Text(
                      line.trim().replaceFirst('•', '').trim(),
                      textAlign: pw.TextAlign.justify,
                      style: const pw.TextStyle(fontSize: 10, lineSpacing: 2),
                    ),
                  ),
                ],
              ),
            ))
        .toList();

    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 16),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Expanded(
                child: pw.Text(
                  experience.position.toUpperCase(),
                  style: pw.TextStyle(
                    fontSize: 12,
                    fontWeight: pw.FontWeight.bold,
                    color: positionColor,
                  ),
                ),
              ),
              pw.SizedBox(width: 10),
              pw.Text(
                '${formatter.format(experience.startDate)} - ${experience.isCurrent ? "Present" : formatter.format(experience.endDate!)}',
                style: const pw.TextStyle(
                    fontSize: 9, color: Template02Colors.darkText), // ✅ FIXED
              ),
            ],
          ),
          pw.Text(
            experience.companyName,
            style: pw.TextStyle(
              fontSize: 11,
              color: companyColor,
              fontStyle: pw.FontStyle.italic,
            ),
          ),
          pw.SizedBox(height: 6),
          ...descriptionLines,
        ],
      ),
    );
  }
}
