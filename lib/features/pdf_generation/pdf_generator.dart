import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:cv_pro/features/cv_form/data/models/cv_data.dart';
import 'package:cv_pro/features/cv_form/data/providers/cv_data_provider.dart';
import 'package:intl/intl.dart';

// Helper function to build section titles
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

// Helper function to build a single experience item
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
                  fontWeight: pw.FontWeight.bold, fontSize: 13, font: font),
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
          style:
              pw.TextStyle(color: PdfColors.grey700, fontSize: 11, font: font),
        ),
        pw.SizedBox(height: 5),
        pw.Text(
          exp.description,
          style: pw.TextStyle(fontSize: 11, lineSpacing: 2, font: font),
          textAlign: pw.TextAlign.justify,
        ),
      ],
    ),
  );
}

// Main PDF generation function
Future<Uint8List> generatePdf(CVData data, AppLanguage language) async {
  final pdf = pw.Document();
  final pw.Font font;
  final pw.TextDirection textDirection;

  if (language == AppLanguage.arabic) {
    final fontData = await rootBundle.load("assets/fonts/Cairo-Regular.ttf");
    font = pw.Font.ttf(fontData);
    textDirection = pw.TextDirection.rtl;
  } else {
    font =
        await PdfGoogleFonts.latoRegular(); // Using a Google font for English
    textDirection = pw.TextDirection.ltr;
  }

  // A simple test to make sure data is arriving correctly
  debugPrint("Generating PDF with ${data.experiences.length} experiences.");
  debugPrint("Generating PDF with ${data.skills.length} skills.");

  pdf.addPage(
    pw.Page(
      theme: pw.ThemeData.withFont(base: font, bold: font),
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.all(30),
      build: (pw.Context context) {
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
                        style: pw.TextStyle(
                            font: font,
                            fontWeight: pw.FontWeight.bold,
                            fontSize: 26)),
                    pw.SizedBox(height: 5),
                    pw.Text(data.personalInfo.jobTitle,
                        style: pw.TextStyle(
                            font: font,
                            fontSize: 16,
                            color: PdfColors.grey700)),
                    pw.SizedBox(height: 5),
                    pw.Text(data.personalInfo.email,
                        style: pw.TextStyle(
                            font: font,
                            fontSize: 12,
                            color: PdfColors.blue700)),
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
                        _buildSectionTitle(
                            language == AppLanguage.arabic
                                ? 'الخبرة العملية'
                                : 'Work Experience',
                            font),
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
                            font),
                        ...data.skills.map((skill) => pw.Bullet(
                              text: skill.name,
                              style: pw.TextStyle(fontSize: 11, font: font),
                            )),
                        pw.SizedBox(height: 20),
                        _buildSectionTitle(
                            language == AppLanguage.arabic
                                ? 'اللغات'
                                : 'Languages',
                            font),
                        ...data.languages.map((lang) => pw.Column(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.Text(lang.name,
                                      style: pw.TextStyle(
                                          fontWeight: pw.FontWeight.bold,
                                          fontSize: 11,
                                          font: font)),
                                  pw.Text(lang.proficiency,
                                      style: pw.TextStyle(
                                          color: PdfColors.grey600,
                                          fontSize: 10,
                                          font: font)),
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
      },
    ),
  );

  return pdf.save();
}

// Added this to avoid a direct dependency on printing/google_fonts in this file.
// In a real app, this might come from a service.
class PdfGoogleFonts {
  static Future<pw.Font> latoRegular() async {
    final fontData = await rootBundle.load("assets/fonts/Lato-Regular.ttf");
    return pw.Font.ttf(fontData);
  }
}
