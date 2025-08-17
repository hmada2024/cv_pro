// lib/features/3_cv_presentation/pdf_generation/layout/sections/languages_section_pdf.dart
import 'package:cv_pro/features/2_cv_editor/form/data/models/cv_data.dart';
import 'package:cv_pro/features/3_cv_presentation/pdf_generation/widgets/widget_language_item.dart';
import 'package:cv_pro/features/3_cv_presentation/pdf_generation/widgets/widget_section_header.dart';
import 'package:cv_pro/features/3_cv_presentation/pdf_generation/core/pdf_template_theme.dart';
import 'package:pdf/widgets.dart' as pw;

class LanguagesSectionPdf extends pw.StatelessWidget {
  final List<Language> languages;
  final PdfTemplateTheme theme;
  final bool isLeftColumn;

  LanguagesSectionPdf({
    required this.languages,
    required this.theme,
    this.isLeftColumn = false,
  });

  @override
  pw.Widget build(pw.Context context) {
    if (languages.isEmpty) return pw.SizedBox();

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.SizedBox(height: 20),
        SectionHeader(
            title: 'LANGUAGES', theme: theme, isLeftColumn: isLeftColumn),
        ...languages.map((lang) =>
            LanguageItem(lang, theme: theme, isLeftColumn: isLeftColumn)),
      ],
    );
  }
}
