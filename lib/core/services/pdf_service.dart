import 'dart:typed_data';
import 'package:cv_pro/features/cv_form/data/models/cv_data.dart';
import 'package:cv_pro/features/pdf_export/data/services/pdf_service_impl.dart'; // استيراد الـ enum

// تم نقل الـ enum هنا ليكون متاحًا في كل مكان يستخدم الخدمة
// enum CvTemplate { classic, modern } // سيتم تعريفه داخل pdf_service_impl.dart

abstract class PdfService {
  /// generateCv الآن تقبل القالب المطلوب كوسيط إضافي
  Future<Uint8List> generateCv(CVData data, CvTemplate template);
}
