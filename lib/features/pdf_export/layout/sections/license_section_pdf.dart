// lib/features/pdf_export/layout/sections/license_section_pdf.dart
import 'package:cv_pro/features/cv_form/data/models/cv_data.dart';
import 'package:cv_pro/features/pdf_export/layout/widget_contact_info_line.dart';
import 'package:cv_pro/features/pdf_export/layout/widget_section_header.dart';
import 'package:cv_pro/features/pdf_export/theme_templates/pdf_template_theme.dart';
import 'package:pdf/widgets.dart' as pw;

class LicenseSectionPdf extends pw.StatelessWidget {
  final PersonalInfo personalInfo;
  final PdfTemplateTheme theme;
  final pw.Font iconFont;

  LicenseSectionPdf({
    required this.personalInfo,
    required this.theme,
    required this.iconFont,
  });

  @override
  pw.Widget build(pw.Context context) {
    if (!personalInfo.hasDriverLicense) return pw.SizedBox();

    List<String> licenseTexts = [];
    switch (personalInfo.licenseType) {
      case LicenseType.local:
        licenseTexts.add('Local Driving License');
        break;
      case LicenseType.international:
        licenseTexts.add('International Driving License');
        break;
      case LicenseType.both:
        licenseTexts.add('Local Driving License');
        licenseTexts.add('International Driving License');
        break;
      case LicenseType.none:
        break;
    }

    if (licenseTexts.isEmpty) return pw.SizedBox();

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.SizedBox(height: 20),
        SectionHeader(title: 'LICENSE', theme: theme, isLeftColumn: true),
        ...licenseTexts.map(
          (text) => ContactInfoLine(
            iconData: const pw.IconData(0xe1d7),
            text: text,
            iconFont: iconFont,
            theme: theme,
          ),
        ),
      ],
    );
  }
}
