import 'dart:typed_data';
import 'package:cv_pro/features/cv_form/data/models/cv_data.dart';
import 'package:cv_pro/features/cv_form/data/providers/cv_form_provider.dart';

abstract class PdfService {
  Future<Uint8List> generateCv(CVData data, AppLanguage language);
}
