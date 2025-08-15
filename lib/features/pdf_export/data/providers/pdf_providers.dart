// features/pdf_export/data/providers/pdf_providers.dart
import 'package:flutter/services.dart';
import 'package:cv_pro/features/cv_form/data/providers/cv_form_provider.dart';
import 'package:cv_pro/features/pdf_export/data/services/pdf_service_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cv_pro/features/pdf_export/data/dummy_data/cv_data_dummy.dart';

final pdfBytesProvider = FutureProvider.autoDispose<Uint8List>((ref) async {
  // 1. Load all required font assets on the main thread.
  final fontData = await rootBundle.load('assets/fonts/Lato-Regular.ttf');
  final boldFontData = await rootBundle.load('assets/fonts/Lato-Bold.ttf');
  final iconFontData =
      await rootBundle.load('assets/fonts/MaterialIcons-Regular.ttf');

  // 2. Get the user's CV data.
  final cvData = ref.watch(cvFormProvider);
  final showNote = ref.watch(showReferencesNoteProvider);

  // 3. Call the static method that bundles everything and runs the isolate.
  return PdfServiceImpl.generateCvWithFonts(
    data: cvData,
    showReferencesNote: showNote,
    fontData: fontData,
    boldFontData: boldFontData,
    iconFontData: iconFontData,
  );
});

/// This provider for dummy data follows the same robust, offline-first pattern.
final dummyPdfBytesProvider =
    FutureProvider.autoDispose<Uint8List>((ref) async {
  // 1. Load all required font assets on the main thread.
  final fontData = await rootBundle.load('assets/fonts/Lato-Regular.ttf');
  final boldFontData = await rootBundle.load('assets/fonts/Lato-Bold.ttf');
  final iconFontData =
      await rootBundle.load('assets/fonts/MaterialIcons-Regular.ttf');

  // 2. Get the dummy CV data.
  final dummyData = createDummyCvData();

  // 3. Call the static method that bundles everything and runs the isolate.
  return PdfServiceImpl.generateCvWithFonts(
    data: dummyData,
    showReferencesNote: false,
    fontData: fontData,
    boldFontData: boldFontData,
    iconFontData: iconFontData,
  );
});
