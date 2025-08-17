// lib/features/pdf_export/layout/sections/contact_section_pdf.dart
import 'package:cv_pro/features/cv_form/data/models/cv_data.dart';
import 'package:cv_pro/features/pdf_generation/layout/widget_contact_info_line.dart';
import 'package:cv_pro/features/pdf_generation/layout/widget_section_header.dart';
import 'package:cv_pro/features/pdf_generation/theme_templates/pdf_template_theme.dart';
import 'package:pdf/widgets.dart' as pw;

class ContactSectionPdf extends pw.StatelessWidget {
  final PersonalInfo personalInfo;
  final PdfTemplateTheme theme;
  final pw.Font iconFont;

  ContactSectionPdf({
    required this.personalInfo,
    required this.theme,
    required this.iconFont,
  });

  @override
  pw.Widget build(pw.Context context) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        // التغيير: تمرير isLeftColumn بشكل صريح
        SectionHeader(title: 'CONTACT', theme: theme, isLeftColumn: true),
        if (personalInfo.phone != null && personalInfo.phone!.isNotEmpty)
          ContactInfoLine(
              iconData: const pw.IconData(0xe0b0),
              text: personalInfo.phone!,
              iconFont: iconFont,
              theme: theme),
        ContactInfoLine(
            iconData: const pw.IconData(0xe158),
            text: personalInfo.email,
            iconFont: iconFont,
            theme: theme),
        if (personalInfo.address != null && personalInfo.address!.isNotEmpty)
          ContactInfoLine(
              iconData: const pw.IconData(0xe55f),
              text: personalInfo.address!,
              iconFont: iconFont,
              theme: theme),
      ],
    );
  }
}
