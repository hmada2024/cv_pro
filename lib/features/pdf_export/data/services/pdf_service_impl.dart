import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:cv_pro/core/services/pdf_service.dart';
import 'package:cv_pro/features/cv_form/data/models/cv_data.dart';
import 'package:cv_pro/features/pdf_export/templates/corporate_blue/corporate_blue_template_builder.dart';
import 'package:cv_pro/features/pdf_export/templates/modern/modern_template_builder.dart';

// ✅✅ تم تحديث الـ enum ✅✅
enum CvTemplate { modern, corporateBlue }

class PdfServiceImpl implements PdfService {
  @override
  Future<Uint8List> generateCv(CVData data, CvTemplate template) async {
    final pdf = pw.Document();

    final iconFont =
        await rootBundle.load("assets/fonts/MaterialIcons-Regular.ttf");
    final iconTtf = pw.Font.ttf(iconFont);

    pw.Widget content;

    // ✅✅ تم تحديث الـ switch statement ✅✅
    switch (template) {
      case CvTemplate.modern:
        content = await buildModernTemplate(
          data: data,
          iconFont: iconTtf,
        );
        break;
      case CvTemplate.corporateBlue:
        content = await buildCorporateBlueTemplate(
          data: data,
          iconFont: iconTtf,
        );
        break;
    }

    pdf.addPage(
      pw.Page(
        theme: pw.ThemeData.withFont(
          base: pw.Font.helvetica(),
          bold: pw.Font.helveticaBold(),
        ),
        pageFormat: PdfPageFormat.a4,
        // القوالب الجديدة لا تحتاج هوامش
        margin: pw.EdgeInsets.zero,
        build: (pw.Context context) {
          return content;
        },
      ),
    );

    return pdf.save();
  }
}
