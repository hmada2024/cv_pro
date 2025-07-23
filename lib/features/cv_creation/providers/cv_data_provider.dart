import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cv_pro/features/cv_creation/models/cv_data.dart';

enum AppLanguage { arabic, english }

final languageProvider =
    StateProvider<AppLanguage>((ref) => AppLanguage.arabic);

class CvDataNotifier extends StateNotifier<CVData> {
  CvDataNotifier()
      : super(CVData(
          personalInfo: PersonalInfo(),
          experiences: [],
          skills: [],
          languages: [],
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
    state = state.copyWith(experiences: [...state.experiences, exp]);
  }

  void addSkill(Skill skill) {
    state = state.copyWith(skills: [...state.skills, skill]);
  }

  void addLanguage(Language lang) {
    state = state.copyWith(languages: [...state.languages, lang]);
  }
}

final cvDataProvider = StateNotifierProvider<CvDataNotifier, CVData>((ref) {
  return CvDataNotifier();
});
