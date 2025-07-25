import 'package:cv_pro/features/cv_form/data/models/cv_data.dart';
import 'package:pdf/widgets.dart' as pw;
import '../creative/widgets/contact_info_line.dart';
import '../creative/widgets/section_header.dart';
import 'corporate_blue_template_colors.dart';

class CorporateBlueLeftColumn extends pw.StatelessWidget {
  final CVData data;
  final pw.Font iconFont;

  CorporateBlueLeftColumn({
    required this.data,
    required this.iconFont,
  });

  @override
  pw.Widget build(pw.Context context) {
    return pw.Container(
      color: CorporateBlueColors.backgroundDark,
      padding: const pw.EdgeInsets.all(20),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          // About Me
          SectionHeader(
            title: 'ABOUT ME',
            titleColor: CorporateBlueColors.lightText,
            lineColor: CorporateBlueColors.accentBlue,
          ),
          pw.Text(
            data.personalInfo.summary,
            style: const pw.TextStyle(
              color: CorporateBlueColors.lightText,
              fontSize: 9,
              lineSpacing: 3,
            ),
          ),
          pw.SizedBox(height: 25),

          // Contact
          if (data.personalInfo.phone != null &&
              data.personalInfo.phone!.isNotEmpty)
            ContactInfoLine(
              iconData: const pw.IconData(0xe0b0),
              text: data.personalInfo.phone!,
              iconFont: iconFont,
              textColor: CorporateBlueColors.lightText,
              iconColor: CorporateBlueColors.accentBlue,
            ),
          ContactInfoLine(
            iconData: const pw.IconData(0xe158),
            text: data.personalInfo.email,
            iconFont: iconFont,
            textColor: CorporateBlueColors.lightText,
            iconColor: CorporateBlueColors.accentBlue,
          ),
          if (data.personalInfo.address != null &&
              data.personalInfo.address!.isNotEmpty)
            ContactInfoLine(
              iconData: const pw.IconData(0xe55f),
              text: data.personalInfo.address!,
              iconFont: iconFont,
              textColor: CorporateBlueColors.lightText,
              iconColor: CorporateBlueColors.accentBlue,
            ),
          pw.SizedBox(height: 25),

          // Languages
          if (data.languages.isNotEmpty)
            SectionHeader(
              title: 'LANGUAGE',
              titleColor: CorporateBlueColors.lightText,
              lineColor: CorporateBlueColors.accentBlue,
            ),
          ...data.languages.map((lang) => pw.Padding(
                padding: const pw.EdgeInsets.only(bottom: 4),
                child: pw.Text(
                  '•  ${lang.name} (${lang.proficiency})',
                  style: const pw.TextStyle(
                      color: CorporateBlueColors.lightText, fontSize: 10),
                ),
              )),
          pw.SizedBox(height: 25),

          // Skills / Expertise
          if (data.skills.isNotEmpty)
            SectionHeader(
              title: 'EXPERTISE',
              titleColor: CorporateBlueColors.lightText,
              lineColor: CorporateBlueColors.accentBlue,
            ),
          ...data.skills.map((skill) => pw.Padding(
                padding: const pw.EdgeInsets.only(bottom: 4),
                child: pw.Text(
                  '•  ${skill.name}',
                  style: const pw.TextStyle(
                      color: CorporateBlueColors.lightText, fontSize: 10),
                ),
              )),
        ],
      ),
    );
  }
}
