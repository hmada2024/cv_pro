import 'package:cv_pro/features/cv_form/data/models/cv_data.dart';
import 'package:cv_pro/features/pdf_export/templates/corporate_blue/corporate_blue_template_colors.dart';
import 'package:cv_pro/features/pdf_export/templates/creative/widgets/contact_info_line.dart';
import 'package:pdf/widgets.dart' as pw;

class CorporateBlueLeftColumn extends pw.StatelessWidget {
  final CVData data;
  final pw.Font iconFont;

  CorporateBlueLeftColumn({
    required this.data,
    required this.iconFont,
  });

  @override
  pw.Widget build(pw.Context context) {
    // Add a top padding to align content below the overflowing avatar
    return pw.Container(
      color: CorporateBlueColors.backgroundDark,
      padding: const pw.EdgeInsets.fromLTRB(20, 40, 20, 20),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          // About Me
          pw.Text(
            'About Me',
            style: pw.TextStyle(
                color: CorporateBlueColors.lightText,
                fontSize: 14,
                fontWeight: pw.FontWeight.bold),
          ),
          pw.Divider(color: CorporateBlueColors.accentBlue, height: 8),
          pw.SizedBox(height: 8),
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

          // ✅ UPDATED: Use a border instead of a pill for a cleaner look on dark bg
          if (data.languages.isNotEmpty)
            pw.Text(
              'Language',
              style: pw.TextStyle(
                  color: CorporateBlueColors.lightText,
                  fontSize: 14,
                  fontWeight: pw.FontWeight.bold),
            ),
          if (data.languages.isNotEmpty)
             pw.Divider(color: CorporateBlueColors.accentBlue, height: 8),
          if (data.languages.isNotEmpty) pw.SizedBox(height: 8),
          ...data.languages.map((lang) => _buildListItem(
              '${lang.name} (${lang.proficiency})', iconFont)),
          pw.SizedBox(height: 25),

          // Expertise
          if (data.skills.isNotEmpty)
            pw.Text(
              'Expertise',
              style: pw.TextStyle(
                  color: CorporateBlueColors.lightText,
                  fontSize: 14,
                  fontWeight: pw.FontWeight.bold),
            ),
           if (data.skills.isNotEmpty)
             pw.Divider(color: CorporateBlueColors.accentBlue, height: 8),
           if (data.skills.isNotEmpty) pw.SizedBox(height: 8),
          ...data.skills.map((skill) => _buildListItem(skill.name, iconFont)),
        ],
      ),
    );
  }

  pw.Widget _buildListItem(String text, pw.Font iconFont) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 4),
      child: pw.Row(children: [
        pw.Icon(
          const pw.IconData(0xe834), // check_box icon
          font: iconFont,
          color: CorporateBlueColors.accentBlue,
          size: 10,
        ),
        pw.SizedBox(width: 8),
        pw.Text(
          text,
          style: const pw.TextStyle(
              color: CorporateBlueColors.lightText, fontSize: 10),
        ),
      ]),
    );
  }
}