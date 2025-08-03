// features/pdf_export/data/services/pdf_service_impl.dart

import 'package:cv_pro/features/pdf_export/templates/templates_barrel.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:cv_pro/core/services/pdf_service.dart';
import 'package:cv_pro/features/cv_form/data/models/cv_data.dart';

enum CvTemplate { twoColumn01, twoColumn02 }

final selectedTemplateProvider =
    StateProvider<CvTemplate>((ref) => CvTemplate.twoColumn01);

final showReferencesNoteProvider = StateProvider<bool>((ref) => true);

class PdfServiceImpl implements PdfService {
  @override
  Future<Uint8List> generateCv(CVData data, CvTemplate template,
      {required bool showReferencesNote}) async {
    final pdf = pw.Document();

    final iconFont =
        await rootBundle.load("assets/fonts/MaterialIcons-Regular.ttf");
    final iconTtf = pw.Font.ttf(iconFont);

    pw.Widget content;

    switch (template) {
      case CvTemplate.twoColumn01:
        content = await buildTemplate01(
          data: data,
          iconFont: iconTtf,
          showReferencesNote: showReferencesNote,
        );
        break;
      case CvTemplate.twoColumn02:
        content = await buildTemplate02(
          data: data,
          iconFont: iconTtf,
          showReferencesNote: showReferencesNote,
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
        margin: pw.EdgeInsets.zero,
        build: (pw.Context context) {
          return content;
        },
      ),
    );

    return pdf.save();
  }
}
