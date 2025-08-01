import 'package:cv_pro/features/pdf_export/templates/corporate_blue/corporate_blue_template_builder.dart';
import 'package:cv_pro/features/pdf_export/templates/creative/creative_template_builder.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:cv_pro/core/services/pdf_service.dart';
import 'package:cv_pro/features/cv_form/data/models/cv_data.dart';

enum CvTemplate { modern, corporateBlue }

final selectedTemplateProvider =
    StateProvider<CvTemplate>((ref) => CvTemplate.modern);

// ✅✅ NEW: Provider to manage the state of the "References available upon request" note ✅✅
final showReferencesNoteProvider = StateProvider<bool>((ref) => false);

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
      case CvTemplate.modern:
        content = await buildModernTemplate(
          data: data,
          iconFont: iconTtf,
          showReferencesNote: showReferencesNote, // ✅ NEW: Pass the option
        );
        break;
      case CvTemplate.corporateBlue:
        content = await buildCorporateBlueTemplate(
          data: data,
          iconFont: iconTtf,
          showReferencesNote: showReferencesNote, // ✅ NEW: Pass the option
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
