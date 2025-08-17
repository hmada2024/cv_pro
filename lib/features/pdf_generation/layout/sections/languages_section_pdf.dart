// lib/features/pdf_export/layout/sections/languages_section_pdf.dart
import 'package:cv_pro/features/cv_form/data/models/cv_data.dart';
import 'package:cv_pro/features/pdf_generation/layout/widget_language_item.dart';
import 'package:cv_pro/features/pdf_generation/layout/widget_section_header.dart';
import 'package:cv_pro/features/pdf_generation/theme_templates/pdf_template_theme.dart';
import 'package:pdf/widgets.dart' as pw;

class LanguagesSectionPdf extends pw.StatelessWidget {
  final List<Language> languages;
  final PdfTemplateTheme theme;

  LanguagesSectionPdf({required this.languages, required this.theme});

  @override
  pw.Widget build(pw.Context context) {
    if (languages.isEmpty) return pw.SizedBox();

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.SizedBox(height: 20),
        // التغيير: تمرير isLeftColumn بشكل صريح
        SectionHeader(title: 'LANGUAGES', theme: theme, isLeftColumn: true),
        ...languages.map((lang) => LanguageItem(lang, theme: theme)),
      ],
    );
  }
}
