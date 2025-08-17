// lib/features/pdf_export/cv_designs/modern_top_header/modern_template_layout.dart
import 'dart:typed_data';
import 'package:cv_pro/features/cv_form/data/models/cv_data.dart';
import 'package:cv_pro/features/pdf_export/cv_designs/modern_top_header/modern_template_theme.dart';
import 'package:cv_pro/features/pdf_export/layout/sections/contact_section_pdf.dart';
import 'package:cv_pro/features/pdf_export/layout/sections/education_section_pdf.dart';
import 'package:cv_pro/features/pdf_export/layout/sections/experience_section_pdf.dart';
import 'package:cv_pro/features/pdf_export/layout/sections/languages_section_pdf.dart';
import 'package:cv_pro/features/pdf_export/layout/sections/license_section_pdf.dart';
import 'package:cv_pro/features/pdf_export/layout/sections/profile_section_pdf.dart';
import 'package:cv_pro/features/pdf_export/layout/sections/references_section_pdf.dart';
import 'package:cv_pro/features/pdf_export/layout/sections/skills_section_pdf.dart';
import 'package:cv_pro/features/pdf_export/theme_templates/pdf_template_theme.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

// لوحة البناء الرئيسية للقالب العصري
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
        // --- 1. بناء الرأس العلوي (Header) ---
        _buildHeader(theme),

        // --- 2. بناء الجسم الرئيسي (Body) ---
        _buildBody(theme),
      ],
    );
  }

  // ويدجت خاصة لبناء الرأس
  pw.Widget _buildHeader(PdfTemplateTheme theme) {
    pw.ImageProvider? profileImage =
        profileImageData != null ? pw.MemoryImage(profileImageData!) : null;

    return pw.Container(
      width: double.infinity,
      padding: const pw.EdgeInsets.symmetric(vertical: 24, horizontal: 30),
      color: theme.primaryColor,
      child: pw.Column(
        children: [
          if (profileImage != null)
            pw.Container(
              width: 110,
              height: 110,
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
          if (profileImage != null) pw.SizedBox(height: 16),
          pw.Text(
            data.personalInfo.name.toUpperCase(),
            style: theme.h1,
            textAlign: pw.TextAlign.center,
          ),
          pw.SizedBox(height: 6),
          pw.Text(
            data.personalInfo.jobTitle,
            style: theme.body.copyWith(
              color: theme.lightTextColor.shade(0.8),
              fontSize: 14,
            ),
            textAlign: pw.TextAlign.center,
          ),
        ],
      ),
    );
  }

  // ويدجت خاصة لبناء الجسم
  pw.Widget _buildBody(PdfTemplateTheme theme) {
    return pw.Expanded(
      child: pw.Padding(
        padding: const pw.EdgeInsets.all(30),
        child: pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            // --- العمود الأيسر للجسم (أضيق) ---
            pw.Expanded(
              flex: 3,
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  // لاحظ أننا نمرر الثيم الجديد لكل قسم
                  // وهذه الأقسام أصبحت الآن ذكية بما يكفي لتتكيف مع أي ثيم
                  ContactSectionPdf(
                      personalInfo: data.personalInfo,
                      theme: theme,
                      iconFont: iconFont),
                  EducationSectionPdf(
                      educationList: data.education, theme: theme),
                  SkillsSectionPdf(skills: data.skills, theme: theme),
                  LanguagesSectionPdf(languages: data.languages, theme: theme),
                  LicenseSectionPdf(
                      personalInfo: data.personalInfo,
                      theme: theme,
                      iconFont: iconFont),
                ],
              ),
            ),
            pw.SizedBox(width: 30),
            // --- العمود الأيمن للجسم (أعرض) ---
            pw.Expanded(
              flex: 5,
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  ProfileSectionPdf(
                      personalInfo: data.personalInfo, theme: theme),
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
