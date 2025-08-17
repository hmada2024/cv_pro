// lib/features/pdf_export/cv_designs/classic_two_column/classic_template_layout.dart
import 'dart:typed_data';
import 'package:cv_pro/features/cv_form/data/models/cv_data.dart';
import 'package:cv_pro/features/pdf_export/layout/sections/contact_section_pdf.dart';
import 'package:cv_pro/features/pdf_export/layout/sections/details_section_pdf.dart';
import 'package:cv_pro/features/pdf_export/layout/sections/education_section_pdf.dart';
import 'package:cv_pro/features/pdf_export/layout/sections/experience_section_pdf.dart';
import 'package:cv_pro/features/pdf_export/layout/sections/languages_section_pdf.dart';
import 'package:cv_pro/features/pdf_export/layout/sections/license_section_pdf.dart';
import 'package:cv_pro/features/pdf_export/layout/sections/profile_section_pdf.dart';
import 'package:cv_pro/features/pdf_export/layout/sections/references_section_pdf.dart';
import 'package:cv_pro/features/pdf_export/layout/sections/skills_section_pdf.dart';
import 'package:cv_pro/features/pdf_export/cv_designs/classic_two_column/classic_template_theme.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

// هذه هي لوحة البناء الرئيسية التي ترتب الأقسام
class ClassicTemplateLayout extends pw.StatelessWidget {
  final CVData data;
  final pw.Font iconFont;
  final bool showReferencesNote;
  final Uint8List? profileImageData;

  ClassicTemplateLayout({
    required this.data,
    required this.iconFont,
    required this.showReferencesNote,
    required this.profileImageData,
  });

  @override
  pw.Widget build(pw.Context context) {
    // التغيير: الحصول على كائن الثيم الكامل
    final theme = classicTemplateTheme();
    pw.ImageProvider? profileImage =
        profileImageData != null ? pw.MemoryImage(profileImageData!) : null;

    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        // --- العمود الأيسر ---
        pw.Expanded(
          flex: 1,
          child: pw.Container(
            color: theme.primaryColor,
            padding:
                const pw.EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                if (profileImage != null)
                  pw.Center(
                    child: pw.Container(
                      width: 108,
                      height: 108,
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
                  ),
                if (profileImage != null) pw.SizedBox(height: 25),
                // الأقسام هنا ستستخدم تلقائيًا أنماط العمود الأيسر من الثيم
                ContactSectionPdf(
                    personalInfo: data.personalInfo,
                    theme: theme,
                    iconFont: iconFont),
                DetailsSectionPdf(
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
        ),
        // --- العمود الأيمن ---
        pw.Expanded(
          flex: 2,
          child: pw.Container(
            padding: const pw.EdgeInsets.fromLTRB(25, 35, 25, 25),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  data.personalInfo.name.toUpperCase(),
                  style: theme.h1,
                ),
                pw.SizedBox(height: 4),
                pw.Text(
                  data.personalInfo.jobTitle.toUpperCase(),
                  style: theme.h2,
                ),
                // الأقسام هنا ستستخدم تلقائيًا الأنماط العامة (h2, body, etc) من الثيم
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
        ),
      ],
    );
  }
}
