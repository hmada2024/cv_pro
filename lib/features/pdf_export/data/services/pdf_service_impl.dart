import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:cv_pro/core/services/pdf_service.dart';
import 'package:cv_pro/features/cv_form/data/models/cv_data.dart';
import 'package:cv_pro/features/pdf_export/templates/classic_template_builder.dart';
import 'package:cv_pro/features/pdf_export/templates/modern_template_builder.dart';

// تعريف الـ enum هنا ليكون مرتبطًا بالتنفيذ
enum CvTemplate { classic, modern }

class PdfServiceImpl implements PdfService {
  @override
  Future<Uint8List> generateCv(CVData data, CvTemplate template) async {
    final pdf = pw.Document();

    // تحميل خطوط الأيقونات والنصوص
    final font = await rootBundle.load("assets/fonts/Cairo-Regular.ttf");
    final ttf = pw.Font.ttf(font);

    // خط الأيقونات
    final iconFont =
        await rootBundle.load("assets/fonts/MaterialIcons-Regular.ttf");
    final iconTtf = pw.Font.ttf(iconFont);

    pw.Widget content;

    // استخدام switch لاختيار الباني المناسب
    switch (template) {
      case CvTemplate.classic:
        content = buildClassicTemplate(data: data);
        break;
      case CvTemplate.modern:
        content = await buildModernTemplate(
          data: data,
          baseFont: ttf,
          iconFont: iconTtf,
        );
        break;
    }

    pdf.addPage(
      pw.Page(
        theme: pw.ThemeData.withFont(
          base: ttf,
          bold:
              pw.Font.ttf(await rootBundle.load("assets/fonts/Cairo-Bold.ttf")),
        ),
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.zero, // القالب العصري لا يحتاج إلى هوامش
        build: (pw.Context context) {
          return content;
        },
      ),
    );

    return pdf.save();
  }
}
