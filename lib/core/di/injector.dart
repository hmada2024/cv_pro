// core/di/injector.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:cv_pro/core/services/pdf_service.dart';
import 'package:cv_pro/core/services/storage_service.dart';
import 'package:cv_pro/features/cv_form/data/services/storage_service_impl.dart';
import 'package:cv_pro/features/pdf_export/data/services/pdf_service_impl.dart';
import 'package:cv_pro/core/services/image_cropper_service.dart';

/// ✅ UPDATED: The pdfServiceProvider is now defined ONLY here.
/// It creates the service instance and asynchronously initializes the fonts ONCE.
/// This prevents re-downloading fonts on every PDF generation, making it much faster.
final pdfServiceProvider = FutureProvider<PdfService>((ref) async {
  final service = PdfServiceImpl();
  await service.init(); // Initialize fonts
  return service;
});

final isarProvider = Provider<Isar>((ref) {
  throw UnimplementedError('Isar instance has not been initialized');
});

final storageServiceProvider = Provider<StorageService>((ref) {
  final isar = ref.watch(isarProvider);
  return StorageServiceImpl(isar);
});

final imageCropperServiceProvider = Provider<ImageCropperService>((ref) {
  return ImageCropperService();
});
