// features/pdf_export/data/services/pdf_service_impl.dart
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:cv_pro/core/services/pdf_service.dart';
import 'package:cv_pro/features/cv_form/data/models/cv_data.dart';
import 'package:cv_pro/features/pdf_export/layout/pdf_layout_builder.dart';

final showReferencesNoteProvider = StateProvider<bool>((ref) => true);

// ✅ REMOVED: The ambiguous 'pdfServiceProvider' has been removed from this file.
// The single source of truth is now in 'injector.dart'.

class PdfServiceImpl implements PdfService {
  pw.Font? _font;
  pw.Font? _boldFont;
  pw.Font? _iconFont;

  /// Initializes all required fonts once.
  Future<void> init() async {
    _font = await PdfGoogleFonts.latoRegular();
    _boldFont = await PdfGoogleFonts.latoBold();
    final iconFontData =
        await rootBundle.load('assets/fonts/MaterialIcons-Regular.ttf');
    _iconFont = pw.Font.ttf(iconFontData);
  }

  @override
  Future<Uint8List> generateCv(CVData data,
      {required bool showReferencesNote}) async {
    final doc = pw.Document();

    if (_font == null || _boldFont == null || _iconFont == null) {
      await init();
    }

    final layoutWidget = await buildPdfLayout(
      data: data,
      iconFont: _iconFont!,
      showReferencesNote: showReferencesNote,
    );

    doc.addPage(
      pw.Page(
        margin: pw.EdgeInsets.zero,
        theme: pw.ThemeData.withFont(
          base: _font!,
          bold: _boldFont!,
        ),
        build: (pw.Context context) {
          return layoutWidget;
        },
      ),
    );

    return doc.save();
  }
}
