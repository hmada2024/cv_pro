import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cv_pro/features/cv_form/data/models/cv_data.dart';

// مزود حالة بسيط لتحديد اللغة المختارة
enum AppLanguage { arabic, english }

final languageProvider =
    StateProvider<AppLanguage>((ref) => AppLanguage.arabic);

// الـ Notifier المسؤول عن إدارة حالة نموذج السيرة الذاتية بالكامل
class CvFormNotifier extends StateNotifier<CVData> {
  // يبدأ بحالة أولية فارغة باستخدام الدالة المصنعية
  CvFormNotifier() : super(CVData.initial());

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
    state = state.copyWith(experiences: [...state.experiences, exp]);
  }

  void addSkill(Skill skill) {
    state = state.copyWith(skills: [...state.skills, skill]);
  }

  void addLanguage(Language lang) {
    state = state.copyWith(languages: [...state.languages, lang]);
  }
}

// الـ Provider الذي يوفر الـ Notifier وحالته للتطبيق
final cvFormProvider = StateNotifierProvider<CvFormNotifier, CVData>((ref) {
  return CvFormNotifier();
});
