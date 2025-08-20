// lib/features/3_cv_presentation/pdf_generation/cv_designs/formal_single_column/layout_formal_single_column.dart
import 'dart:typed_data';

import 'package:cv_pro/features/2_cv_editor/form/data/models/cv_data.dart';
import 'package:cv_pro/features/3_cv_presentation/pdf_generation/core/pdf_template_layout_contract.dart';
import 'package:cv_pro/features/3_cv_presentation/pdf_generation/core/pdf_template_theme.dart';
import 'package:cv_pro/features/3_cv_presentation/pdf_generation/cv_designs/formal_single_column/theme_formal_single_column.dart';
import 'package:cv_pro/features/3_cv_presentation/pdf_generation/shared/sections/education_section_pdf.dart';
import 'package:cv_pro/features/3_cv_presentation/pdf_generation/shared/sections/experience_section_pdf.dart';
import 'package:cv_pro/features/3_cv_presentation/pdf_generation/shared/sections/languages_section_pdf.dart';
import 'package:cv_pro/features/3_cv_presentation/pdf_generation/shared/sections/profile_section_pdf.dart';
import 'package:cv_pro/features/3_cv_presentation/pdf_generation/shared/sections/references_section_pdf.dart';
import 'package:cv_pro/features/3_cv_presentation/pdf_generation/shared/sections/skills_section_pdf.dart';
import 'package:cv_pro/features/3_cv_presentation/pdf_generation/shared/widgets/widget_contact_info_line.dart';
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

  // A standard, formal margin for the document.
  @override
  final pw.EdgeInsets margin = const pw.EdgeInsets.all(30);

  @override
  pw.Widget build(pw.Context context) {
    final theme = formalSingleColumnTheme();
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        _buildHeader(theme),
        pw.SizedBox(height: 12),
        _buildContactBar(theme),
        pw.SizedBox(height: 12),
        pw.Divider(thickness: 1.5, color: theme.primaryColor),
        // Main content sections
        ProfileSectionPdf(personalInfo: data.personalInfo, theme: theme),
        ExperienceSectionPdf(
            experiences: data.experiences, theme: theme, iconFont: iconFont),
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
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Expanded(
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(data.personalInfo.name.toUpperCase(), style: theme.h1),
              pw.SizedBox(height: 6),
              pw.Text(data.personalInfo.jobTitle,
                  style: theme.h2.copyWith(fontWeight: pw.FontWeight.normal)),
            ],
          ),
        ),
        pw.SizedBox(width: 20),
        if (profileImage != null)
          pw.SizedBox(
            width: 80, // 4 ratio
            height: 120, // 6 ratio
            child: pw.Image(profileImage, fit: pw.BoxFit.cover),
          ),
      ],
    );
  }

  pw.Widget _buildContactBar(PdfTemplateTheme theme) {
    return pw.Wrap(
      spacing: 15,
      runSpacing: 5,
      children: [
        if (data.personalInfo.phone != null &&
            data.personalInfo.phone!.isNotEmpty)
          ContactInfoLine(
            iconData: const pw.IconData(0xe0b0), // phone icon
            text: data.personalInfo.phone!,
            iconFont: iconFont,
            theme: theme,
          ),
        if (data.personalInfo.email.isNotEmpty)
          ContactInfoLine(
            iconData: const pw.IconData(0xe158), // email icon
            text: data.personalInfo.email,
            iconFont: iconFont,
            theme: theme,
          ),
        if (data.personalInfo.address != null &&
            data.personalInfo.address!.isNotEmpty)
          ContactInfoLine(
            iconData: const pw.IconData(0xe55f), // location icon
            text: data.personalInfo.address!,
            iconFont: iconFont,
            theme: theme,
          ),
      ],
    );
  }
}
