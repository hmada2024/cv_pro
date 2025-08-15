// core/di/injector.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:cv_pro/core/services/pdf_service.dart';
import 'package:cv_pro/core/services/storage_service.dart';
import 'package:cv_pro/features/cv_form/data/services/storage_service_impl.dart';
import 'package:cv_pro/features/data/services/pdf_service_impl.dart';
import 'package:cv_pro/core/services/image_cropper_service.dart';

final pdfServiceProvider = Provider<PdfService>((ref) {
  return PdfServiceImpl();
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
