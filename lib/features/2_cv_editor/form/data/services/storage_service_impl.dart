// lib/features/cv_form/data/services/storage_service_impl.dart
import 'package:isar/isar.dart';
import 'package:cv_pro/core/services/storage_service.dart';
import 'package:cv_pro/features/2_cv_editor/form/data/models/cv_data.dart';

class StorageServiceImpl implements StorageService {
  final Isar _isar;

  StorageServiceImpl(this._isar);

  @override
  Future<CVData?> loadCV(int id) async {
    return await _isar.cVDatas.get(id);
  }

  @override
  Future<int> saveCV(CVData cvData) async {
    return await _isar.writeTxn(() async {
      return await _isar.cVDatas.put(cvData);
    });
  }

  @override
  Future<List<CVData>> getAllCVs() async {
    return await _isar.cVDatas.where().sortByLastModifiedDesc().findAll();
  }

  @override
  Future<bool> deleteCV(int id) async {
    return await _isar.writeTxn(() async {
      return await _isar.cVDatas.delete(id);
    });
  }

  @override
  Future<CVData?> getFirstCV() async {
    return await _isar.cVDatas.where().findFirst();
  }
}
