// features/pdf_export/templates/two_column_02/template_02_left_column.dart
import 'package:cv_pro/features/cv_form/data/models/cv_data.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'colors_template_02.dart'; // ✅ UPDATED IMPORT
import '../shared/widgets/contact_info_line.dart';
import 'widgets/education_item.dart';
import 'widgets/language_item.dart';
import '../shared/widgets/section_header.dart';
import 'widgets/skill_item.dart';

class Template02LeftColumn extends pw.StatelessWidget { // ✅ UPDATED CLASS NAME
  final CVData data;
  final pw.ImageProvider? profileImage;
  final pw.Font iconFont;

  Template02LeftColumn({ // ✅ UPDATED CONSTRUCTOR
    required this.data,
    this.profileImage,
    required this.iconFont,
  });

  @override
  pw.Widget build(pw.Context context) {
    // ... (rest of the file content from your original `left_column.dart` goes here)
    // I am pasting the full content below to ensure correctness.
    const double avatarRadius = 50;
    final personalInfo = data.personalInfo;
    final DateFormat dateFormatter = DateFormat('d MMMM yyyy');

    final bool hasDetails = personalInfo.birthDate != null ||
        personalInfo.maritalStatus != null ||
        personalInfo.militaryServiceStatus != null;
    
    final sortedEducation = List<Education>.from(data.education)..sort((a, b) {
      final levelComparison = b.level.index.compareTo(a.level.index);
      if (levelComparison != 0) return levelComparison;
      if (a.isCurrent && !b.isCurrent) return -1;
      if (!a.isCurrent && b.isCurrent) return 1;
      if (!a.isCurrent && !b.isCurrent) return b.endDate!.compareTo(a.endDate!);
      return b.startDate.compareTo(a.startDate);
    });

    return pw.Container(
      color: Template02Colors.primary,
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
              titleColor: Template02Colors.lightText,
              lineColor: Template02Colors.accent,
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
                titleColor: Template02Colors.lightText,
                lineColor: Template02Colors.accent,
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

          if (sortedEducation.isNotEmpty)
            SectionHeader(
                title: 'EDUCATION',
                titleColor: Template02Colors.lightText,
                lineColor: Template02Colors.accent,
                fontSize: 14,
                lineWidth: 30),
          ...sortedEducation.map((edu) => EducationItem(edu)),
          if (sortedEducation.isNotEmpty) pw.SizedBox(height: 20),

          if (data.skills.isNotEmpty)
            SectionHeader(
                title: 'SKILLS',
                titleColor: Template02Colors.lightText,
                lineColor: Template02Colors.accent,
                fontSize: 14,
                lineWidth: 30),
          ...data.skills.map((skill) => SkillItem(skill)),
          if (data.skills.isNotEmpty) pw.SizedBox(height: 20),

          if (data.languages.isNotEmpty)
            SectionHeader(
                title: 'LANGUAGES',
                titleColor: Template02Colors.lightText,
                lineColor: Template02Colors.accent,
                fontSize: 14,
                lineWidth: 30),
          ...data.languages.map((lang) => LanguageItem(lang)),
        ],
      ),
    );
  }
}