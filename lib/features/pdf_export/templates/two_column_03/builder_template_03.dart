// features/pdf_export/templates/two_column_03/builder_template_03.dart
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:cv_pro/features/cv_form/data/models/cv_data.dart';
import 'package:intl/intl.dart';

// --- استيراد مزدوج ومضمون ---
// لاستيراد أنواع البيانات الأساسية (بدون بادئة)
import 'package:pdf/pdf.dart';
// لاستيراد كل الويدجتس وعناصر الرسم (مع بادئة pw)
import 'package:pdf/widgets.dart' as pw;

import 'colors_template_03.dart';

// ====================================================================
// الوظيفة الرئيسية لتجميع القالب
// ====================================================================
Future<pw.Widget> buildTemplate03({
  required CVData data,
  required pw.Font iconFont,
  required bool showReferencesNote,
}) async {
  pw.ImageProvider? profileImage;
  final imagePath = data.personalInfo.profileImagePath;

  if (imagePath != null && imagePath.isNotEmpty) {
    if (imagePath.startsWith('assets/')) {
      final imageBytes = await rootBundle.load(imagePath);
      profileImage = pw.MemoryImage(imageBytes.buffer.asUint8List());
    } else {
      final imageFile = File(imagePath);
      if (await imageFile.exists()) {
        profileImage = pw.MemoryImage(await imageFile.readAsBytes());
      }
    }
  }

  return pw.Container(
    color: Template03Colors.background,
    child: pw.Column(
      children: [
        _HeaderTemplate03(
          personalInfo: data.personalInfo,
          profileImage: profileImage,
        ),
        _ContactBarTemplate03(
            personalInfo: data.personalInfo, iconFont: iconFont),
        pw.Expanded(
          child: pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Expanded(
                flex: 2,
                child: _SidebarTemplate03(data: data),
              ),
              pw.Expanded(
                flex: 3,
                child: _MainColumnTemplate03(
                  data: data,
                  iconFont: iconFont,
                  showReferencesNote: showReferencesNote,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ====================================================================
// كل الأجزاء أصبحت الآن ويدجتس خاصة داخل نفس الملف
// ====================================================================

// --- 1. الـ Clipper الخاص بالهيدر ---
class _HeaderClipper extends pw.CustomClipper {
  @override
  pw.Path getClip(PdfPoint size) {
    final path = pw.Path();
    path.moveTo(0, 0);
    path.lineTo(size.x, 0);
    path.lineTo(size.x, size.y * 0.75);
    path.lineTo(0, size.y);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(pw.CustomClipper oldClipper) => false;
}

// --- 2. ويدجت الهيدر ---
class _HeaderTemplate03 extends pw.StatelessWidget {
  final PersonalInfo personalInfo;
  final pw.ImageProvider? profileImage;

  _HeaderTemplate03({required this.personalInfo, this.profileImage});

  @override
  pw.Widget build(pw.Context context) {
    const double headerHeight = 130;
    const double avatarRadius = 45;

    return pw.Stack(
      children: [
        pw.ClipPath(
          clipper: _HeaderClipper(),
          child: pw.Container(
            height: headerHeight,
            width: double.infinity,
            color: Template03Colors.primaryDark,
          ),
        ),
        pw.Container(
          height: headerHeight,
          padding: const pw.EdgeInsets.fromLTRB(30, 0, 30, 10),
          child: pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            children: [
              if (profileImage != null)
                pw.Container(
                  width: (avatarRadius + 4) * 2,
                  height: (avatarRadius + 4) * 2,
                  decoration: const pw.BoxDecoration(
                    color: PdfColors.white, // يأتي من pdf.dart (بدون بادئة)
                    shape: pw.BoxShape.circle,
                  ),
                  child: pw.Padding(
                    padding: const pw.EdgeInsets.all(4),
                    child: pw.ClipOval(
                      child: pw.Image(profileImage!, fit: pw.BoxFit.cover),
                    ),
                  ),
                ),
              if (profileImage != null) pw.SizedBox(width: 20),
              pw.Expanded(
                child: pw.Padding(
                  padding: const pw.EdgeInsets.only(top: 20),
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    children: [
                      pw.Text(
                        personalInfo.name.toUpperCase(),
                        style: pw.TextStyle(
                          color: Template03Colors.darkText,
                          fontSize: 28,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.SizedBox(height: 5),
                      pw.Text(
                        personalInfo.jobTitle.toUpperCase(),
                        style: const pw.TextStyle(
                          color: Template03Colors.subtleText,
                          fontSize: 12,
                          letterSpacing: 2,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// --- 3. ويدجت شريط التواصل ---
class _ContactBarTemplate03 extends pw.StatelessWidget {
  final PersonalInfo personalInfo;
  final pw.Font iconFont;

  _ContactBarTemplate03({required this.personalInfo, required this.iconFont});

  @override
  pw.Widget build(pw.Context context) {
    return pw.Container(
      padding: const pw.EdgeInsets.symmetric(horizontal: 25),
      transform: Matrix4.translationValues(0, -15, 0),
      child: pw.Container(
        padding: const pw.EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: pw.BoxDecoration(
          color: Template03Colors.contactBarBlue,
          borderRadius: pw.BorderRadius.circular(30),
        ),
        child: pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
          children: [
            if (personalInfo.phone != null && personalInfo.phone!.isNotEmpty)
              _buildContactItem(
                  icon: const pw.IconData(0xe0b0),
                  text: personalInfo.phone!,
                  iconFont: iconFont),
            _buildContactItem(
                icon: const pw.IconData(0xe158),
                text: personalInfo.email,
                iconFont: iconFont),
            if (personalInfo.address != null &&
                personalInfo.address!.isNotEmpty)
              _buildContactItem(
                  icon: const pw.IconData(0xe55f),
                  text: personalInfo.address!,
                  iconFont: iconFont),
          ],
        ),
      ),
    );
  }

  pw.Widget _buildContactItem(
      {required pw.IconData icon,
      required String text,
      required pw.Font iconFont}) {
    return pw.Row(mainAxisSize: pw.MainAxisSize.min, children: [
      pw.Icon(icon, color: Template03Colors.lightText, font: iconFont, size: 9),
      pw.SizedBox(width: 6),
      pw.Text(text,
          style: const pw.TextStyle(
              color: Template03Colors.lightText, fontSize: 8)),
    ]);
  }
}

// --- 4. ويدجت العمود الجانبي (الأيسر) ---
class _SidebarTemplate03 extends pw.StatelessWidget {
  final CVData data;
  final DateFormat formatter = DateFormat('yyyy');
  _SidebarTemplate03({required this.data});

  @override
  pw.Widget build(pw.Context context) {
    final sortedEducation = List<Education>.from(data.education)
      ..sort((a, b) => b.startDate.compareTo(a.startDate));

    return pw.Container(
      padding: const pw.EdgeInsets.fromLTRB(20, 25, 20, 20),
      color: Template03Colors.primaryDark,
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          if (sortedEducation.isNotEmpty)
            _buildSidebarSection(
                title: 'Education',
                children: sortedEducation
                    .map((edu) => _buildEducationItem(edu))
                    .toList()),
          if (data.skills.isNotEmpty)
            _buildSidebarSection(
                title: 'Skills',
                children: data.skills
                    .map((skill) =>
                        _buildListItem('${skill.name} - ${skill.level}'))
                    .toList()),
          if (data.languages.isNotEmpty)
            _buildSidebarSection(
                title: 'Language',
                children: data.languages
                    .map((lang) =>
                        _buildListItem('${lang.name} - ${lang.proficiency}'))
                    .toList()),
        ],
      ),
    );
  }

  pw.Widget _buildSidebarSection(
      {required String title, required List<pw.Widget> children}) {
    return pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(title.toUpperCase(),
              style: pw.TextStyle(
                  color: Template03Colors.lightText,
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 14)),
          pw.Container(
              height: 1.5,
              width: 40,
              color: Template03Colors.accent,
              margin: const pw.EdgeInsets.only(top: 4, bottom: 12)),
          ...children,
          pw.SizedBox(height: 24),
        ]);
  }

  pw.Widget _buildEducationItem(Education edu) {
    final dateRange =
        '${formatter.format(edu.startDate)} - ${edu.isCurrent ? "Present" : formatter.format(edu.endDate!)}';
    return pw.Padding(
        padding: const pw.EdgeInsets.only(bottom: 12),
        child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(edu.degreeName,
                  style: pw.TextStyle(
                      color: Template03Colors.lightText,
                      fontWeight: pw.FontWeight.bold,
                      fontSize: 10)),
              pw.Text(edu.school,
                  style: const pw.TextStyle(
                      color: Template03Colors.lightText, fontSize: 9)),
              pw.Text(dateRange,
                  style: const pw.TextStyle(
                      color: Template03Colors.accent, fontSize: 9)),
            ]));
  }

  pw.Widget _buildListItem(String text) {
    return pw.Padding(
        padding: const pw.EdgeInsets.only(bottom: 4),
        child: pw.Text(text,
            style: const pw.TextStyle(
                color: Template03Colors.lightText, fontSize: 10)));
  }
}

// --- 5. ويدجت العمود الرئيسي (الأيمن) ---
class _MainColumnTemplate03 extends pw.StatelessWidget {
  final CVData data;
  final pw.Font iconFont;
  final bool showReferencesNote;

  _MainColumnTemplate03(
      {required this.data,
      required this.iconFont,
      required this.showReferencesNote});

  @override
  pw.Widget build(pw.Context context) {
    final sortedExperience = List<Experience>.from(data.experiences)
      ..sort((a, b) => b.startDate.compareTo(a.startDate));
    final DateFormat formatter = DateFormat('MMM yyyy');

    return pw.Container(
      padding: const pw.EdgeInsets.fromLTRB(25, 25, 25, 20),
      color: Template03Colors.background,
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          if (data.personalInfo.summary.isNotEmpty)
            _buildMainSection(title: 'About Me', children: [
              pw.Text(data.personalInfo.summary,
                  style: const pw.TextStyle(
                      fontSize: 9,
                      lineSpacing: 2,
                      color: Template03Colors.subtleText),
                  textAlign: pw.TextAlign.justify),
            ]),
          if (sortedExperience.isNotEmpty)
            _buildMainSection(
                title: 'Experience',
                children: sortedExperience.map((exp) {
                  return _buildExperienceItem(exp, iconFont, formatter);
                }).toList()),
          _buildReferencesSection(data, showReferencesNote),
        ],
      ),
    );
  }

  pw.Widget _buildMainSection(
      {required String title, required List<pw.Widget> children}) {
    return pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(title.toUpperCase(),
              style: pw.TextStyle(
                  color: Template03Colors.darkText,
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 14)),
          pw.Container(
              height: 1.5,
              width: 40,
              color: Template03Colors.accent,
              margin: const pw.EdgeInsets.only(top: 4, bottom: 12)),
          ...children,
          pw.SizedBox(height: 24),
        ]);
  }

  pw.Widget _buildExperienceItem(
      Experience experience, pw.Font iconFont, DateFormat formatter) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 12),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text(
                experience.position.toUpperCase(),
                style: pw.TextStyle(
                    fontSize: 11,
                    fontWeight: pw.FontWeight.bold,
                    color: Template03Colors.darkText),
              ),
              pw.Text(
                '${formatter.format(experience.startDate)} - ${experience.isCurrent ? "Present" : formatter.format(experience.endDate!)}',
                style: const pw.TextStyle(
                    fontSize: 9, color: Template03Colors.subtleText),
              ),
            ],
          ),
          pw.Text(
            experience.companyName,
            style: pw.TextStyle(
                fontSize: 10,
                color: Template03Colors.subtleText,
                fontStyle: pw.FontStyle.italic),
          ),
          pw.SizedBox(height: 6),
          pw.Text(
            experience.description.replaceAll('•', '').trim(),
            textAlign: pw.TextAlign.justify,
            style: const pw.TextStyle(
                fontSize: 9,
                color: Template03Colors.subtleText,
                lineSpacing: 2),
          ),
        ],
      ),
    );
  }

  pw.Widget _buildReferencesSection(CVData data, bool showReferencesNote) {
    if (showReferencesNote) {
      return _buildMainSection(title: 'Reference', children: [
        pw.Text('References available upon request.',
            style: pw.TextStyle(
                fontSize: 9,
                fontStyle: pw.FontStyle.italic,
                color: Template03Colors.subtleText)),
      ]);
    } else if (data.references.isNotEmpty) {
      return _buildMainSection(title: 'Reference', children: [
        pw.Wrap(
            spacing: 20,
            runSpacing: 15,
            children:
                data.references.map((ref) => _buildReferenceItem(ref)).toList())
      ]);
    }
    return pw.SizedBox();
  }

  pw.Widget _buildReferenceItem(Reference reference) {
    return pw.SizedBox(
        width: 150,
        child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('${reference.name} | ${reference.position}',
                  style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                      color: Template03Colors.darkText,
                      fontSize: 9)),
              pw.Text(reference.company,
                  style: pw.TextStyle(
                      fontSize: 8,
                      color: Template03Colors.subtleText,
                      fontStyle: pw.FontStyle.italic)),
              pw.SizedBox(height: 4),
              if (reference.phone != null && reference.phone!.isNotEmpty)
                pw.Text(reference.phone!,
                    style: const pw.TextStyle(
                        fontSize: 8, color: Template03Colors.subtleText))
            ]));
  }
}
