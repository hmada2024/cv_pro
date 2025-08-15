// features/pdf_export/layout/pdf_left_column.dart
import 'package:cv_pro/features/cv_form/data/models/cv_data.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'pdf_layout_colors.dart';
import 'widget_contact_info_line.dart';
import 'widget_education_item.dart';
import 'widget_language_item.dart';
import 'widget_section_header.dart';
import 'widget_skill_item.dart';

class PdfLeftColumn extends pw.StatelessWidget {
  final CVData data;
  final pw.ImageProvider? profileImage;
  final pw.Font iconFont;

  PdfLeftColumn({
    required this.data,
    this.profileImage,
    required this.iconFont,
  });

  pw.Widget _buildLicenseSection(PersonalInfo info, pw.Font iconFont) {
    List<String> licenseTexts = [];
    switch (info.licenseType) {
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

    if (licenseTexts.isEmpty) {
      return pw.SizedBox();
    }

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.SizedBox(height: 20),
        SectionHeader(
            title: 'LICENSE',
            titleColor: PdfLayoutColors.lightText,
            lineColor: PdfLayoutColors.accent,
            fontSize: 14,
            lineWidth: 30),
        ...licenseTexts.map(
          (text) => ContactInfoLine(
            iconData: const pw.IconData(0xe1d7),
            text: text,
            iconFont: iconFont,
          ),
        ),
      ],
    );
  }

  @override
  pw.Widget build(pw.Context context) {
    const double avatarRadius = 50;
    final personalInfo = data.personalInfo;
    final DateFormat dateFormatter = DateFormat('d MMMM yyyy');

    final bool hasDetails = personalInfo.birthDate != null ||
        personalInfo.maritalStatus != null ||
        personalInfo.militaryServiceStatus != null;

    return pw.Container(
      color: PdfLayoutColors.primary,
      padding: const pw.EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          if (profileImage != null)
            pw.Center(
              child: pw.Container(
                width: (avatarRadius + 4) * 2,
                height: (avatarRadius + 4) * 2,
                decoration: const pw.BoxDecoration(
                  color: PdfColors.white,
                  shape: pw.BoxShape.circle,
                ),
                child: pw.Padding(
                  padding: const pw.EdgeInsets.all(4),
                  child: pw.ClipOval(
                    child: pw.Image(profileImage!, fit: pw.BoxFit.cover),
                  ),
                ),
              ),
            ),
          if (profileImage != null) pw.SizedBox(height: 25),
          SectionHeader(
              title: 'CONTACT',
              titleColor: PdfLayoutColors.lightText,
              lineColor: PdfLayoutColors.accent,
              fontSize: 14,
              lineWidth: 30),
          if (personalInfo.phone != null && personalInfo.phone!.isNotEmpty)
            ContactInfoLine(
                iconData: const pw.IconData(0xe0b0),
                text: personalInfo.phone!,
                iconFont: iconFont),
          ContactInfoLine(
              iconData: const pw.IconData(0xe158),
              text: personalInfo.email,
              iconFont: iconFont),
          if (personalInfo.address != null && personalInfo.address!.isNotEmpty)
            ContactInfoLine(
                iconData: const pw.IconData(0xe55f),
                text: personalInfo.address!,
                iconFont: iconFont),
          pw.SizedBox(height: 20),
          if (hasDetails)
            SectionHeader(
                title: 'DETAILS',
                titleColor: PdfLayoutColors.lightText,
                lineColor: PdfLayoutColors.accent,
                fontSize: 14,
                lineWidth: 30),
          if (personalInfo.birthDate != null)
            ContactInfoLine(
                iconData: const pw.IconData(0xe7e9),
                text: dateFormatter.format(personalInfo.birthDate!),
                iconFont: iconFont),
          if (personalInfo.maritalStatus != null)
            ContactInfoLine(
                iconData: const pw.IconData(0xe042),
                text: personalInfo.maritalStatus!,
                iconFont: iconFont),
          if (personalInfo.militaryServiceStatus != null)
            ContactInfoLine(
                iconData: const pw.IconData(0xe8e8),
                text: personalInfo.militaryServiceStatus!,
                iconFont: iconFont),
          if (hasDetails) pw.SizedBox(height: 20),
          if (data.education.isNotEmpty)
            SectionHeader(
                title: 'EDUCATION',
                titleColor: PdfLayoutColors.lightText,
                lineColor: PdfLayoutColors.accent,
                fontSize: 14,
                lineWidth: 30),
          ...data.education.map((edu) => EducationItem(edu)),
          if (data.education.isNotEmpty) pw.SizedBox(height: 20),
          if (data.skills.isNotEmpty)
            SectionHeader(
                title: 'SKILLS',
                titleColor: PdfLayoutColors.lightText,
                lineColor: PdfLayoutColors.accent,
                fontSize: 14,
                lineWidth: 30),
          ...data.skills.map((skill) => SkillItem(skill)),
          if (data.skills.isNotEmpty) pw.SizedBox(height: 20),
          if (data.languages.isNotEmpty)
            SectionHeader(
                title: 'LANGUAGES',
                titleColor: PdfLayoutColors.lightText,
                lineColor: PdfLayoutColors.accent,
                fontSize: 14,
                lineWidth: 30),
          ...data.languages.map((lang) => LanguageItem(lang)),
          if (personalInfo.hasDriverLicense)
            _buildLicenseSection(personalInfo, iconFont),
        ],
      ),
    );
  }
}
