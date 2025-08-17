// lib/features/pdf_export/layout/sections/details_section_pdf.dart
import 'package:cv_pro/features/cv_form/data/models/cv_data.dart';
import 'package:cv_pro/features/pdf_export/layout/widget_contact_info_line.dart';
import 'package:cv_pro/features/pdf_export/layout/widget_section_header.dart';
import 'package:cv_pro/features/pdf_export/theme_templates/pdf_template_theme.dart';
import 'package:intl/intl.dart';
import 'package:pdf/widgets.dart' as pw;

class DetailsSectionPdf extends pw.StatelessWidget {
  final PersonalInfo personalInfo;
  final PdfTemplateTheme theme;
  final pw.Font iconFont;

  DetailsSectionPdf({
    required this.personalInfo,
    required this.theme,
    required this.iconFont,
  });

  @override
  pw.Widget build(pw.Context context) {
    final DateFormat dateFormatter = DateFormat('d MMMM yyyy');
    final hasDetails = personalInfo.birthDate != null ||
        personalInfo.maritalStatus != null ||
        personalInfo.militaryServiceStatus != null;

    if (!hasDetails) return pw.SizedBox();

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.SizedBox(height: 20),
        SectionHeader(title: 'DETAILS', theme: theme, isLeftColumn: true),
        if (personalInfo.birthDate != null)
          ContactInfoLine(
              iconData: const pw.IconData(0xe7e9),
              text: dateFormatter.format(personalInfo.birthDate!),
              iconFont: iconFont,
              theme: theme),
        if (personalInfo.maritalStatus != null)
          ContactInfoLine(
              iconData: const pw.IconData(0xe042),
              text: personalInfo.maritalStatus!,
              iconFont: iconFont,
              theme: theme),
        if (personalInfo.militaryServiceStatus != null)
          ContactInfoLine(
              iconData: const pw.IconData(0xe8e8),
              text: personalInfo.militaryServiceStatus!,
              iconFont: iconFont,
              theme: theme),
      ],
    );
  }
}
