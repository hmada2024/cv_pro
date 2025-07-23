import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cv_pro/features/cv_creation/models/cv_data.dart';

// 1. تعريف Notifier لإدارة حالة CVData
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

// 2. إنشاء الـ Provider الذي سيمكننا من الوصول للحالة من أي مكان
final cvDataProvider = StateNotifierProvider<CvDataNotifier, CVData>((ref) {
  return CvDataNotifier();
});
