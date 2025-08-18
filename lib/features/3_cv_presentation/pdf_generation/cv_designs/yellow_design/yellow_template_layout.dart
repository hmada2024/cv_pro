// lib/features/3_cv_presentation/pdf_generation/cv_designs/yellow_design/yellow_template_layout.dart
import 'dart:typed_data';
import 'package:cv_pro/features/2_cv_editor/form/data/models/cv_data.dart';
import 'package:cv_pro/features/3_cv_presentation/pdf_generation/core/pdf_template_layout_contract.dart';
import 'package:cv_pro/features/3_cv_presentation/pdf_generation/core/pdf_template_theme.dart';
import 'package:cv_pro/features/3_cv_presentation/pdf_generation/cv_designs/yellow_design/widgets/yellow_education_item.dart';
import 'package:cv_pro/features/3_cv_presentation/pdf_generation/cv_designs/yellow_design/widgets/yellow_experience_item.dart';
import 'package:cv_pro/features/3_cv_presentation/pdf_generation/cv_designs/yellow_design/widgets/yellow_section_header.dart';
import 'package:cv_pro/features/3_cv_presentation/pdf_generation/cv_designs/yellow_design/widgets/yellow_skill_item.dart';
import 'package:cv_pro/features/3_cv_presentation/pdf_generation/cv_designs/yellow_design/yellow_template_theme.dart';
import 'package:cv_pro/features/3_cv_presentation/pdf_generation/shared/widgets/widget_contact_info_line.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class YellowTemplateLayout extends PdfTemplateLayout {
  final CVData data;
  final pw.Font iconFont;
  final bool showReferencesNote;
  final Uint8List? profileImageData;

  // Layout constants for the Asymmetrical Full-bleed Stack design
  static const double pageMargin = 25.0;
  static const double leftColumnRatio = 0.32;
  static const double headerHeight = 130.0;
  static const double imageSize = 100.0;
  static const double contentPadding = 30.0;

  YellowTemplateLayout({
    required this.data,
    required this.iconFont,
    required this.showReferencesNote,
    required this.profileImageData,
  });

  @override
  final pw.EdgeInsets margin = pw.EdgeInsets.zero;

  @override
  pw.Widget build(pw.Context context) {
    final theme = yellowTemplateTheme();
    final pageFormat = context.page.pageFormat;
    final leftColumnWidth = pageFormat.width * leftColumnRatio;

    return pw.Stack(
      children: [
        _buildRightContent(theme, leftColumnWidth),
        _buildHeader(theme, leftColumnWidth),
        _buildLeftColumn(theme, leftColumnWidth),
        _buildProfileImage(leftColumnWidth),
      ],
    );
  }

  pw.Widget _buildHeader(PdfTemplateTheme theme, double leftColumnWidth) {
    return pw.Positioned(
      top: pageMargin,
      left: 0,
      right: 0,
      child: pw.Container(
        height: headerHeight,
        color: theme.accentColor,
        padding: pw.EdgeInsets.only(
          left: leftColumnWidth + 20,
          right: contentPadding,
          top: 45,
        ),
        child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          mainAxisAlignment: pw.MainAxisAlignment.start,
          children: [
            pw.Text(data.personalInfo.name.toUpperCase(), style: theme.h1),
            pw.SizedBox(height: 8),
            pw.Text(
              data.personalInfo.jobTitle.toUpperCase(),
              style: (theme as YellowPdfTemplateTheme).jobTitleStyle,
            ),
          ],
        ),
      ),
    );
  }

  pw.Widget _buildLeftColumn(PdfTemplateTheme theme, double width) {
    return pw.Positioned(
      top: 0,
      left: pageMargin,
      bottom: 0,
      child: pw.Container(
        width: width,
        color: theme.primaryColor,
        padding: const pw.EdgeInsets.symmetric(horizontal: contentPadding),
        child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.SizedBox(height: pageMargin + headerHeight),
            if (data.personalInfo.summary.isNotEmpty) ...[
              YellowSectionHeader(title: 'PROFILE', theme: theme),
              pw.Text(
                data.personalInfo.summary,
                style: theme.leftColumnBody,
                textAlign: pw.TextAlign.justify,
              ),
              pw.SizedBox(height: 25),
            ],
            YellowSectionHeader(title: 'CONTACT', theme: theme),
            if (data.personalInfo.email.isNotEmpty)
              ContactInfoLine(
                  iconData: const pw.IconData(0xe158),
                  text: data.personalInfo.email,
                  iconFont: iconFont,
                  theme: theme,
                  isLeftColumn: true),
            if (data.personalInfo.phone != null &&
                data.personalInfo.phone!.isNotEmpty)
              ContactInfoLine(
                  iconData: const pw.IconData(0xe0b0),
                  text: data.personalInfo.phone!,
                  iconFont: iconFont,
                  theme: theme,
                  isLeftColumn: true),
            if (data.personalInfo.address != null &&
                data.personalInfo.address!.isNotEmpty)
              ContactInfoLine(
                  iconData: const pw.IconData(0xe55f),
                  text: data.personalInfo.address!,
                  iconFont: iconFont,
                  theme: theme,
                  isLeftColumn: true),
            pw.SizedBox(height: 25),
            if (data.skills.isNotEmpty) ...[
              YellowSectionHeader(title: 'SKILLS', theme: theme),
              ...data.skills
                  .map((skill) => YellowSkillItem(skill, theme: theme)),
            ],
          ],
        ),
      ),
    );
  }

  pw.Widget _buildRightContent(PdfTemplateTheme theme, double leftColumnWidth) {
    return pw.Positioned(
      top: pageMargin + headerHeight,
      left: leftColumnWidth + pageMargin,
      right: pageMargin,
      bottom: pageMargin,
      child: pw.Container(
        color: PdfColors.white,
        padding: const pw.EdgeInsets.all(contentPadding),
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
    );
  }

  pw.Widget _buildProfileImage(double leftColumnWidth) {
    pw.ImageProvider? profileImage =
        profileImageData != null ? pw.MemoryImage(profileImageData!) : null;
    if (profileImage == null) return pw.SizedBox();

    return pw.Positioned(
      // MODIFICATION: Vertically centered within the header's space
      top: pageMargin + (headerHeight / 2) - (imageSize / 2),
      // MODIFICATION: Horizontally centered within the yellow bar
      left: pageMargin + (leftColumnWidth / 2) - (imageSize / 2),
      child: pw.SizedBox(
        width: imageSize,
        height: imageSize,
        child: pw.ClipOval(
          child: pw.Image(profileImage, fit: pw.BoxFit.cover),
        ),
      ),
    );
  }
}
