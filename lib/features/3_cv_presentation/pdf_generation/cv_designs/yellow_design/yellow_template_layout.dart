// lib/features/3_cv_presentation/pdf_generation/cv_designs/yellow_design/yellow_template_layout.dart
import 'dart:typed_data';
import 'package:cv_pro/features/2_cv_editor/form/data/models/cv_data.dart';
import 'package:cv_pro/features/3_cv_presentation/pdf_generation/cv_designs/yellow_design/yellow_template_theme.dart';
import 'package:cv_pro/features/3_cv_presentation/pdf_generation/layout/sections/contact_section_pdf.dart';
import 'package:cv_pro/features/3_cv_presentation/pdf_generation/layout/sections/education_section_pdf.dart';
import 'package:cv_pro/features/3_cv_presentation/pdf_generation/layout/sections/experience_section_pdf.dart';
import 'package:cv_pro/features/3_cv_presentation/pdf_generation/layout/sections/profile_section_pdf.dart';
import 'package:cv_pro/features/3_cv_presentation/pdf_generation/layout/sections/skills_section_pdf.dart';
import 'package:cv_pro/features/3_cv_presentation/pdf_generation/theme_templates/pdf_template_theme.dart';
import 'package:pdf/widgets.dart' as pw;

// لوحة البناء الرئيسية للقالب الأصفر
class YellowTemplateLayout extends pw.StatelessWidget {
  final CVData data;
  final pw.Font iconFont;
  final bool showReferencesNote;
  final Uint8List? profileImageData;

  YellowTemplateLayout({
    required this.data,
    required this.iconFont,
    required this.showReferencesNote,
    required this.profileImageData,
  });

  @override
  pw.Widget build(pw.Context context) {
    final theme = yellowTemplateTheme();
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        // العمود الأيسر (الأصفر)
        _buildLeftColumn(theme),
        // العمود الأيمن (الرئيسي)
        _buildRightColumn(theme),
      ],
    );
  }

  pw.Widget _buildLeftColumn(PdfTemplateTheme theme) {
    pw.ImageProvider? profileImage =
        profileImageData != null ? pw.MemoryImage(profileImageData!) : null;

    return pw.Expanded(
      flex: 2, // العمود الأيسر أضيق
      child: pw.Container(
        color: theme.primaryColor,
        padding: const pw.EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            if (profileImage != null)
              pw.Center(
                child: pw.Container(
                  width: 108,
                  height: 108,
                  child: pw.ClipOval(
                    child: pw.Image(profileImage, fit: pw.BoxFit.cover),
                  ),
                ),
              ),
            if (profileImage != null) pw.SizedBox(height: 30),
            // Profile section is on the left in this design
            ProfileSectionPdf(personalInfo: data.personalInfo, theme: theme),
            pw.SizedBox(height: 20),
            ContactSectionPdf(
              personalInfo: data.personalInfo,
              theme: theme,
              iconFont: iconFont,
            ),
            pw.SizedBox(height: 20),
            SkillsSectionPdf(skills: data.skills, theme: theme),
          ],
        ),
      ),
    );
  }

  pw.Widget _buildRightColumn(PdfTemplateTheme theme) {
    return pw.Expanded(
      flex: 4, // العمود الأيمن أوسع
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.stretch,
        children: [
          // رأس أسود يحتوي على الاسم
          pw.Container(
            color: theme.accentColor, // Black color from theme
            padding: const pw.EdgeInsets.fromLTRB(30, 40, 30, 30),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(data.personalInfo.name, style: theme.h1),
                pw.SizedBox(height: 4),
                pw.Text(
                  data.personalInfo.jobTitle,
                  style: theme.body.copyWith(
                    color: theme.lightTextColor.shade(0.7),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          // المحتوى الرئيسي بخلفية بيضاء
          pw.Padding(
            padding: const pw.EdgeInsets.all(30),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                ExperienceSectionPdf(
                  experiences: data.experiences,
                  theme: theme,
                  iconFont: iconFont,
                ),
                pw.SizedBox(height: 10),
                EducationSectionPdf(
                  educationList: data.education,
                  theme: theme,
                  isLeftColumn: false,
                ),
                // Note: References and other sections can be added here if needed
              ],
            ),
          ),
        ],
      ),
    );
  }
}
