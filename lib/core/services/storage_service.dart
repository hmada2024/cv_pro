import 'package:cv_pro/features/cv_form/data/models/cv_data.dart';

abstract class StorageService {
  /// يحفظ بيانات السيرة الذاتية الحالية في قاعدة البيانات.
  Future<void> saveCV(CVData cvData);

  /// يقوم بتحميل بيانات السيرة الذاتية من قاعدة البيانات.
  /// إذا لم يتم العثور على أي بيانات، فإنه يعيد null.
  Future<CVData?> loadCV();
}
