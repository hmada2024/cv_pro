// features/pdf_export/data/providers/pdf_providers.dart
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:cv_pro/features/cv_form/data/providers/cv_form_provider.dart';
import 'package:cv_pro/features/pdf_export/data/services/pdf_service_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cv_pro/features/pdf_export/data/dummy_data/cv_data_dummy.dart';

/// making it compatible with any provider that passes a ref object.
Future<Uint8List> _generatePdf(Ref ref, {bool isDummy = false}) async {
  // 1. Load all required font assets on the main thread.
  final fontData = await rootBundle.load('assets/fonts/Lato-Regular.ttf');
  final boldFontData = await rootBundle.load('assets/fonts/Lato-Bold.ttf');
  final iconFontData =
      await rootBundle.load('assets/fonts/MaterialIcons-Regular.ttf');

  // 2. Get the correct CV data.
  final cvData = isDummy ? createDummyCvData() : ref.watch(cvFormProvider);
  final showNote = isDummy ? false : ref.watch(showReferencesNoteProvider);

  // 3. Load the profile image data on the main thread.
  Uint8List? profileImageData;
  final imagePath = cvData.personalInfo.profileImagePath;

  if (imagePath != null && imagePath.isNotEmpty) {
    if (imagePath.startsWith('assets/')) {
      // Handle asset image (for dummy data)
      profileImageData =
          (await rootBundle.load(imagePath)).buffer.asUint8List();
    } else {
      // Handle file image (for user-picked image)
      final imageFile = File(imagePath);
      if (await imageFile.exists()) {
        profileImageData = await imageFile.readAsBytes();
      }
    }
  }

  // 4. Call the static method that bundles everything and runs the isolate.
  return PdfServiceImpl.generateCvWithAssets(
    data: cvData,
    showReferencesNote: showNote,
    fontData: fontData,
    boldFontData: boldFontData,
    iconFontData: iconFontData,
    profileImageData: profileImageData,
  );
}

/// Provider to generate the PDF for the user's actual CV data.
final pdfBytesProvider = FutureProvider.autoDispose<Uint8List>((ref) async {
  return _generatePdf(ref, isDummy: false);
});

/// Provider to generate a PDF using dummy data for template preview purposes.
final dummyPdfBytesProvider =
    FutureProvider.autoDispose<Uint8List>((ref) async {
  return _generatePdf(ref, isDummy: true);
});
