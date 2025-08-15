// features/pdf_export/data/services/pdf_service_impl.dart
import 'package:flutter/foundation.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:cv_pro/core/services/pdf_service.dart';
import 'package:cv_pro/features/cv_form/data/models/cv_data.dart';
import 'package:cv_pro/features/layout/pdf_layout_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final showReferencesNoteProvider = StateProvider<bool>((ref) => true);

typedef PdfGenerationData = ({
  CVData data,
  bool showReferencesNote,
  ByteData fontData,
  ByteData boldFontData,
  ByteData iconFontData,
  Uint8List? profileImageData,
});

Future<Uint8List> _generatePdfInBackground(PdfGenerationData params) async {
  final doc = pw.Document();

  // Create fonts from the provided raw byte data
  final font = pw.Font.ttf(params.fontData);
  final boldFont = pw.Font.ttf(params.boldFontData);
  final iconFont = pw.Font.ttf(params.iconFontData);

  // The layout builder is now a pure function that only uses the data passed to it.
  final layoutWidget = buildPdfLayout(
    data: params.data,
    iconFont: iconFont,
    showReferencesNote: params.showReferencesNote,
    profileImageData: params.profileImageData,
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

  /// ✅✅✅ UPDATED: The static method now accepts pre-loaded image data.
  static Future<Uint8List> generateCvWithAssets({
    required CVData data,
    required bool showReferencesNote,
    required ByteData fontData,
    required ByteData boldFontData,
    required ByteData iconFontData,
    required Uint8List? profileImageData,
  }) async {
    final params = (
      data: data,
      showReferencesNote: showReferencesNote,
      fontData: fontData,
      boldFontData: boldFontData,
      iconFontData: iconFontData,
      profileImageData: profileImageData,
    );
    return await compute(_generatePdfInBackground, params);
  }
}
