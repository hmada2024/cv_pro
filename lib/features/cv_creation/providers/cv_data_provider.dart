import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cv_pro/features/cv_creation/models/cv_data.dart';

// Enum لتعريف اللغات المتاحة
enum AppLanguage { arabic, english }

// Provider لتخزين اللغة المختارة حالياً
// القيمة الافتراضية هي العربية
final languageProvider =
    StateProvider<AppLanguage>((ref) => AppLanguage.arabic);

// ==========================================================

// الكود الأصلي يبقى كما هو
class CvDataNotifier extends StateNotifier<CVData> {
  CvDataNotifier()
      : super(CVData(
          personalInfo: PersonalInfo(),
          experiences: [], // نبدأ بقائمة خبرات فارغة
        ));

  void updatePersonalInfo({String? name, String? jobTitle, String? email}) {
    state = state.copyWith(
      personalInfo: state.personalInfo.copyWith(
        name: name,
        jobTitle: jobTitle,
        email: email,
      ),
    );
  }

  void addExperience(Experience exp) {
    state = state.copyWith(
      experiences: [...state.experiences, exp],
    );
  }
}

// إنشاء الـ Provider الذي سيمكننا من الوصول للحالة من أي مكان
final cvDataProvider = StateNotifierProvider<CvDataNotifier, CVData>((ref) {
  return CvDataNotifier();
});
