import 'package:isar/isar.dart';
import 'package:cv_pro/core/services/storage_service.dart';
import 'package:cv_pro/features/cv_form/data/models/cv_data.dart';

class StorageServiceImpl implements StorageService {
  final Isar _isar;

  StorageServiceImpl(this._isar);

  @override
  Future<CVData?> loadCV() async {
    // نظرًا لأننا ندير سيرة ذاتية واحدة فقط، سنبحث دائمًا عن أول سجل.
    return await _isar.cVDatas.where().findFirst();
  }

  @override
  Future<void> saveCV(CVData cvData) async {
    await _isar.writeTxn(() async {
      // put سيقوم بالإدراج إذا كان جديدًا، أو التحديث إذا كان موجودًا.
      await _isar.cVDatas.put(cvData);
    });
  }
}
