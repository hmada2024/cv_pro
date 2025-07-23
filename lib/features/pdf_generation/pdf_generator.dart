import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:cv_pro/features/cv_creation/models/cv_data.dart';
import 'package:cv_pro/features/cv_creation/providers/cv_data_provider.dart';
import 'package:intl/intl.dart';

// دالة مساعدة لإنشاء عنوان قسم موحد
pw.Widget _buildSectionTitle(String title, pw.Font font, AppLanguage language) {
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

Future<Uint8List> generatePdf(CVData data, AppLanguage language) async {
  final pdf = pw.Document();
  final pw.Font font, boldFont;
  final pw.TextDirection textDirection;

  if (language == AppLanguage.arabic) {
    final fontData = await rootBundle.load("assets/fonts/Cairo-Regular.ttf");
    font = pw.Font.ttf(fontData);
    boldFont = pw.Font.ttf(fontData);
    textDirection = pw.TextDirection.rtl;
  } else {
    font = pw.Font.helvetica();
    boldFont = pw.Font.helveticaBold();
    textDirection = pw.TextDirection.ltr;
  }

  pdf.addPage(
    pw.Page(
      theme: pw.ThemeData.withFont(base: font, bold: boldFont),
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.all(30), // تقليل الهوامش
      build: (pw.Context context) {
        return pw.Directionality(
          textDirection: textDirection,
          child: pw.Column(
            children: [
              // ===== Header =====
              pw.Container(
                alignment: pw.Alignment.center,
                child: pw.Column(
                  children: [
                    pw.Text(
                      data.personalInfo.name,
                      style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold, fontSize: 26),
                    ),
                    pw.SizedBox(height: 5),
                    pw.Text(data.personalInfo.jobTitle,
                        style: const pw.TextStyle(
                            fontSize: 16, color: PdfColors.grey700)),
                    pw.SizedBox(height: 5),
                    pw.Text(data.personalInfo.email,
                        style: const pw.TextStyle(
                            fontSize: 12, color: PdfColors.blue700)),
                  ],
                ),
              ),
              pw.SizedBox(height: 20),

              // ===== Body (Two Columns) =====
              pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  // --- Left Column (Main Content) ---
                  pw.Expanded(
                    flex: 2, // يأخذ ثلثي المساحة
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        // Experience Section
                        _buildSectionTitle(
                            language == AppLanguage.arabic
                                ? 'الخبرة العملية'
                                : 'Work Experience',
                            font,
                            language),
                        ...data.experiences.map(
                            (exp) => _buildExperienceItem(exp, language, font)),
                      ],
                    ),
                  ),

                  pw.SizedBox(width: 30),

                  // --- Right Column (Side Bar) ---
                  pw.Expanded(
                    flex: 1, // يأخذ ثلث المساحة
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        // Skills Section
                        _buildSectionTitle(
                            language == AppLanguage.arabic
                                ? 'المهارات'
                                : 'Skills',
                            font,
                            language),
                        ...data.skills.map((skill) => pw.Bullet(
                            text: skill.name,
                            style: const pw.TextStyle(fontSize: 11))),
                        pw.SizedBox(height: 20),

                        // Languages Section
                        _buildSectionTitle(
                            language == AppLanguage.arabic
                                ? 'اللغات'
                                : 'Languages',
                            font,
                            language),
                        ...data.languages.map((lang) => pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Text(lang.name,
                                    style: pw.TextStyle(
                                        fontWeight: pw.FontWeight.bold,
                                        fontSize: 11)),
                                pw.Text(lang.proficiency,
                                    style: const pw.TextStyle(
                                        color: PdfColors.grey600,
                                        fontSize: 10)),
                                pw.SizedBox(height: 5),
                              ],
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    ),
  );

  return pdf.save();
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
                style:
                    pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 13)),
            pw.Text(
              '${formatter.format(exp.startDate)} - ${formatter.format(exp.endDate)}',
              textDirection: pw.TextDirection.ltr,
              style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey600),
            ),
          ],
        ),
        pw.Text(exp.companyName,
            style: const pw.TextStyle(color: PdfColors.grey700, fontSize: 11)),
        pw.SizedBox(height: 5),
        pw.Text(
          exp.description,
          style: const pw.TextStyle(fontSize: 11, lineSpacing: 2),
          textAlign: pw.TextAlign.justify,
        ),
      ],
    ),
  );
}
