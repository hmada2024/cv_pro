// core/services/pdf_service.dart
import 'dart:typed_data';
import 'package:cv_pro/features/2_cv_editor/form/data/models/cv_data.dart';

abstract class PdfService {
  /// generateCv الآن يأخذ فقط البيانات وخيار إظهار ملاحظة المراجع.
  Future<Uint8List> generateCv(CVData data, {required bool showReferencesNote});
}
