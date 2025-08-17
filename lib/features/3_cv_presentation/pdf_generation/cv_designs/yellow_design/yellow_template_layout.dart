// lib/features/3_cv_presentation/pdf_generation/cv_designs/yellow_design/yellow_template_layout.dart
import 'dart:typed_data';
import 'package:cv_pro/features/2_cv_editor/form/data/models/cv_data.dart';
import 'package:cv_pro/features/3_cv_presentation/pdf_generation/cv_designs/yellow_design/yellow_template_theme.dart';
import 'package:cv_pro/features/3_cv_presentation/pdf_generation/layout/sections/contact_section_pdf.dart';
import 'package:cv_pro/features/3_cv_presentation/pdf_generation/layout/sections/details_section_pdf.dart';
import 'package:cv_pro/features/3_cv_presentation/pdf_generation/layout/sections/education_section_pdf.dart';
import 'package:cv_pro/features/3_cv_presentation/pdf_generation/layout/sections/experience_section_pdf.dart';
import 'package:cv_pro/features/3_cv_presentation/pdf_generation/layout/sections/languages_section_pdf.dart';
import 'package:cv_pro/features/3_cv_presentation/pdf_generation/layout/sections/license_section_pdf.dart';
import 'package:cv_pro/features/3_cv_presentation/pdf_generation/layout/sections/profile_section_pdf.dart';
import 'package:cv_pro/features/3_cv_presentation/pdf_generation/layout/sections/references_section_pdf.dart';
import 'package:cv_pro/features/3_cv_presentation/pdf_generation/layout/sections/skills_section_pdf.dart';
import 'package:cv_pro/features/3_cv_presentation/pdf_generation/theme_templates/pdf_template_theme.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

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
        _buildLeftColumn(theme),
        _buildRightColumn(theme),
      ],
    );
  }

  pw.Widget _buildLeftColumn(PdfTemplateTheme theme) {
    pw.ImageProvider? profileImage =
        profileImageData != null ? pw.MemoryImage(profileImageData!) : null;

    return pw.Expanded(
      flex: 2,
      child: pw.Container(
        color: theme.primaryColor,
        padding: const pw.EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            if (profileImage != null)
              pw.Center(
                child: pw.SizedBox(
                  width: 108,
                  height: 108,
                  child: pw.ClipOval(
                    child: pw.Image(profileImage, fit: pw.BoxFit.cover),
                  ),
                ),
              ),
            if (profileImage != null) pw.SizedBox(height: 30),
            ProfileSectionPdf(
                personalInfo: data.personalInfo,
                theme: theme,
                isLeftColumn: true),
            pw.SizedBox(height: 20),
            ContactSectionPdf(
              personalInfo: data.personalInfo,
              theme: theme,
              iconFont: iconFont,
              isLeftColumn: true,
            ),
            pw.SizedBox(height: 20),
            SkillsSectionPdf(
                skills: data.skills, theme: theme, isLeftColumn: true),
            // --- ADDED SECTIONS ---
            pw.SizedBox(height: 20),
            LanguagesSectionPdf(
              languages: data.languages,
              theme: theme,
              isLeftColumn: true,
            ),
            DetailsSectionPdf(
              personalInfo: data.personalInfo,
              theme: theme,
              iconFont: iconFont,
            ),
            LicenseSectionPdf(
              personalInfo: data.personalInfo,
              theme: theme,
              iconFont: iconFont,
            ),
          ],
        ),
      ),
    );
  }

  pw.Widget _buildRightColumn(PdfTemplateTheme theme) {
    return pw.Expanded(
      flex: 4,
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.stretch,
        children: [
          pw.Container(
            color: theme.accentColor,
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
          pw.Expanded(
            child: pw.Container(
              color: PdfColors.white,
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
                  ReferencesSectionPdf(
                    references: data.references,
                    theme: theme,
                    showReferencesNote: showReferencesNote,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
