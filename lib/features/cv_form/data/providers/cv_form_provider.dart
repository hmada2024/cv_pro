import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cv_pro/core/di/injector.dart';
import 'package:cv_pro/core/services/storage_service.dart';
import 'package:cv_pro/features/cv_form/data/models/cv_data.dart';

class CvFormNotifier extends StateNotifier<CVData> {
  final StorageService _storageService;

  // نقوم الآن بتمرير خدمة التخزين إلى الـ Notifier
  CvFormNotifier(this._storageService) : super(CVData.initial()) {
    // عند إنشاء الـ Notifier لأول مرة، حاول تحميل البيانات من قاعدة البيانات
    _loadDataFromDb();
  }

  Future<void> _loadDataFromDb() async {
    final loadedData = await _storageService.loadCV();
    if (loadedData != null) {
      // إذا تم العثور على بيانات، قم بتحديث الحالة
      state = loadedData;
    }
  }

  // دالة مساعدة لحفظ الحالة تلقائيًا بعد كل تغيير
  Future<void> _saveStateToDb() async {
    await _storageService.saveCV(state);
  }

  void updatePersonalInfo({String? name, String? jobTitle, String? email}) {
    state = state.copyWith(
      personalInfo: state.personalInfo.copyWith(
        name: name,
        jobTitle: jobTitle,
        email: email,
      ),
    );
    _saveStateToDb(); // حفظ بعد التحديث
  }

  void addExperience(Experience exp) {
    state = state.copyWith(experiences: [...state.experiences, exp]);
    _saveStateToDb(); // حفظ بعد الإضافة
  }

  void addSkill(Skill skill) {
    state = state.copyWith(skills: [...state.skills, skill]);
    _saveStateToDb(); // حفظ بعد الإضافة
  }

  void addLanguage(Language lang) {
    state = state.copyWith(languages: [...state.languages, lang]);
    _saveStateToDb(); // حفظ بعد الإضافة
  }
}

// تعديل الـ Provider ليقرأ خدمة التخزين ويزود بها الـ Notifier
final cvFormProvider = StateNotifierProvider<CvFormNotifier, CVData>((ref) {
  final storageService = ref.watch(storageServiceProvider);
  return CvFormNotifier(storageService);
});
