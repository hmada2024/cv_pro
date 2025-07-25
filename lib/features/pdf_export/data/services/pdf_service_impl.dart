import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:cv_pro/core/services/pdf_service.dart';
import 'package:cv_pro/features/cv_form/data/models/cv_data.dart';
import 'package:cv_pro/features/pdf_export/templates/classic/classic_template_builder.dart';
import 'package:cv_pro/features/pdf_export/templates/modern/modern_template_builder.dart';

enum CvTemplate { classic, modern }

class PdfServiceImpl implements PdfService {
  @override
  Future<Uint8List> generateCv(CVData data, CvTemplate template) async {
    final pdf = pw.Document();

    final iconFont =
        await rootBundle.load("assets/fonts/MaterialIcons-Regular.ttf");
    final iconTtf = pw.Font.ttf(iconFont);

    pw.Widget content;

    switch (template) {
      case CvTemplate.classic:
        content = buildClassicTemplate(data: data);
        break;
      case CvTemplate.modern:
        content = await buildModernTemplate(
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
        margin: template == CvTemplate.modern
            ? pw.EdgeInsets.zero
            : const pw.EdgeInsets.all(30),
        build: (pw.Context context) {
          return content;
        },
      ),
    );

    return pdf.save();
  }
}
