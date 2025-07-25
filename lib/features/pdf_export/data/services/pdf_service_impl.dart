// تم حذف import 'dart:typed_data' غير المستخدم
import 'package:flutter/foundation.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:cv_pro/core/services/pdf_service.dart';
import 'package:cv_pro/features/cv_form/data/models/cv_data.dart';
import 'package:cv_pro/features/pdf_export/templates/classic_template_builder.dart';

class PdfServiceImpl implements PdfService {
  @override
  Future<Uint8List> generateCv(CVData data) async {
    final pdf = pw.Document();

    final pw.Font baseFont = pw.Font.helvetica();
    final pw.Font boldFont = pw.Font.helveticaBold();
    final pw.Font italicFont = pw.Font.helveticaOblique();
    final pw.Font boldItalicFont = pw.Font.helveticaBoldOblique();

    debugPrint("Generating PDF with ${data.experiences.length} experiences.");
    debugPrint("Generating PDF with ${data.skills.length} skills.");

    pdf.addPage(
      pw.Page(
        theme: pw.ThemeData.withFont(
          base: baseFont,
          bold: boldFont,
          italic: italicFont,
          boldItalic: boldItalicFont,
        ),
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(30),
        build: (pw.Context context) {
          return buildClassicTemplate(
            data: data,
          );
        },
      ),
    );

    return pdf.save();
  }
}
