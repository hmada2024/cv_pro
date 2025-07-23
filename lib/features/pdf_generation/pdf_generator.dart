import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:cv_pro/features/cv_creation/models/cv_data.dart';
import 'package:intl/intl.dart';

Future<Uint8List> generatePdf(CVData data) async {
  final pdf = pw.Document();

  // تحميل الخط العربي من مجلد assets
  final fontData = await rootBundle.load("assets/fonts/Cairo-Regular.ttf");
  final arabicFont = pw.Font.ttf(fontData);

  pdf.addPage(
    pw.Page(
      theme: pw.ThemeData.withFont(base: arabicFont, bold: arabicFont),
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return pw.Directionality(
          textDirection: pw.TextDirection.rtl, // دعم الاتجاه من اليمين لليسار
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // 1. قسم المعلومات الشخصية
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

              // 2. قسم الخبرة العملية
              pw.Text('الخبرة العملية',
                  style: pw.TextStyle(
                      fontSize: 18,
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColors.blueGrey800)),
              pw.Divider(color: PdfColors.blueGrey200, thickness: 2),

              // عرض قائمة الخبرات
              ...data.experiences
                  .map((exp) => _buildExperienceItem(exp))
                  ,
            ],
          ),
        );
      },
    ),
  );

  return pdf.save();
}

// دالة مساعدة لبناء عنصر الخبرة
pw.Widget _buildExperienceItem(Experience exp) {
  final formatter = DateFormat('yyyy/MM');
  return pw.Container(
    margin: const pw.EdgeInsets.only(bottom: 15),
    child: pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(exp.position,
            style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text(exp.companyName,
                style: pw.TextStyle(fontSize: 14, color: PdfColors.grey700)),
            pw.Text(
              '${formatter.format(exp.startDate)} - ${formatter.format(exp.endDate)}',
              style: pw.TextStyle(fontSize: 12, color: PdfColors.grey600),
            ),
          ],
        ),
        pw.SizedBox(height: 5),
        pw.Text(exp.description, style: const pw.TextStyle(fontSize: 12)),
      ],
    ),
  );
}
