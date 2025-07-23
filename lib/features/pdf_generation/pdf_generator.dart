import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:cv_pro/features/cv_creation/models/cv_data.dart';
import 'package:cv_pro/features/cv_creation/providers/cv_data_provider.dart';
import 'package:intl/intl.dart';

Future<Uint8List> generatePdf(CVData data, AppLanguage language) async {
  final pdf = pw.Document();

  // تحديد الخط والاتجاه بناءً على اللغة
  final pw.Font font;
  final pw.TextDirection textDirection;
  final pw.Font boldFont;

  if (language == AppLanguage.arabic) {
    final fontData = await rootBundle.load("assets/fonts/Cairo-Regular.ttf");
    // يمكنك تحميل خط Bold إذا أردت دقة أكبر
    font = pw.Font.ttf(fontData);
    boldFont = pw.Font.ttf(fontData); // استخدام نفس الخط للـ Bold حالياً
    textDirection = pw.TextDirection.rtl;
  } else {
    // للغة الإنجليزية، نستخدم خطوط PDF المدمجة
    font = pw.Font.helvetica();
    boldFont = pw.Font.helveticaBold();
    textDirection = pw.TextDirection.ltr;
  }

  pdf.addPage(
    pw.Page(
      theme: pw.ThemeData.withFont(base: font, bold: boldFont),
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return pw.Directionality(
          textDirection: textDirection,
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // قسم المعلومات الشخصية
              pw.Container(
                width: double.infinity,
                padding: const pw.EdgeInsets.all(16),
                color: PdfColors.blueGrey800,
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.center,
                  children: [
                    pw.Text(
                      data.personalInfo.name,
                      style: pw.TextStyle(
                          fontSize: 24,
                          color: PdfColors.white,
                          fontWeight: pw.FontWeight.bold),
                    ),
                    pw.SizedBox(height: 5),
                    pw.Text(
                      data.personalInfo.jobTitle,
                      style: const pw.TextStyle(
                          fontSize: 16, color: PdfColors.white),
                    ),
                    pw.SizedBox(height: 5),
                    pw.Text(
                      data.personalInfo.email,
                      style: const pw.TextStyle(
                          fontSize: 12, color: PdfColors.blueGrey200),
                    ),
                  ],
                ),
              ),
              pw.SizedBox(height: 20),

              // قسم الخبرة العملية
              pw.Text(
                language == AppLanguage.arabic
                    ? 'الخبرة العملية'
                    : 'Work Experience',
                style: pw.TextStyle(
                  fontSize: 18,
                  fontWeight: pw.FontWeight.bold,
                  color: PdfColors.blueGrey800,
                ),
              ),
              pw.Divider(color: PdfColors.blueGrey200, thickness: 2),

              // عرض قائمة الخبرات
              ...data.experiences
                  .map((exp) => _buildExperienceItem(exp, language, font)),
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
  // استخدام locale لتنسيق التاريخ بناءً على اللغة
  final locale = language == AppLanguage.english ? 'en_US' : 'ar_EG';
  final formatter = DateFormat('MMM yyyy', locale);

  final positionWidget = pw.Text(
    exp.position,
    style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
  );

  final companyWidget = pw.Text(
    exp.companyName,
    style: const pw.TextStyle(fontSize: 14, color: PdfColors.grey700),
  );

  final dateWidget = pw.Text(
    '${formatter.format(exp.startDate)} - ${formatter.format(exp.endDate)}',
    style: const pw.TextStyle(fontSize: 12, color: PdfColors.grey600),
    textDirection: pw.TextDirection.ltr, // التواريخ دائماً ltr
  );

  return pw.Container(
    margin: const pw.EdgeInsets.only(bottom: 15),
    child: pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            // الترتيب هنا سيتم عكسه تلقائياً في العربية بفضل Directionality
            positionWidget,
            dateWidget,
          ],
        ),
        companyWidget,
        pw.SizedBox(height: 5),
        pw.Text(
          exp.description,
          style: const pw.TextStyle(fontSize: 12),
        ),
      ],
    ),
  );
}
