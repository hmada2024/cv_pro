import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:cv_pro/features/cv_form/data/models/cv_data.dart';
import 'package:cv_pro/features/cv_form/data/providers/cv_form_provider.dart';

// هذه الدالة مسؤولة فقط عن التصميم والترتيب.
// تأخذ البيانات والخط وتبني شكل الـ PDF.
pw.Widget buildClassicTemplate({
  required CVData data,
  required pw.Font font,
  required AppLanguage language,
  required pw.TextDirection textDirection,
}) {
  return pw.Directionality(
    textDirection: textDirection,
    child: pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        // --- Header Section ---
        pw.Container(
          alignment: pw.Alignment.center,
          child: pw.Column(
            children: [
              pw.Text(data.personalInfo.name,
                  style: pw.TextStyle(font: font, fontSize: 26)),
              pw.SizedBox(height: 5),
              pw.Text(data.personalInfo.jobTitle,
                  style: pw.TextStyle(
                      font: font, fontSize: 16, color: PdfColors.grey700)),
              pw.SizedBox(height: 5),
              pw.Text(data.personalInfo.email,
                  style: pw.TextStyle(
                      font: font, fontSize: 12, color: PdfColors.blue700)),
            ],
          ),
        ),
        pw.SizedBox(height: 20),
        pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            // --- Left Column (Experience) ---
            pw.Expanded(
              flex: 2,
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle(language == AppLanguage.arabic ? 'الخبرة العملية' : 'Work Experience', font),
                  ...data.experiences
                      .map((exp) => _buildExperienceItem(exp, language, font)),
                ],
              ),
            ),
            pw.SizedBox(width: 30),
            // --- Right Column (Skills & Languages) ---
            pw.Expanded(
              flex: 1,
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle(language == AppLanguage.arabic ? 'المهارات' : 'Skills', font),
                  ...data.skills.map((skill) => pw.Bullet(
                        text: skill.name,
                        style: pw.TextStyle(font: font, fontSize: 11),
                      )),
                  pw.SizedBox(height: 20),
                  _buildSectionTitle(language == AppLanguage.arabic ? 'اللغات' : 'Languages', font),
                  ...data.languages.map((lang) => pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text(lang.name, style: pw.TextStyle(font: font, fontSize: 11)),
                            pw.Text(lang.proficiency,
                                style: pw.TextStyle(
                                    font: font,
                                    fontSize: 10,
                                    color: PdfColors.grey600)),
                            pw.SizedBox(height: 5),
                          ])),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

pw.Widget _buildSectionTitle(String title, pw.Font font) {
  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      pw.Text(
        title.toUpperCase(),
        style: pw.TextStyle(
          font: font,
          fontWeight: pw.FontWeight.bold,
          fontSize: 14,
          color: PdfColors.blueGrey800,
        ),
      ),
      pw.Container(height: 2, width: 40, color: PdfColors.blueGrey800),
      pw.SizedBox(height: 10),
    ],
  );
}

pw.Widget _buildExperienceItem(
    Experience exp, AppLanguage language, pw.Font font) {
  final locale = language == AppLanguage.english ? 'en_US' : 'ar_EG';
  final formatter = DateFormat('MMM yyyy', locale);
  return pw.Container(
    margin: const pw.EdgeInsets.only(bottom: 15),
    child: pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text(exp.position,
                style: pw.TextStyle(
                    font: font, fontSize: 13, fontWeight: pw.FontWeight.bold)),
            pw.Text(
              '${formatter.format(exp.startDate)} - ${formatter.format(exp.endDate)}',
              textDirection: pw.TextDirection.ltr,
              style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey600),
            ),
          ],
        ),
        pw.Text(exp.companyName,
            style: pw.TextStyle(
                font: font, color: PdfColors.grey700, fontSize: 11)),
        pw.SizedBox(height: 5),
        pw.Text(
          exp.description,
          style: pw.TextStyle(font: font, fontSize: 11, lineSpacing: 2),
          textAlign: pw.TextAlign.justify,
        ),
      ],
    ),
  );
}
