// features/pdf_export/data/providers/pdf_providers.dart

import 'dart:typed_data';

import 'package:cv_pro/core/di/injector.dart';
import 'package:cv_pro/features/cv_form/data/providers/cv_form_provider.dart';
import 'package:cv_pro/features/pdf_export/data/models/dummy_cv_data.dart';
import 'package:cv_pro/features/pdf_export/data/services/pdf_service_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provider to generate the PDF for the user's actual CV data.
/// It depends on the selected template.
final pdfBytesProvider = FutureProvider.autoDispose
    .family<Uint8List, CvTemplate>((ref, template) async {
  final pdfService = ref.read(pdfServiceProvider);
  final cvData = ref.watch(cvFormProvider);
  final showNote = ref.watch(showReferencesNoteProvider);
  return pdfService.generateCv(cvData, template, showReferencesNote: showNote);
});

/// Provider to generate a PDF using dummy data for template preview purposes.
/// It depends on the selected template.
final dummyPdfBytesProvider = FutureProvider.autoDispose
    .family<Uint8List, CvTemplate>((ref, template) async {
  final pdfService = ref.read(pdfServiceProvider);
  final dummyData = createDummyCvData();
  final showNote = ref.watch(showReferencesNoteProvider);
  return pdfService.generateCv(dummyData, template,
      showReferencesNote: showNote);
});
