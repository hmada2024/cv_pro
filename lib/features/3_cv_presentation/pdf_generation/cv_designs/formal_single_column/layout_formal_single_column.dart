// lib/features/3_cv_presentation/pdf_generation/cv_designs/formal_single_column/layout_formal_single_column.dart
import 'dart:typed_data';
import 'package:cv_pro/features/2_cv_editor/form/data/models/cv_data.dart';
import 'package:cv_pro/features/3_cv_presentation/pdf_generation/core/pdf_template_layout_contract.dart';
import 'package:cv_pro/features/3_cv_presentation/pdf_generation/core/pdf_template_theme.dart';
import 'package:cv_pro/features/3_cv_presentation/pdf_generation/cv_designs/formal_single_column/theme_formal_single_column.dart';
import 'package:cv_pro/features/3_cv_presentation/pdf_generation/cv_designs/formal_single_column/widget_formal_section_header.dart';
import 'package:cv_pro/features/3_cv_presentation/pdf_generation/shared/sections/education_section_pdf.dart';
import 'package:cv_pro/features/3_cv_presentation/pdf_generation/shared/sections/languages_section_pdf.dart';
import 'package:cv_pro/features/3_cv_presentation/pdf_generation/shared/sections/references_section_pdf.dart';
import 'package:cv_pro/features/3_cv_presentation/pdf_generation/shared/sections/skills_section_pdf.dart';
import 'package:cv_pro/features/3_cv_presentation/pdf_generation/shared/widgets/widget_contact_info_line.dart';
import 'package:intl/intl.dart';
import 'package:pdf/widgets.dart' as pw;

class FormalSingleColumnLayout extends PdfTemplateLayout {
  final CVData data;
  final pw.Font iconFont;
  final bool showReferencesNote;
  final Uint8List? profileImageData;

  FormalSingleColumnLayout({
    required this.data,
    required this.iconFont,
    required this.showReferencesNote,
    required this.profileImageData,
  });

  @override
  final pw.EdgeInsets margin = const pw.EdgeInsets.all(30);

  @override
  pw.Widget build(pw.Context context) {
    final theme = formalSingleColumnTheme();
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        _buildHeader(theme),
        pw.SizedBox(height: 10), // <-- تعديل: تقليل المسافة
        _buildContactBar(theme),

        // Main content sections
        _buildProfileSection(theme),
        _buildExperienceSection(theme),

        EducationSectionPdf(educationList: data.education, theme: theme),
        SkillsSectionPdf(skills: data.skills, theme: theme),
        LanguagesSectionPdf(languages: data.languages, theme: theme),
        ReferencesSectionPdf(
            references: data.references,
            theme: theme,
            showReferencesNote: showReferencesNote),
      ],
    );
  }

  pw.Widget _buildHeader(PdfTemplateTheme theme) {
    pw.ImageProvider? profileImage =
        profileImageData != null ? pw.MemoryImage(profileImageData!) : null;

    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.center,
      children: [
        pw.Expanded(
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            mainAxisSize: pw.MainAxisSize.min,
            children: [
              pw.Text(data.personalInfo.name.toUpperCase(), style: theme.h1),
              pw.SizedBox(height: 8),
              pw.Text(data.personalInfo.jobTitle, style: theme.h2),
            ],
          ),
        ),
        pw.SizedBox(width: 24),
        if (profileImage != null)
          pw.SizedBox(
            width: 95, // <-- تعديل: حجم الصورة الدائرية
            height: 95,
            child: pw.ClipOval(
              child: pw.Image(profileImage, fit: pw.BoxFit.cover),
            ),
          ),
      ],
    );
  }

  pw.Widget _buildContactBar(PdfTemplateTheme theme) {
    return pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.SizedBox(height: 10),
          if (data.personalInfo.phone != null &&
              data.personalInfo.phone!.isNotEmpty)
            ContactInfoLine(
              iconData: const pw.IconData(0xe0b0),
              text: data.personalInfo.phone!,
              iconFont: iconFont,
              theme: theme,
            ),
          if (data.personalInfo.email.isNotEmpty)
            ContactInfoLine(
              iconData: const pw.IconData(0xe158),
              text: data.personalInfo.email,
              iconFont: iconFont,
              theme: theme,
            ),
          if (data.personalInfo.address != null &&
              data.personalInfo.address!.isNotEmpty)
            ContactInfoLine(
              iconData: const pw.IconData(0xe55f),
              text: data.personalInfo.address!,
              iconFont: iconFont,
              theme: theme,
            ),
        ]);
  }

  pw.Widget _buildProfileSection(PdfTemplateTheme theme) {
    if (data.personalInfo.summary.isEmpty) return pw.SizedBox();
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.SizedBox(height: 15),
        FormalSectionHeader(title: 'PROFILE', theme: theme),
        pw.Text(
          data.personalInfo.summary,
          style: theme.body,
          textAlign: pw.TextAlign.justify,
        ),
      ],
    );
  }

  pw.Widget _buildExperienceSection(PdfTemplateTheme theme) {
    if (data.experiences.isEmpty) return pw.SizedBox();
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.SizedBox(height: 15),
        FormalSectionHeader(title: 'WORK EXPERIENCE', theme: theme),
        ...data.experiences.map((exp) =>
            _FormalExperienceItem(exp, iconFont: iconFont, theme: theme)),
      ],
    );
  }
}

// Custom ExperienceItem for this template with dot bullet points
class _FormalExperienceItem extends pw.StatelessWidget {
  final Experience experience;
  final pw.Font iconFont;
  final PdfTemplateTheme theme;
  final DateFormat formatter = DateFormat('MMM yyyy');

  _FormalExperienceItem(this.experience,
      {required this.iconFont, required this.theme});

  @override
  pw.Widget build(pw.Context context) {
    final descriptionLines = experience.description
        .split('\n')
        .where((line) => line.trim().isNotEmpty)
        .map((line) => pw.Padding(
              padding: const pw.EdgeInsets.only(left: 4, bottom: 4),
              child: pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Container(
                    margin: const pw.EdgeInsets.only(top: 4, right: 8),
                    width: 5,
                    height: 5,
                    decoration: pw.BoxDecoration(
                      color: theme.body.color,
                      shape: pw.BoxShape.circle,
                    ),
                  ),
                  pw.Expanded(
                    child: pw.Text(
                      line.trim().replaceFirst('•', '').trim(),
                      textAlign: pw.TextAlign.justify,
                      style: theme.body,
                    ),
                  ),
                ],
              ),
            ))
        .toList();

    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 12),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Expanded(
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      experience.position.toUpperCase(),
                      style: theme.experienceTitleStyle,
                    ),
                    pw.Text(
                      experience.companyName,
                      style: theme.experienceCompanyStyle,
                    ),
                  ],
                ),
              ),
              pw.SizedBox(width: 10),
              pw.Text(
                '${formatter.format(experience.startDate)} - ${experience.isCurrent ? "Present" : formatter.format(experience.endDate!)}',
                style: theme.experienceDateStyle,
              ),
            ],
          ),
          pw.SizedBox(height: 8),
          ...descriptionLines,
        ],
      ),
    );
  }
}
