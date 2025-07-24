import 'package:flutter/foundation.dart'; // <<< أضف هذا السطر
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:cv_pro/core/services/pdf_service.dart';
import 'package:cv_pro/features/cv_form/data/models/cv_data.dart';
import 'package:cv_pro/features/cv_form/data/providers/cv_form_provider.dart';
import 'package:cv_pro/features/pdf_export/templates/classic_template_builder.dart';

class PdfServiceImpl implements PdfService {
  @override
  Future<Uint8List> generateCv(CVData data, AppLanguage language) async {
    final pdf = pw.Document();

    pw.Font? arabicFont;

    // ================== الكود التشخيصي ==================
    // سنحاول تحميل الخط، وإذا فشل، سيتم طباعة الخطأ في الـ Console
    try {
      debugPrint("Attempting to load font: assets/fonts/Cairo-Regular.ttf");
      final fontData = await rootBundle.load("assets/fonts/Cairo-Regular.ttf");
      arabicFont = pw.Font.ttf(fontData);
      debugPrint("✅ Font loaded successfully!");
    } catch (e) {
      debugPrint("❌ FAILED TO LOAD FONT: $e");
      // إذا فشل تحميل الخط، سنستخدم خطًا احتياطيًا لنرى ما إذا كانت البيانات تظهر
      // هذا سيؤدي إلى ظهور حروف غريبة، لكنه سيؤكد أن المشكلة في الخط فقط
      arabicFont = pw.Font.symbol();
    }
    // ====================================================

    final pw.Font fontToUse = arabicFont;
    final pw.TextDirection textDirection =
        (language == AppLanguage.arabic) ? pw.TextDirection.rtl : pw.TextDirection.ltr;

    pdf.addPage(
      pw.Page(
        theme: pw.ThemeData.withFont(base: fontToUse, bold: fontToUse),
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(30),
        build: (pw.Context context) {
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