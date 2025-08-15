// features/pdf_export/data/providers/pdf_providers.dart
import 'dart:typed_data';
import 'package:cv_pro/core/di/injector.dart'; // ✅ CORRECT: Imports from the single source of truth.
import 'package:cv_pro/features/cv_form/data/providers/cv_form_provider.dart';
import 'package:cv_pro/features/pdf_export/data/services/pdf_service_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cv_pro/features/pdf_export/data/dummy_data/cv_data_dummy.dart';

/// Provider to generate the PDF for the user's actual CV data.
final pdfBytesProvider = FutureProvider.autoDispose<Uint8List>((ref) async {
  // This now correctly and unambiguously refers to the provider in 'injector.dart'.
  final pdfService = await ref.watch(pdfServiceProvider.future);
  final cvData = ref.watch(cvFormProvider);
  final showNote = ref.watch(showReferencesNoteProvider);
  return pdfService.generateCv(cvData, showReferencesNote: showNote);
});

/// Provider to generate a PDF using dummy data for template preview purposes.
final dummyPdfBytesProvider =
    FutureProvider.autoDispose<Uint8List>((ref) async {
  // This also correctly refers to the provider in 'injector.dart'.
  final pdfService = await ref.watch(pdfServiceProvider.future);
  final dummyData = createDummyCvData();
  return pdfService.generateCv(dummyData, showReferencesNote: false);
});
