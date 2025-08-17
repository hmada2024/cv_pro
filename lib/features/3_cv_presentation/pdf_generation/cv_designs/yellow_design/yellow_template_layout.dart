// lib/features/3_cv_presentation/pdf_generation/cv_designs/yellow_design/yellow_template_layout.dart
import 'dart:typed_data';
import 'package:cv_pro/features/2_cv_editor/form/data/models/cv_data.dart';
import 'package:cv_pro/features/3_cv_presentation/pdf_generation/cv_designs/yellow_design/yellow_template_theme.dart';
import 'package:cv_pro/features/3_cv_presentation/pdf_generation/cv_designs/yellow_design/widgets/yellow_education_item.dart';
import 'package:cv_pro/features/3_cv_presentation/pdf_generation/cv_designs/yellow_design/widgets/yellow_experience_item.dart';
import 'package:cv_pro/features/3_cv_presentation/pdf_generation/cv_designs/yellow_design/widgets/yellow_section_header.dart';
import 'package:cv_pro/features/3_cv_presentation/pdf_generation/cv_designs/yellow_design/widgets/yellow_skill_item.dart';
import 'package:cv_pro/features/3_cv_presentation/pdf_generation/core/pdf_template_layout_contract.dart'; // استيراد العقد
import 'package:cv_pro/features/3_cv_presentation/pdf_generation/shared/widgets/widget_contact_info_line.dart';
import 'package:cv_pro/features/3_cv_presentation/pdf_generation/core/pdf_template_theme.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class YellowTemplateLayout extends PdfTemplateLayout {
  // تعديل: يرث من العقد
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

  // تطبيق العقد: كل قالب يحدد هامشه الخاص
  @override
  final pw.EdgeInsets margin = const pw.EdgeInsets.all(10);

  @override
  pw.Widget build(pw.Context context) {
    final theme = yellowTemplateTheme();
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        _buildLeftColumn(theme),
        _buildRightColumn(theme),
      ],
    );
  }

  pw.Widget _buildLeftColumn(PdfTemplateTheme theme) {
    pw.ImageProvider? profileImage =
        profileImageData != null ? pw.MemoryImage(profileImageData!) : null;

    return pw.Expanded(
      flex: 3,
      child: pw.Container(
        color: theme.primaryColor,
        padding: const pw.EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            if (profileImage != null)
              pw.Center(
                child: pw.SizedBox(
                  width: 120,
                  height: 120,
                  child: pw.ClipOval(
                    child: pw.Image(profileImage, fit: pw.BoxFit.cover),
                  ),
                ),
              ),
            if (profileImage != null) pw.SizedBox(height: 30),
            if (data.personalInfo.summary.isNotEmpty) ...[
              YellowSectionHeader(
                  title: 'PROFILE', theme: theme, isLeftColumn: true),
              pw.Text(data.personalInfo.summary,
                  style: theme.leftColumnBody, textAlign: pw.TextAlign.justify),
              pw.SizedBox(height: 20),
            ],
            YellowSectionHeader(
                title: 'CONTACT', theme: theme, isLeftColumn: true),
            if (data.personalInfo.email.isNotEmpty)
              ContactInfoLine(
                iconData: const pw.IconData(0xe158),
                text: data.personalInfo.email,
                iconFont: iconFont,
                theme: theme,
                isLeftColumn: true,
              ),
            if (data.personalInfo.phone != null &&
                data.personalInfo.phone!.isNotEmpty)
              ContactInfoLine(
                iconData: const pw.IconData(0xe0b0),
                text: data.personalInfo.phone!,
                iconFont: iconFont,
                theme: theme,
                isLeftColumn: true,
              ),
            if (data.personalInfo.address != null &&
                data.personalInfo.address!.isNotEmpty)
              ContactInfoLine(
                iconData: const pw.IconData(0xe55f),
                text: data.personalInfo.address!,
                iconFont: iconFont,
                theme: theme,
                isLeftColumn: true,
              ),
            pw.SizedBox(height: 20),
            if (data.skills.isNotEmpty) ...[
              YellowSectionHeader(
                  title: 'SKILLS', theme: theme, isLeftColumn: true),
              ...data.skills
                  .map((skill) => YellowSkillItem(skill, theme: theme)),
            ],
          ],
        ),
      ),
    );
  }

  pw.Widget _buildRightColumn(PdfTemplateTheme theme) {
    return pw.Expanded(
      flex: 5,
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.stretch,
        children: [
          pw.Container(
            color: theme.accentColor,
            padding: const pw.EdgeInsets.fromLTRB(30, 40, 30, 30),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(data.personalInfo.name.toUpperCase(), style: theme.h1),
                pw.SizedBox(height: 8),
                pw.Text(
                  data.personalInfo.jobTitle.toUpperCase(),
                  style: theme.body.copyWith(
                    color: theme.lightTextColor.shade(0.7),
                    fontSize: 12,
                    letterSpacing: 2,
                  ),
                ),
              ],
            ),
          ),
          pw.Expanded(
            child: pw.Container(
              color: PdfColors.white,
              padding: const pw.EdgeInsets.all(30),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  if (data.experiences.isNotEmpty) ...[
                    YellowSectionHeader(
                        title: 'PROFESSIONAL EXPERIENCE', theme: theme),
                    ...data.experiences
                        .map((exp) => YellowExperienceItem(exp, theme: theme)),
                    pw.SizedBox(height: 20),
                  ],
                  if (data.education.isNotEmpty) ...[
                    YellowSectionHeader(title: 'EDUCATION', theme: theme),
                    ...data.education
                        .map((edu) => YellowEducationItem(edu, theme: theme)),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
