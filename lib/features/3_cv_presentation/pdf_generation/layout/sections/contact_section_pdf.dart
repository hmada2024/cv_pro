// lib/features/3_cv_presentation/pdf_generation/layout/sections/contact_section_pdf.dart
import 'package:cv_pro/features/2_cv_editor/form/data/models/cv_data.dart';
import 'package:cv_pro/features/3_cv_presentation/pdf_generation/layout/widget_contact_info_line.dart';
import 'package:cv_pro/features/3_cv_presentation/pdf_generation/layout/widget_section_header.dart';
import 'package:cv_pro/features/3_cv_presentation/pdf_generation/core/pdf_template_theme.dart';
import 'package:pdf/widgets.dart' as pw;

class ContactSectionPdf extends pw.StatelessWidget {
  final PersonalInfo personalInfo;
  final PdfTemplateTheme theme;
  final pw.Font iconFont;
  final bool isLeftColumn;

  ContactSectionPdf({
    required this.personalInfo,
    required this.theme,
    required this.iconFont,
    this.isLeftColumn = false,
  });

  @override
  pw.Widget build(pw.Context context) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        SectionHeader(
            title: 'CONTACT', theme: theme, isLeftColumn: isLeftColumn),
        if (personalInfo.phone != null && personalInfo.phone!.isNotEmpty)
          ContactInfoLine(
            iconData: const pw.IconData(0xe0b0),
            text: personalInfo.phone!,
            iconFont: iconFont,
            theme: theme,
            isLeftColumn: isLeftColumn,
          ),
        ContactInfoLine(
          iconData: const pw.IconData(0xe158),
          text: personalInfo.email,
          iconFont: iconFont,
          theme: theme,
          isLeftColumn: isLeftColumn,
        ),
        if (personalInfo.address != null && personalInfo.address!.isNotEmpty)
          ContactInfoLine(
            iconData: const pw.IconData(0xe55f),
            text: personalInfo.address!,
            iconFont: iconFont,
            theme: theme,
            isLeftColumn: isLeftColumn,
          ),
      ],
    );
  }
}
