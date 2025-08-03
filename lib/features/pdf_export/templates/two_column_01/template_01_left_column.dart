// features/pdf_export/templates/two_column_01/template_01_left_column.dart
import 'package:cv_pro/features/cv_form/data/models/cv_data.dart';
import 'package:cv_pro/features/pdf_export/templates/shared/widgets/contact_info_line.dart'; // ✅ UPDATED IMPORT
import 'package:intl/intl.dart';
import 'package:pdf/widgets.dart' as pw;
import 'template_01_colors.dart'; // ✅ UPDATED IMPORT

class Template01LeftColumn extends pw.StatelessWidget { // ✅ UPDATED CLASS NAME
  final CVData data;
  final pw.Font iconFont;

  Template01LeftColumn({ // ✅ UPDATED CONSTRUCTOR
    required this.data,
    required this.iconFont,
  });

  @override
  pw.Widget build(pw.Context context) {
    final personalInfo = data.personalInfo;
    final DateFormat dateFormatter = DateFormat('d MMMM yyyy');

    final bool hasDetails = personalInfo.birthDate != null ||
        personalInfo.maritalStatus != null ||
        personalInfo.militaryServiceStatus != null;

    return pw.Container(
      color: Template01Colors.backgroundDark,
      padding: const pw.EdgeInsets.fromLTRB(20, 25, 20, 20),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          if (personalInfo.summary.isNotEmpty)
            pw.Text(
              'About Me',
              style: pw.TextStyle(
                  color: Template01Colors.lightText,
                  fontSize: 14,
                  fontWeight: pw.FontWeight.bold),
            ),
          if (personalInfo.summary.isNotEmpty)
            pw.Divider(color: Template01Colors.accentBlue, height: 8),
          if (personalInfo.summary.isNotEmpty) pw.SizedBox(height: 8),
          if (personalInfo.summary.isNotEmpty)
            pw.Text(
              personalInfo.summary,
              style: const pw.TextStyle(
                color: Template01Colors.lightText,
                fontSize: 9,
                lineSpacing: 3,
              ),
            ),
          if (personalInfo.summary.isNotEmpty) pw.SizedBox(height: 25),

          pw.Text(
            'Contact',
            style: pw.TextStyle(
                color: Template01Colors.lightText,
                fontSize: 14,
                fontWeight: pw.FontWeight.bold),
          ),
          pw.Divider(color: Template01Colors.accentBlue, height: 8),
          pw.SizedBox(height: 8),
          if (personalInfo.phone != null && personalInfo.phone!.isNotEmpty)
            ContactInfoLine(
              iconData: const pw.IconData(0xe0b0),
              text: personalInfo.phone!,
              iconFont: iconFont,
              textColor: Template01Colors.lightText,
              iconColor: Template01Colors.accentBlue,
            ),
          ContactInfoLine(
            iconData: const pw.IconData(0xe158),
            text: personalInfo.email,
            iconFont: iconFont,
            textColor: Template01Colors.lightText,
            iconColor: Template01Colors.accentBlue,
          ),
          if (personalInfo.address != null && personalInfo.address!.isNotEmpty)
            ContactInfoLine(
              iconData: const pw.IconData(0xe55f),
              text: personalInfo.address!,
              iconFont: iconFont,
              textColor: Template01Colors.lightText,
              iconColor: Template01Colors.accentBlue,
            ),
          pw.SizedBox(height: 25),

          if (hasDetails)
            pw.Text(
              'Personal Details',
              style: pw.TextStyle(
                  color: Template01Colors.lightText,
                  fontSize: 14,
                  fontWeight: pw.FontWeight.bold),
            ),
          if (hasDetails)
            pw.Divider(color: Template01Colors.accentBlue, height: 8),
          if (hasDetails) pw.SizedBox(height: 8),

          if (personalInfo.birthDate != null)
            ContactInfoLine(
              iconData: const pw.IconData(0xe7e9),
              text: dateFormatter.format(personalInfo.birthDate!),
              iconFont: iconFont,
              textColor: Template01Colors.lightText,
              iconColor: Template01Colors.accentBlue,
            ),
          if (personalInfo.maritalStatus != null)
            ContactInfoLine(
              iconData: const pw.IconData(0xe042),
              text: personalInfo.maritalStatus!,
              iconFont: iconFont,
              textColor: Template01Colors.lightText,
              iconColor: Template01Colors.accentBlue,
            ),
          if (personalInfo.militaryServiceStatus != null)
            ContactInfoLine(
              iconData: const pw.IconData(0xe8e8),
              text: personalInfo.militaryServiceStatus!,
              iconFont: iconFont,
              textColor: Template01Colors.lightText,
              iconColor: Template01Colors.accentBlue,
            ),
          if (hasDetails) pw.SizedBox(height: 25),

          if (data.languages.isNotEmpty)
            pw.Text(
              'Language',
              style: pw.TextStyle(
                  color: Template01Colors.lightText,
                  fontSize: 14,
                  fontWeight: pw.FontWeight.bold),
            ),
          if (data.languages.isNotEmpty)
            pw.Divider(color: Template01Colors.accentBlue, height: 8),
          if (data.languages.isNotEmpty) pw.SizedBox(height: 8),
          ...data.languages.map((lang) =>
              _buildListItem('${lang.name} (${lang.proficiency})', iconFont)),
        ],
      ),
    );
  }

  pw.Widget _buildListItem(String text, pw.Font iconFont) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 4),
      child: pw.Row(children: [
        pw.Icon(
          const pw.IconData(0xe834),
          font: iconFont,
          color: Template01Colors.accentBlue,
          size: 10,
        ),
        pw.SizedBox(width: 8),
        pw.Text(
          text,
          style: const pw.TextStyle(
              color: Template01Colors.lightText, fontSize: 10),
        ),
      ]),
    );
  }
}