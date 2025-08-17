// lib/features/3_cv_presentation/pdf_generation/layout/widget_detail_item_pdf.dart
import 'package:cv_pro/features/3_cv_presentation/pdf_generation/core/pdf_template_theme.dart';
import 'package:pdf/widgets.dart' as pw;

class DetailItemPdf extends pw.StatelessWidget {
  final String label;
  final String value;
  final PdfTemplateTheme theme;

  DetailItemPdf({
    required this.label,
    required this.value,
    required this.theme,
  });

  @override
  pw.Widget build(pw.Context context) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 6),
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.SizedBox(
            width: 75,
            child: pw.Text(
              label,
              style: theme.leftColumnHeader,
            ),
          ),
          pw.SizedBox(width: 8),
          pw.Expanded(
            child: pw.Text(
              value,
              style: theme.leftColumnBody,
            ),
          ),
        ],
      ),
    );
  }
}
