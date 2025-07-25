import 'dart:typed_data';
import 'package:cv_pro/features/cv_form/data/models/cv_data.dart';

// العقد الآن لا يحتوي على أي ذكر للغة
abstract class PdfService {
  Future<Uint8List> generateCv(CVData data);
}
