// lib/features/pdf_export/layout/widget_section_header.dart
import 'package:cv_pro/features/pdf_export/theme_templates/pdf_template_theme.dart';
import 'package:pdf/widgets.dart' as pw;

class SectionHeader extends pw.StatelessWidget {
  final String title;
  final PdfTemplateTheme theme;
  final bool isLeftColumn;

  SectionHeader({
    required this.title,
    required this.theme,
    this.isLeftColumn = false,
  });

  @override
  pw.Widget build(pw.Context context) {
    // التغيير: اختيار النمط المناسب من الثيم بناءً على isLeftColumn
    final pw.TextStyle titleStyle =
        isLeftColumn ? theme.leftColumnHeader : theme.h2;
    final double lineWidth = isLeftColumn ? 30 : 50;

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          title.toUpperCase(),
          style: titleStyle.copyWith(fontWeight: pw.FontWeight.bold),
        ),
        pw.Container(
          height: 2,
          width: lineWidth,
          color: theme.accentColor,
          margin: const pw.EdgeInsets.only(top: 4, bottom: 12),
        ),
      ],
    );
  }
}
