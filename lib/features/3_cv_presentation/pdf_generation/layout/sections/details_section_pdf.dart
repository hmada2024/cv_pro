// lib/features/pdf_export/layout/sections/details_section_pdf.dart
import 'package:cv_pro/features/2_cv_editor/form/data/models/cv_data.dart';
import 'package:cv_pro/features/3_cv_presentation/pdf_generation/layout/widget_detail_item_pdf.dart';
import 'package:cv_pro/features/3_cv_presentation/pdf_generation/layout/widget_section_header.dart';
import 'package:cv_pro/features/3_cv_presentation/pdf_generation/core/pdf_template_theme.dart';
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
    final hasDetails = (personalInfo.birthDate != null) ||
        (personalInfo.maritalStatus != null &&
            personalInfo.maritalStatus!.isNotEmpty) ||
        (personalInfo.militaryServiceStatus != null &&
            personalInfo.militaryServiceStatus!.isNotEmpty);

    if (!hasDetails) return pw.SizedBox();

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.SizedBox(height: 20),
        SectionHeader(title: 'DETAILS', theme: theme, isLeftColumn: true),
        if (personalInfo.birthDate != null)
          DetailItemPdf(
              label: 'Birth Date:',
              value: dateFormatter.format(personalInfo.birthDate!),
              theme: theme),
        if (personalInfo.maritalStatus != null &&
            personalInfo.maritalStatus!.isNotEmpty)
          DetailItemPdf(
              label: 'Marital Status:',
              value: personalInfo.maritalStatus!,
              theme: theme),
        if (personalInfo.militaryServiceStatus != null &&
            personalInfo.militaryServiceStatus!.isNotEmpty)
          DetailItemPdf(
              label: 'Military Service:',
              value: personalInfo.militaryServiceStatus!,
              theme: theme),
      ],
    );
  }
}
