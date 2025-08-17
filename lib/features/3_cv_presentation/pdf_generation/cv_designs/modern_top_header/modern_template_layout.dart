// lib/features/3_cv_presentation/pdf_generation/cv_designs/modern_top_header/modern_template_layout.dart
import 'dart:typed_data';
import 'package:cv_pro/features/2_cv_editor/form/data/models/cv_data.dart';
import 'package:cv_pro/features/3_cv_presentation/pdf_generation/cv_designs/modern_top_header/modern_template_theme.dart';
import 'package:cv_pro/features/3_cv_presentation/pdf_generation/layout/sections/contact_section_pdf.dart';
import 'package:cv_pro/features/3_cv_presentation/pdf_generation/layout/sections/education_section_pdf.dart';
import 'package:cv_pro/features/3_cv_presentation/pdf_generation/layout/sections/experience_section_pdf.dart';
import 'package:cv_pro/features/3_cv_presentation/pdf_generation/layout/sections/languages_section_pdf.dart';
import 'package:cv_pro/features/3_cv_presentation/pdf_generation/layout/sections/profile_section_pdf.dart';
import 'package:cv_pro/features/3_cv_presentation/pdf_generation/layout/sections/references_section_pdf.dart';
import 'package:cv_pro/features/3_cv_presentation/pdf_generation/layout/sections/skills_section_pdf.dart';
import 'package:cv_pro/features/3_cv_presentation/pdf_generation/theme_templates/pdf_template_theme.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class ModernTopHeaderLayout extends pw.StatelessWidget {
  final CVData data;
  final pw.Font iconFont;
  final bool showReferencesNote;
  final Uint8List? profileImageData;

  ModernTopHeaderLayout({
    required this.data,
    required this.iconFont,
    required this.showReferencesNote,
    required this.profileImageData,
  });

  @override
  pw.Widget build(pw.Context context) {
    final theme = modernTopHeaderTheme();
    return pw.Column(
      children: [
        _buildHeader(theme),
        _buildBody(theme),
      ],
    );
  }

  pw.Widget _buildHeader(PdfTemplateTheme theme) {
    pw.ImageProvider? profileImage =
        profileImageData != null ? pw.MemoryImage(profileImageData!) : null;

    return pw.Container(
      width: double.infinity,
      padding: const pw.EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      color: theme.primaryColor,
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.center,
        children: [
          if (profileImage != null)
            pw.Container(
              width: 100,
              height: 100,
              decoration: const pw.BoxDecoration(
                color: PdfColors.white,
                shape: pw.BoxShape.circle,
              ),
              child: pw.Padding(
                padding: const pw.EdgeInsets.all(4),
                child: pw.ClipOval(
                  child: pw.Image(profileImage, fit: pw.BoxFit.cover),
                ),
              ),
            ),
          if (profileImage != null) pw.SizedBox(width: 20),
          pw.Expanded(
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              mainAxisAlignment: pw.MainAxisAlignment.center,
              children: [
                pw.Text(
                  data.personalInfo.name.toUpperCase(),
                  style: theme.h1.copyWith(fontSize: 24),
                  textAlign: pw.TextAlign.left,
                ),
                pw.SizedBox(height: 5),
                pw.Text(
                  data.personalInfo.jobTitle,
                  style: theme.body.copyWith(
                    color: theme.lightTextColor.shade(0.8),
                    fontSize: 13,
                  ),
                  textAlign: pw.TextAlign.left,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  pw.Widget _buildBody(PdfTemplateTheme theme) {
    return pw.Expanded(
      child: pw.Padding(
        padding: const pw.EdgeInsets.fromLTRB(30, 20, 30, 30),
        child: pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Expanded(
              flex: 3,
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  ContactSectionPdf(
                    personalInfo: data.personalInfo,
                    theme: theme,
                    iconFont: iconFont,
                    isLeftColumn: true,
                  ),
                  EducationSectionPdf(
                    educationList: data.education,
                    theme: theme,
                    isLeftColumn: true,
                  ),
                  SkillsSectionPdf(
                    skills: data.skills,
                    theme: theme,
                    isLeftColumn: true,
                  ),
                ],
              ),
            ),
            pw.SizedBox(width: 30),
            pw.Expanded(
              flex: 5,
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  ProfileSectionPdf(
                      personalInfo: data.personalInfo, theme: theme),
                  LanguagesSectionPdf(
                    languages: data.languages,
                    theme: theme,
                    isLeftColumn: false,
                  ),
                  ExperienceSectionPdf(
                      experiences: data.experiences,
                      theme: theme,
                      iconFont: iconFont),
                  ReferencesSectionPdf(
                    references: data.references,
                    theme: theme,
                    showReferencesNote: showReferencesNote,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
