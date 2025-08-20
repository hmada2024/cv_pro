// lib\features\3_cv_presentation\pdf_generation\cv_designs\formal_single_column\widget_formal_section_header.dart
import 'package:cv_pro/features/3_cv_presentation/pdf_generation/core/pdf_template_theme.dart';
import 'package:pdf/widgets.dart' as pw;

class FormalSectionHeader extends pw.StatelessWidget {
  final String title;
  final PdfTemplateTheme theme;

  FormalSectionHeader({required this.title, required this.theme});

  @override
  pw.Widget build(pw.Context context) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          title.toUpperCase(),
          style: theme.h2.copyWith(fontWeight: pw.FontWeight.bold),
        ),
        pw.Container(
          height: 1.5,
          color: theme.accentColor,
          margin: const pw.EdgeInsets.only(top: 4, bottom: 12),
        ),
      ],
    );
  }
}
