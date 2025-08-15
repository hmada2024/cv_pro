// features/pdf_export/data/providers/pdf_providers.dart
import 'dart:typed_data';
import 'package:cv_pro/core/di/injector.dart';
import 'package:cv_pro/features/cv_form/data/providers/cv_form_provider.dart';
import 'package:cv_pro/features/pdf_export/data/models/dummy_cv_data.dart';
import 'package:cv_pro/features/pdf_export/data/services/pdf_service_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// ✅ UPDATED: تم تبسيط الـ provider ليصبح FutureProvider.autoDispose عادي.
/// لم يعد هناك حاجة ليكون من نوع .family بما أن هناك قالب واحد فقط.
final pdfBytesProvider = FutureProvider.autoDispose<Uint8List>((ref) async {
  final pdfService = ref.read(pdfServiceProvider);
  final cvData = ref.watch(cvFormProvider);
  final showNote = ref.watch(showReferencesNoteProvider);
  // ✅ UPDATED: استدعاء دالة generateCv لم يعد يمرر نوع القالب.
  return pdfService.generateCv(cvData, showReferencesNote: showNote);
});

/// ✅ UPDATED: الـ provider الخاص بالبيانات الوهمية تم تبسيطه أيضاً.
/// يستخدم لمعاينة القالب من شاشة الإعدادات.
final dummyPdfBytesProvider =
    FutureProvider.autoDispose<Uint8List>((ref) async {
  final pdfService = ref.read(pdfServiceProvider);
  final dummyData = createDummyCvData();
  // نستخدم قيمة ثابتة للمعاينة لإظهار شكل المراجع الكامل.
  return pdfService.generateCv(dummyData, showReferencesNote: false);
});
