// lib/features/3_cv_presentation/pdf_generation/layout/widget_language_item.dart
import 'package:cv_pro/features/2_cv_editor/form/data/models/cv_data.dart';
import 'package:cv_pro/features/3_cv_presentation/pdf_generation/theme_templates/pdf_template_theme.dart';
import 'package:pdf/widgets.dart' as pw;

class LanguageItem extends pw.StatelessWidget {
  final Language language;
  final PdfTemplateTheme theme;

  LanguageItem(this.language, {required this.theme});

  @override
  pw.Widget build(pw.Context context) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 4),
      child: pw.Text(
        '${language.name} (${language.proficiency})',
        style: theme.leftColumnBody,
      ),
    );
  }
}
