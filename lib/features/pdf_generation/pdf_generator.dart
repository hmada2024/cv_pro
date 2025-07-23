import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:cv_pro/features/cv_creation/models/cv_data.dart';
import 'package:cv_pro/features/cv_creation/providers/cv_data_provider.dart';
import 'package:intl/intl.dart';

// هذه الدالة المساعدة لم تتغير
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

// هذه الدالة تم تعديلها لإضافة الخط لوصف الخبرة
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
            pw.Text(
              exp.position,
              style: pw.TextStyle(
                fontWeight: pw.FontWeight.bold,
                fontSize: 13,
                font: font, // تم إضافة الخط هنا أيضاً للاحتياط
              ),
            ),
            pw.Text(
              '${formatter.format(exp.startDate)} - ${formatter.format(exp.endDate)}',
              textDirection: pw.TextDirection.ltr,
              style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey600),
            ),
          ],
        ),
        pw.Text(
          exp.companyName,
          style: pw.TextStyle(
            color: PdfColors.grey700,
            fontSize: 11,
            font: font, // تم إضافة الخط هنا أيضاً للاحتياط
          ),
        ),
        pw.SizedBox(height: 5),
        pw.Text(
          exp.description,
          // <<<<<<<<< الإصلاح الرئيسي الأول هنا >>>>>>>>>
          // تم تمرير الخط العربي لوصف الخبرة لكي يظهر في الـ PDF
          style: pw.TextStyle(fontSize: 11, lineSpacing: 2, font: font),
          textAlign: pw.TextAlign.justify,
        ),
      ],
    ),
  );
}

// هذه هي الدالة الرئيسية التي تم إصلاحها
Future<Uint8List> generatePdf(CVData data, AppLanguage language) async {
  final pdf = pw.Document();
  final pw.Font font, boldFont;
  final pw.TextDirection textDirection;

  if (language == AppLanguage.arabic) {
    final fontData = await rootBundle.load("assets/fonts/Cairo-Regular.ttf");
    font = pw.Font.ttf(fontData);
    boldFont = pw.Font.ttf(fontData); // يمكنك استخدام نفس الخط للعادي والـ bold
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
      margin: const pw.EdgeInsets.all(30),
      build: (pw.Context context) {
        return pw.Directionality(
          textDirection: textDirection,
          child: pw.Column(
            children: [
              // قسم المعلومات الشخصية (لا يحتاج لتغيير كبير)
              pw.Container(
                alignment: pw.Alignment.center,
                child: pw.Column(
                  children: [
                    pw.Text(
                      data.personalInfo.name,
                      style: pw.TextStyle(
                          font: font,
                          fontWeight: pw.FontWeight.bold,
                          fontSize: 26),
                    ),
                    pw.SizedBox(height: 5),
                    pw.Text(
                      data.personalInfo.jobTitle,
                      style: pw.TextStyle(
                          font: font, fontSize: 16, color: PdfColors.grey700),
                    ),
                    pw.SizedBox(height: 5),
                    pw.Text(
                      data.personalInfo.email,
                      style: pw.TextStyle(
                          font: font, fontSize: 12, color: PdfColors.blue700),
                    ),
                  ],
                ),
              ),
              pw.SizedBox(height: 20),
              pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Expanded(
                    flex: 2,
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
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
                  pw.Expanded(
                    flex: 1,
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        _buildSectionTitle(
                            language == AppLanguage.arabic
                                ? 'المهارات'
                                : 'Skills',
                            font,
                            language),
                        if (data.skills.isNotEmpty)
                          ...data.skills.map(
                            (skill) => pw.Bullet(
                              text: skill.name,
                              // <<<<<<<<< الإصلاح الرئيسي الثاني هنا >>>>>>>>>
                              // تم تمرير الخط العربي للمهارات
                              style: pw.TextStyle(fontSize: 11, font: font),
                            ),
                          ),
                        pw.SizedBox(height: 20),
                        _buildSectionTitle(
                            language == AppLanguage.arabic
                                ? 'اللغات'
                                : 'Languages',
                            font,
                            language),
                        if (data.languages.isNotEmpty)
                          ...data.languages.map(
                            (lang) => pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Text(
                                  lang.name,
                                  // <<<<<<<<< الإصلاح الرئيسي الثالث هنا >>>>>>>>>
                                  // تم تمرير الخط العربي للغات
                                  style: pw.TextStyle(
                                      fontWeight: pw.FontWeight.bold,
                                      fontSize: 11,
                                      font: font),
                                ),
                                pw.Text(
                                  lang.proficiency,
                                  style: pw.TextStyle(
                                      color: PdfColors.grey600,
                                      fontSize: 10,
                                      font: font),
                                ),
                                pw.SizedBox(height: 5),
                              ],
                            ),
                          ),
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
