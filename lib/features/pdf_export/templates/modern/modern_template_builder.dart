import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:cv_pro/features/cv_form/data/models/cv_data.dart';

const PdfColor primaryColor = PdfColor.fromInt(0xFF2C3E50);
const PdfColor accentColor = PdfColor.fromInt(0xFF3498DB);
const PdfColor lightGreyColor = PdfColor.fromInt(0xFFBDC3C7);
const PdfColor darkGreyColor = PdfColor.fromInt(0xFF7F8C8D);

Future<pw.Widget> buildModernTemplate({
  required CVData data,
  required pw.Font iconFont,
}) async {
  pw.ImageProvider? profileImage;
  // ✅✅ تم التصحيح: التحقق من مسار الصورة وقراءته عند الحاجة ✅✅
  if (data.personalInfo.profileImagePath != null) {
      final imageFile = File(data.personalInfo.profileImagePath!);
      if (await imageFile.exists()) {
          final imageBytes = await imageFile.readAsBytes();
          profileImage = pw.MemoryImage(imageBytes);
      }
  }

  return pw.Row(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      pw.Expanded(
        flex: 1,
        child: pw.Container(
          color: primaryColor,
          padding: const pw.EdgeInsets.all(20),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              if (profileImage != null)
                pw.ClipOval(
                  child: pw.Container(
                    width: 120,
                    height: 120,
                    child: pw.Image(profileImage, fit: pw.BoxFit.cover),
                  ),
                ),
              if (profileImage != null) pw.SizedBox(height: 20),
              _sideBarHeader('CONTACT'),
              _contactInfo(
                  icon: const pw.IconData(0xe0b0),
                  text: data.personalInfo.phone ?? '',
                  iconFont: iconFont),
              _contactInfo(
                  icon: const pw.IconData(0xe158),
                  text: data.personalInfo.email,
                  iconFont: iconFont),
              _contactInfo(
                  icon: const pw.IconData(0xe55f),
                  text: data.personalInfo.address ?? '',
                  iconFont: iconFont),
              pw.SizedBox(height: 20),
              if (data.education.isNotEmpty) _sideBarHeader('EDUCATION'),
              ...data.education.map((edu) => _educationInfo(edu)),
              pw.SizedBox(height: 20),
              if (data.skills.isNotEmpty) _sideBarHeader('SKILLS'),
              ...data.skills.map((skill) => _skillItem(skill.name)),
              pw.SizedBox(height: 20),
              if (data.languages.isNotEmpty) _sideBarHeader('LANGUAGES'),
              ...data.languages.map((lang) => _languageItem(lang)),
            ],
          ),
        ),
      ),
      pw.Expanded(
        flex: 2,
        child: pw.Container(
          padding: const pw.EdgeInsets.symmetric(horizontal: 30, vertical: 40),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                data.personalInfo.name.toUpperCase(),
                style: pw.TextStyle(
                    fontSize: 32,
                    fontWeight: pw.FontWeight.bold,
                    color: primaryColor),
              ),
              pw.SizedBox(height: 5),
              pw.Text(
                data.personalInfo.jobTitle.toUpperCase(),
                style: const pw.TextStyle(fontSize: 16, color: darkGreyColor),
              ),
              pw.Container(
                height: 2,
                width: 60,
                color: accentColor,
                margin: const pw.EdgeInsets.symmetric(vertical: 20),
              ),
              _mainHeader('PROFILE'),
              pw.Text(
                data.personalInfo.summary,
                style: const pw.TextStyle(fontSize: 10, lineSpacing: 4),
                textAlign: pw.TextAlign.justify,
              ),
              pw.SizedBox(height: 30),
              _mainHeader('WORK EXPERIENCE'),
              ...data.experiences.map((exp) => _experienceItem(exp)),
            ],
          ),
        ),
      ),
    ],
  );
}

// ... باقي الدوال المساعدة تبقى كما هي ...

pw.Widget _sideBarHeader(String text) {
  return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(text,
            style: pw.TextStyle(
                color: PdfColors.white,
                fontWeight: pw.FontWeight.bold,
                fontSize: 14)),
        pw.Container(height: 2, width: 40, color: accentColor),
        pw.SizedBox(height: 15),
      ]);
}

pw.Widget _mainHeader(String text) {
  return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(text,
            style: pw.TextStyle(
                color: primaryColor,
                fontWeight: pw.FontWeight.bold,
                fontSize: 16)),
        pw.SizedBox(height: 10),
      ]);
}

pw.Widget _contactInfo(
    {required pw.IconData icon,
    required String text,
    required pw.Font iconFont}) {
  return pw.Padding(
    padding: const pw.EdgeInsets.only(bottom: 8),
    child: pw.Row(
      children: [
        pw.Icon(icon, color: accentColor, font: iconFont, size: 14),
        pw.SizedBox(width: 10),
        pw.Expanded(
            child: pw.Text(text,
                style: const pw.TextStyle(color: PdfColors.white, fontSize: 9)))
      ],
    ),
  );
}

pw.Widget _educationInfo(Education edu) {
  return pw.Padding(
    padding: const pw.EdgeInsets.only(bottom: 10),
    child: pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(edu.degree,
            style: const pw.TextStyle(
                color: PdfColors.white, fontSize: 10)),
        pw.Text(edu.school,
            style: const pw.TextStyle(
                color: lightGreyColor, fontSize: 9)),
      ],
    ),
  );
}

pw.Widget _skillItem(String text) {
  return pw.Padding(
    padding: const pw.EdgeInsets.only(bottom: 4),
    child: pw.Row(
      children: [
        pw.Container(width: 5, height: 5, color: accentColor),
        pw.SizedBox(width: 10),
        pw.Text(text,
            style: const pw.TextStyle(color: PdfColors.white, fontSize: 10)),
      ],
    ),
  );
}

pw.Widget _languageItem(Language lang) {
  return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 4),
      child: pw.Text('${lang.name} (${lang.proficiency})',
          style: const pw.TextStyle(color: PdfColors.white, fontSize: 10)));
}

pw.Widget _experienceItem(Experience exp) {
  return pw.Padding(
    padding: const pw.EdgeInsets.only(bottom: 20),
    child: pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(exp.position.toUpperCase(),
            style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold)),
        pw.Text(exp.companyName,
            style: const pw.TextStyle(fontSize: 11, color: darkGreyColor)),
        pw.SizedBox(height: 5),
        pw.Text(exp.description,
            textAlign: pw.TextAlign.justify,
            style: const pw.TextStyle(fontSize: 10, lineSpacing: 2)),
      ],
    ),
  );
}