import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class SectionHeader extends pw.StatelessWidget {
  final String title;
  final PdfColor titleColor;
  final PdfColor lineColor;
  final double fontSize;
  final double lineWidth;

  SectionHeader({
    required this.title,
    required this.titleColor,
    required this.lineColor,
    this.fontSize = 16,
    this.lineWidth = 50,
  });

  @override
  pw.Widget build(pw.Context context) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          title.toUpperCase(),
          style: pw.TextStyle(
            color: titleColor,
            fontWeight: pw.FontWeight.bold,
            fontSize: fontSize,
          ),
        ),
        pw.Container(
          height: 2,
          width: lineWidth,
          color: lineColor,
          margin: const pw.EdgeInsets.only(top: 4, bottom: 12),
        ),
      ],
    );
  }
}
