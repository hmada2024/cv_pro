import 'package:cv_pro/features/pdf_export/data/templates/classic_template_builder.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:cv_pro/core/services/pdf_service.dart';
import 'package:cv_pro/features/cv_form/data/models/cv_data.dart';
import 'package:cv_pro/features/cv_form/data/providers/cv_form_provider.dart';

class PdfServiceImpl implements PdfService {
  @override
  Future<Uint8List> generateCv(CVData data, AppLanguage language) async {
    final pdf = pw.Document();

    final arabicFont =
        pw.Font.ttf(await rootBundle.load("assets/fonts/Cairo-Regular.ttf"));

    // الآن نمرر الخط الصحيح إلى دالة بناء القالب
    final pw.Font fontToUse = arabicFont;
    final pw.TextDirection textDirection = (language == AppLanguage.arabic)
        ? pw.TextDirection.rtl
        : pw.TextDirection.ltr;

    pdf.addPage(
      pw.Page(
        theme: pw.ThemeData.withFont(base: fontToUse, bold: fontToUse),
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(30),
        build: (pw.Context context) {
          // استدعاء دالة بناء القالب المنفصلة وتمرير كل ما تحتاجه
          return buildClassicTemplate(
            data: data,
            font: fontToUse,
            language: language,
            textDirection: textDirection,
          );
        },
      ),
    );

    return pdf.save();
  }
}
