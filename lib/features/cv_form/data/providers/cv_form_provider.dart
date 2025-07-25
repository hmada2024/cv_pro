import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cv_pro/core/di/injector.dart';
import 'package:cv_pro/core/services/storage_service.dart';
import 'package:cv_pro/features/cv_form/data/models/cv_data.dart';

class CvFormNotifier extends StateNotifier<CVData> {
  final StorageService _storageService;

  CvFormNotifier(this._storageService) : super(CVData.initial()) {
    _loadDataFromDb();
  }

  Future<void> _loadDataFromDb() async {
    final loadedData = await _storageService.loadCV();
    if (loadedData != null) {
      state = loadedData;
    }
  }

  Future<void> _saveStateToDb() async {
    await _storageService.saveCV(state);
  }

  void updatePersonalInfo({
    String? name,
    String? jobTitle,
    String? email,
    String? summary,
    String? phone,
    String? address,
    File? profileImage,
  }) {
    state = state.copyWith(
      personalInfo: state.personalInfo.copyWith(
        name: name,
        jobTitle: jobTitle,
        email: email,
        summary: summary,
        phone: phone,
        address: address,
        profileImage: profileImage,
      ),
    );
    _saveStateToDb();
  }

  void addExperience(Experience exp) {
    state = state.copyWith(experiences: [...state.experiences, exp]);
    _saveStateToDb();
  }

  void addEducation(Education edu) {
    state = state.copyWith(education: [...state.education, edu]);
    _saveStateToDb();
  }

  void addSkill(Skill skill) {
    state = state.copyWith(skills: [...state.skills, skill]);
    _saveStateToDb();
  }

  void addLanguage(Language lang) {
    state = state.copyWith(languages: [...state.languages, lang]);
    _saveStateToDb();
  }
}

final cvFormProvider = StateNotifierProvider<CvFormNotifier, CVData>((ref) {
  final storageService = ref.watch(storageServiceProvider);
  return CvFormNotifier(storageService);
});
