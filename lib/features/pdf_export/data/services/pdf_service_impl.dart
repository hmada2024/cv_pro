// features/pdf_export/data/services/pdf_service_impl.dart

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cv_pro/core/services/pdf_service.dart';
import 'package:cv_pro/features/cv_form/data/models/cv_data.dart';

// ✅ NEW: Add the new template to the enum
enum CvTemplate { twoColumn01, twoColumn02, twoColumn03 }

final selectedTemplateProvider =
    StateProvider<CvTemplate>((ref) => CvTemplate.twoColumn03);

final showReferencesNoteProvider = StateProvider<bool>((ref) => true);

class PdfServiceImpl implements PdfService {
  @override
  Future<Uint8List> generateCv(CVData data, CvTemplate template,
      {required bool showReferencesNote}) async {
    switch (template) {
      case CvTemplate.twoColumn01:
        break;
      case CvTemplate.twoColumn02:
        break;
      case CvTemplate.twoColumn03:
        break;
    }
    throw UnimplementedError(
        'generateCv not implemented for template: $template');
  }
}
