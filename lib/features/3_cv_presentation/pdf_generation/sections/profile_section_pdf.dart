// lib/features/3_cv_presentation/pdf_generation/layout/sections/profile_section_pdf.dart
import 'package:cv_pro/features/2_cv_editor/form/data/models/cv_data.dart';
import 'package:cv_pro/features/3_cv_presentation/pdf_generation/widgets/widget_section_header.dart';
import 'package:cv_pro/features/3_cv_presentation/pdf_generation/core/pdf_template_theme.dart';
import 'package:pdf/widgets.dart' as pw;

class ProfileSectionPdf extends pw.StatelessWidget {
  final PersonalInfo personalInfo;
  final PdfTemplateTheme theme;
  final bool isLeftColumn;

  ProfileSectionPdf({
    required this.personalInfo,
    required this.theme,
    this.isLeftColumn = false,
  });

  @override
  pw.Widget build(pw.Context context) {
    if (personalInfo.summary.isEmpty) return pw.SizedBox();

    final bodyStyle = isLeftColumn ? theme.leftColumnBody : theme.body;

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.SizedBox(height: 25),
        SectionHeader(
            title: 'PROFILE', theme: theme, isLeftColumn: isLeftColumn),
        pw.Text(
          personalInfo.summary,
          style: bodyStyle,
          textAlign: pw.TextAlign.justify,
        ),
      ],
    );
  }
}
