// lib/features/3_cv_presentation/pdf_generation/cv_designs/yellow_design/widgets/yellow_section_header.dart
import 'package:cv_pro/features/3_cv_presentation/pdf_generation/core/pdf_template_theme.dart';
import 'package:pdf/widgets.dart' as pw;

class YellowSectionHeader extends pw.StatelessWidget {
  final String title;
  final PdfTemplateTheme theme;

  YellowSectionHeader({
    required this.title,
    required this.theme,
  });

  @override
  pw.Widget build(pw.Context context) {
    // Simplified to match the target design: just a title and a divider
    final titleStyle =
        title == 'PROFILE' || title == 'CONTACT' || title == 'SKILLS'
            ? theme.leftColumnHeader
            : theme.h2;

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          title.toUpperCase(),
          style: titleStyle,
        ),
        pw.SizedBox(height: 4),
        pw.Divider(
          height: 1.5,
          thickness: 1.5,
          color: theme.darkTextColor,
        ),
        pw.SizedBox(height: 12),
      ],
    );
  }
}
