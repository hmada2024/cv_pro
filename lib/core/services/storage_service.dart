// lib/core/services/storage_service.dart
import 'package:cv_pro/features/2_cv_editor/form/data/models/cv_data.dart';

abstract class StorageService {
  Future<int> saveCV(CVData cvData);
  Future<CVData?> loadCV(int id);
  Future<List<CVData>> getAllCVs();
  Future<bool> deleteCV(int id);
  Future<CVData?> getFirstCV();
}
