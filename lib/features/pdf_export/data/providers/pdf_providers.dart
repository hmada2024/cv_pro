// features/pdf_export/data/providers/pdf_providers.dart
import 'dart:typed_data';
import 'package:cv_pro/core/di/injector.dart'; // ✅ CORRECT: Imports from the single source of truth.
import 'package:cv_pro/features/cv_form/data/providers/cv_form_provider.dart';
import 'package:cv_pro/features/pdf_export/data/services/pdf_service_impl.dart';
import 'package:cv_pro/features/pdf_export/data/dummy_data/cv_data_dummy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provider to generate the PDF for the user's actual CV data.
final pdfBytesProvider = FutureProvider.autoDispose<Uint8List>((ref) async {
  // ✅✅✅ FIXED: The service is now retrieved synchronously without '.future' or 'await'.
  final pdfService = ref.watch(pdfServiceProvider);
  final cvData = ref.watch(cvFormProvider);
  final showNote = ref.watch(showReferencesNoteProvider);
  return pdfService.generateCv(cvData, showReferencesNote: showNote);
});

/// Provider to generate a PDF using dummy data for template preview purposes.
final dummyPdfBytesProvider =
    FutureProvider.autoDispose<Uint8List>((ref) async {
  final pdfService = ref.watch(pdfServiceProvider);
  final dummyData = createDummyCvData();
  return pdfService.generateCv(dummyData, showReferencesNote: false);
});
