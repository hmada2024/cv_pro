import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:cv_pro/core/services/pdf_service.dart';
import 'package:cv_pro/core/services/storage_service.dart';
import 'package:cv_pro/data/services/storage_service_impl.dart';
import 'package:cv_pro/features/pdf_export/data/services/pdf_service_impl.dart';

// === الخدمات الحالية ===
final pdfServiceProvider = Provider<PdfService>((ref) {
  return PdfServiceImpl();
});

// === الخدمات الجديدة ===

// 1. Provider لنسخة Isar نفسها.
// سيتم توفير القيمة الفعلية في main.dart بعد التهيئة.
final isarProvider = Provider<Isar>((ref) {
  throw UnimplementedError('Isar instance has not been initialized');
});

// 2. Provider لخدمة التخزين.
// يعتمد هذا على isarProvider للحصول على نسخة Isar.
final storageServiceProvider = Provider<StorageService>((ref) {
  final isar = ref.watch(isarProvider);
  return StorageServiceImpl(isar);
});
