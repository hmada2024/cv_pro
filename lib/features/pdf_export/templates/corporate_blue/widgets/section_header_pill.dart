import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class SectionHeaderPill extends pw.StatelessWidget {
  final String title;
  final PdfColor backgroundColor;
  final PdfColor textColor;

  SectionHeaderPill({
    required this.title,
    required this.backgroundColor,
    required this.textColor,
  });

  @override
  pw.Widget build(pw.Context context) {
    return pw.Container(
      padding: const pw.EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      margin: const pw.EdgeInsets.only(bottom: 12),
      decoration: pw.BoxDecoration(
        color: backgroundColor,
        borderRadius: pw.BorderRadius.circular(12),
      ),
      child: pw.Text(
        title.toUpperCase(),
        style: pw.TextStyle(
          color: textColor,
          fontWeight: pw.FontWeight.bold,
          fontSize: 11,
        ),
      ),
    );
  }
}