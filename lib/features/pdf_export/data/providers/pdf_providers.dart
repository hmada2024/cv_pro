// features/pdf_export/data/providers/pdf_providers.dart
import 'dart:typed_data';
import 'package:cv_pro/core/di/injector.dart';
import 'package:cv_pro/features/cv_form/data/providers/cv_form_provider.dart';
import 'package:cv_pro/features/pdf_export/data/services/pdf_service_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cv_pro/features/pdf_export/data/dummy_data/cv_data_dummy.dart';

/// Provider to generate the PDF for the user's actual CV data.
final pdfBytesProvider = FutureProvider.autoDispose<Uint8List>((ref) async {
  final pdfService = ref.read(pdfServiceProvider);
  final cvData = ref.watch(cvFormProvider);
  final showNote = ref.watch(showReferencesNoteProvider);
  return pdfService.generateCv(cvData, showReferencesNote: showNote);
});

/// Provider to generate a PDF using dummy data for template preview purposes.
final dummyPdfBytesProvider =
    FutureProvider.autoDispose<Uint8List>((ref) async {
  final pdfService = ref.read(pdfServiceProvider);
  // This now calls the function from our new, clean, and structured dummy data file.
  final dummyData = createDummyCvData();
  return pdfService.generateCv(dummyData, showReferencesNote: false);
});
