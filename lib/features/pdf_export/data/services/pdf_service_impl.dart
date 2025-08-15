// features/pdf_export/data/services/pdf_service_impl.dart
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:cv_pro/core/services/pdf_service.dart';
import 'package:cv_pro/features/cv_form/data/models/cv_data.dart';
import 'package:cv_pro/features/pdf_export/layout/pdf_layout_builder.dart';

final showReferencesNoteProvider = StateProvider<bool>((ref) => true);

/// A record to bundle data for the isolate.
typedef _PdfGenerationData = ({
  CVData data,
  bool showReferencesNote,
});

/// ✅ NEW: Top-level function to run in the isolate.
/// This function is self-contained: it initializes fonts, builds the layout,
/// and saves the PDF. It's the heavy work we want off the main thread.
Future<Uint8List> _generatePdfInBackground(_PdfGenerationData params) async {
  final doc = pw.Document();
  final font = await PdfGoogleFonts.latoRegular();
  final boldFont = await PdfGoogleFonts.latoBold();
  final iconFontData =
      await rootBundle.load('assets/fonts/MaterialIcons-Regular.ttf');
  final iconFont = pw.Font.ttf(iconFontData);

  final layoutWidget = await buildPdfLayout(
    data: params.data,
    iconFont: iconFont,
    showReferencesNote: params.showReferencesNote,
  );

  doc.addPage(
    pw.Page(
      margin: pw.EdgeInsets.zero,
      theme: pw.ThemeData.withFont(
        base: font,
        bold: boldFont,
      ),
      build: (pw.Context context) {
        return layoutWidget;
      },
    ),
  );

  return doc.save();
}

class PdfServiceImpl implements PdfService {
  @override
  Future<Uint8List> generateCv(CVData data,
      {required bool showReferencesNote}) async {
    // ✅ PERFORMANCE: Use Flutter's `compute` function to run the heavy
    // PDF generation on a separate isolate. This prevents UI freezing.
    final params = (data: data, showReferencesNote: showReferencesNote);
    return await compute(_generatePdfInBackground, params);
  }
}
