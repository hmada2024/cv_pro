// features/pdf_export/data/services/pdf_service_impl.dart
import 'package:flutter/foundation.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:cv_pro/core/services/pdf_service.dart';
import 'package:cv_pro/features/cv_form/data/models/cv_data.dart';
import 'package:cv_pro/features/pdf_export/layout/pdf_layout_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final showReferencesNoteProvider = StateProvider<bool>((ref) => true);

typedef PdfGenerationData = ({
  CVData data,
  bool showReferencesNote,
  ByteData fontData,
  ByteData boldFontData,
  ByteData iconFontData,
});
Future<Uint8List> _generatePdfInBackground(PdfGenerationData params) async {
  final doc = pw.Document();

  final font = pw.Font.ttf(params.fontData);
  final boldFont = pw.Font.ttf(params.boldFontData);
  final iconFont = pw.Font.ttf(params.iconFontData);

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
      {required bool showReferencesNote}) {
    throw UnimplementedError(
        'generateCv should be called via the provider which handles asset loading.');
  }

  static Future<Uint8List> generateCvWithFonts({
    required CVData data,
    required bool showReferencesNote,
    required ByteData fontData,
    required ByteData boldFontData,
    required ByteData iconFontData,
  }) async {
    final params = (
      data: data,
      showReferencesNote: showReferencesNote,
      fontData: fontData,
      boldFontData: boldFontData,
      iconFontData: iconFontData,
    );
    // Use Flutter's `compute` to run the heavy PDF generation on a separate isolate.
    return await compute(_generatePdfInBackground, params);
  }
}
