import 'dart:typed_data';
import 'package:cv_pro/features/cv_form/data/models/cv_data.dart';
import 'package:cv_pro/features/pdf_export/data/services/pdf_service_impl.dart';

abstract class PdfService {
  /// generateCv now accepts the template and the new boolean option as arguments.
  Future<Uint8List> generateCv(CVData data, CvTemplate template,
      {required bool showReferencesNote});
}
