import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cv_pro/core/services/pdf_service.dart';
import 'package:cv_pro/features/pdf_export/data/services/pdf_service_impl.dart';

// هذا هو "حاقن التبعيات" (Dependency Injector) الخاص بنا.
// هذا الـ Provider يوفر "التنفيذ الفعلي" للخدمة لأي مكان في التطبيق يطلبه.
final pdfServiceProvider = Provider<PdfService>((ref) {
  // إذا طلب أي شخص PdfService، قم بإعطائه نسخة من PdfServiceImpl.
  return PdfServiceImpl();
});
