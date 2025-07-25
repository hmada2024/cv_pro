import 'package:cv_pro/features/cv_form/data/models/cv_data.dart';
import 'package:pdf/widgets.dart' as pw;
import 'modern_template_colors.dart';
import 'widgets/contact_info_line.dart';
import 'widgets/education_item.dart';
import 'widgets/language_item.dart';
import 'widgets/section_header.dart';
import 'widgets/skill_item.dart';

class LeftColumn extends pw.StatelessWidget {
  final CVData data;
  final pw.ImageProvider? profileImage;
  final pw.Font iconFont;

  LeftColumn({
    required this.data,
    this.profileImage,
    required this.iconFont,
  });

  @override
  pw.Widget build(pw.Context context) {
    return pw.Container(
      color: ModernTemplateColors.primary,
      padding: const pw.EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          if (profileImage != null)
            pw.ClipOval(
              child: pw.Container(
                width: 100,
                height: 100,
                child: pw.Image(profileImage!, fit: pw.BoxFit.cover),
              ),
            ),
          if (profileImage != null) pw.SizedBox(height: 25),

          // ✅✅ تم التحديث: استخدام SectionHeader الجديد ✅✅
          SectionHeader(
              title: 'CONTACT',
              titleColor: ModernTemplateColors.lightText,
              lineColor: ModernTemplateColors.accent,
              fontSize: 14,
              lineWidth: 30),
          if (data.personalInfo.phone != null &&
              data.personalInfo.phone!.isNotEmpty)
            ContactInfoLine(
                iconData: const pw.IconData(0xe0b0),
                text: data.personalInfo.phone!,
                iconFont: iconFont),
          ContactInfoLine(
              iconData: const pw.IconData(0xe158),
              text: data.personalInfo.email,
              iconFont: iconFont),
          if (data.personalInfo.address != null &&
              data.personalInfo.address!.isNotEmpty)
            ContactInfoLine(
                iconData: const pw.IconData(0xe55f),
                text: data.personalInfo.address!,
                iconFont: iconFont),
          pw.SizedBox(height: 20),

          if (data.education.isNotEmpty)
            SectionHeader(
                title: 'EDUCATION',
                titleColor: ModernTemplateColors.lightText,
                lineColor: ModernTemplateColors.accent,
                fontSize: 14,
                lineWidth: 30),
          ...data.education.map((edu) => EducationItem(edu)),
          pw.SizedBox(height: 20),

          if (data.skills.isNotEmpty)
            SectionHeader(
                title: 'SKILLS',
                titleColor: ModernTemplateColors.lightText,
                lineColor: ModernTemplateColors.accent,
                fontSize: 14,
                lineWidth: 30),
          ...data.skills.map((skill) => SkillItem(skill.name)),
          pw.SizedBox(height: 20),

          if (data.languages.isNotEmpty)
            SectionHeader(
                title: 'LANGUAGES',
                titleColor: ModernTemplateColors.lightText,
                lineColor: ModernTemplateColors.accent,
                fontSize: 14,
                lineWidth: 30),
          ...data.languages.map((lang) => LanguageItem(lang)),
        ],
      ),
    );
  }
}