// lib/features/pdf_export/layout/sections/profile_section_pdf.dart
import 'package:cv_pro/features/form/data/models/cv_data.dart';
import 'package:cv_pro/features/pdf_generation/layout/widget_section_header.dart';
import 'package:cv_pro/features/pdf_generation/theme_templates/pdf_template_theme.dart';
import 'package:pdf/widgets.dart' as pw;

class ProfileSectionPdf extends pw.StatelessWidget {
  final PersonalInfo personalInfo;
  final PdfTemplateTheme theme;

  ProfileSectionPdf({required this.personalInfo, required this.theme});

  @override
  pw.Widget build(pw.Context context) {
    if (personalInfo.summary.isEmpty) return pw.SizedBox();

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.SizedBox(height: 25),
        SectionHeader(title: 'PROFILE', theme: theme),
        pw.Text(
          personalInfo.summary,
          style: theme.body,
          textAlign: pw.TextAlign.justify,
        ),
      ],
    );
  }
}
