// features/pdf_export/data/providers/pdf_providers.dart
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:cv_pro/features/cv_form/data/providers/cv_form_provider.dart';
import 'package:cv_pro/core/services/pdf_service_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cv_pro/features/dummy_view/data/cv_data_dummy.dart';

typedef PdfFontAssets = ({
  ByteData fontData,
  ByteData boldFontData,
  ByteData iconFontData,
});

final pdfAssetsProvider = FutureProvider<PdfFontAssets>((ref) async {
  final fontData = await rootBundle.load('assets/fonts/Lato-Regular.ttf');
  final boldFontData = await rootBundle.load('assets/fonts/Lato-Bold.ttf');
  final iconFontData =
      await rootBundle.load('assets/fonts/MaterialIcons-Regular.ttf');

  return (
    fontData: fontData,
    boldFontData: boldFontData,
    iconFontData: iconFontData,
  );
});

Future<Uint8List> _generatePdf(Ref ref, {bool isDummy = false}) async {
  final fontAssets = await ref.watch(pdfAssetsProvider.future);

  // 2. Get the correct CV data.
  final cvData = isDummy ? createDummyCvData() : ref.read(cvFormProvider);
  final showNote = isDummy ? false : ref.read(showReferencesNoteProvider);

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

  return PdfServiceImpl.generateCvWithAssets(
    data: cvData,
    showReferencesNote: showNote,
    fontData: fontAssets.fontData,
    boldFontData: fontAssets.boldFontData,
    iconFontData: fontAssets.iconFontData,
    profileImageData: profileImageData,
  );
}

/// Provider to generate the PDF for the user's actual CV data.
final pdfBytesProvider = FutureProvider.autoDispose<Uint8List>((ref) async {
  ref.watch(cvFormProvider);
  ref.watch(showReferencesNoteProvider);
  return _generatePdf(ref, isDummy: false);
});

/// Provider to generate a PDF using dummy data for template preview purposes.
final dummyPdfBytesProvider =
    FutureProvider.autoDispose<Uint8List>((ref) async {
  return _generatePdf(ref, isDummy: true);
});
