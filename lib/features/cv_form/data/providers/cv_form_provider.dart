// features/cv_form/data/providers/cv_form_provider.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cv_pro/core/di/injector.dart';
import 'package:cv_pro/core/services/image_cropper_service.dart';
import 'package:cv_pro/core/services/storage_service.dart';
import 'package:cv_pro/features/cv_form/data/models/cv_data.dart';
import 'package:image_picker/image_picker.dart';

class CvFormNotifier extends StateNotifier<CVData> {
  final StorageService _storageService;
  final ImageCropperService _imageCropperService;
  final ImagePicker _imagePicker = ImagePicker();
  Timer? _debounce;

  CvFormNotifier(this._storageService, this._imageCropperService)
      : super(CVData.initial()) {
    _loadDataFromDb();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  Future<void> _loadDataFromDb() async {
    final loadedData = await _storageService.loadCV();
    if (loadedData != null) {
      state = loadedData;
    }
  }

  // Saves the current state to the database, debounced to avoid frequent writes.
  void _saveStateWithDebounce() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      _storageService.saveCV(state);
    });
  }

  // Saves the state immediately, used for operations that need to be instant.
  Future<void> _saveStateImmediately() async {
    _debounce?.cancel();
    await _storageService.saveCV(state);
  }

  // --- Personal Info ---
  void updatePersonalInfo({
    String? name,
    String? jobTitle,
    String? email,
    String? summary,
    String? phone,
    String? address,
    String? profileImagePath,
    DateTime? birthDate,
    String? maritalStatus,
    String? militaryServiceStatus,
  }) {
    state = state.copyWith(
      personalInfo: state.personalInfo.copyWith(
        name: name,
        jobTitle: jobTitle,
        email: email,
        summary: summary,
        phone: phone,
        address: address,
        profileImagePath: profileImagePath,
        birthDate: birthDate,
        maritalStatus: maritalStatus,
        militaryServiceStatus: militaryServiceStatus,
      ),
    );
    _saveStateWithDebounce();
  }

  /// ✅ NEW: Updates the driving license information with smart logic.
  void updateLicenseInfo({bool? hasLicense, LicenseType? type}) {
    bool currentHasLicense = hasLicense ?? state.personalInfo.hasDriverLicense;
    LicenseType newType;

    if (currentHasLicense) {
      // If a type is provided, use it. Otherwise, keep the old one,
      // but ensure it's not 'none'. Default to 'local' if needed.
      newType = type ?? state.personalInfo.licenseType;
      if (newType == LicenseType.none) {
        newType = LicenseType.local;
      }
    } else {
      // If the user doesn't have a license, always reset the type to 'none'.
      newType = LicenseType.none;
    }

    state = state.copyWith(
      personalInfo: state.personalInfo.copyWith(
        hasDriverLicense: currentHasLicense,
        licenseType: newType,
      ),
    );
    _saveStateImmediately();
  }

  Future<void> pickProfileImage({
    required Color toolbarColor,
    required Color toolbarWidgetColor,
    required Color backgroundColor,
    required Color activeControlsWidgetColor,
  }) async {
    final pickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final croppedFile = await _imageCropperService.cropImage(
        sourcePath: pickedFile.path,
        toolbarColor: toolbarColor,
        toolbarWidgetColor: toolbarWidgetColor,
        backgroundColor: backgroundColor,
        activeControlsWidgetColor: activeControlsWidgetColor,
      );

      if (croppedFile != null) {
        state = state.copyWith(
            personalInfo: state.personalInfo
                .copyWith(profileImagePath: croppedFile.path));
        _saveStateImmediately();
      }
    }
  }

  // --- Experience ---
  void addExperience({
    required String position,
    required String companyName,
    required String description,
    required DateTime startDate,
    DateTime? endDate,
  }) {
    if (companyName.isNotEmpty && position.isNotEmpty) {
      final newExperience = Experience.create(
        companyName: companyName,
        position: position,
        description: description,
        startDate: startDate,
        endDate: endDate,
      );
      state =
          state.copyWith(experiences: [...state.experiences, newExperience]);
      _saveStateImmediately();
    }
  }

  void updateExperience(int index, Experience updatedExperience) {
    final currentExperiences = List<Experience>.from(state.experiences);
    if (index >= 0 && index < currentExperiences.length) {
      currentExperiences[index] = updatedExperience;
      state = state.copyWith(experiences: currentExperiences);
      _saveStateImmediately();
    }
  }

  void removeExperience(int index) {
    final currentExperiences = List<Experience>.from(state.experiences);
    currentExperiences.removeAt(index);
    state = state.copyWith(experiences: currentExperiences);
    _saveStateImmediately();
  }

  // --- Education ---
  void addEducation({
    required EducationLevel level,
    required String degreeName,
    required String school,
    required DateTime startDate,
    DateTime? endDate,
  }) {
    if (school.isNotEmpty && degreeName.isNotEmpty) {
      final newEducation = Education.create(
        level: level,
        degreeName: degreeName,
        school: school,
        startDate: startDate,
        endDate: endDate,
      );
      state = state.copyWith(education: [...state.education, newEducation]);
      _saveStateImmediately();
    }
  }

  void updateEducation(int index, Education updatedEducation) {
    final currentEducation = List<Education>.from(state.education);
    if (index >= 0 && index < currentEducation.length) {
      currentEducation[index] = updatedEducation;
      state = state.copyWith(education: currentEducation);
      _saveStateImmediately();
    }
  }

  void removeEducation(int index) {
    final currentEducation = List<Education>.from(state.education);
    currentEducation.removeAt(index);
    state = state.copyWith(education: currentEducation);
    _saveStateImmediately();
  }

  // --- Skills ---
  void addSkill({required String name, required String level}) {
    if (name.isNotEmpty) {
      state = state.copyWith(
          skills: [...state.skills, Skill.create(name: name, level: level)]);
      _saveStateImmediately();
    }
  }

  void removeSkill(int index) {
    final currentSkills = List<Skill>.from(state.skills);
    currentSkills.removeAt(index);
    state = state.copyWith(skills: currentSkills);
    _saveStateImmediately();
  }

  // --- Languages ---
  void addLanguage({required String name, required String proficiency}) {
    if (name.isNotEmpty && proficiency.isNotEmpty) {
      state = state.copyWith(languages: [
        ...state.languages,
        Language.create(name: name, proficiency: proficiency)
      ]);
      _saveStateImmediately();
    }
  }

  void updateLanguage(int index, Language updatedLanguage) {
    final currentLanguages = List<Language>.from(state.languages);
    if (index >= 0 && index < currentLanguages.length) {
      currentLanguages[index] = updatedLanguage;
      state = state.copyWith(languages: currentLanguages);
      _saveStateImmediately();
    }
  }

  void removeLanguage(int index) {
    final currentLanguages = List<Language>.from(state.languages);
    currentLanguages.removeAt(index);
    state = state.copyWith(languages: currentLanguages);
    _saveStateImmediately();
  }

  // --- References ---
  void addReference({
    required String name,
    required String company,
    required String position,
    required String email,
    String? phone,
  }) {
    if (name.isNotEmpty && email.isNotEmpty) {
      final newReference = Reference.create(
          name: name,
          company: company,
          position: position,
          email: email,
          phone: phone);
      state = state.copyWith(references: [...state.references, newReference]);
      _saveStateImmediately();
    }
  }

  void updateReference(int index, Reference updatedReference) {
    final currentReferences = List<Reference>.from(state.references);
    if (index >= 0 && index < currentReferences.length) {
      currentReferences[index] = updatedReference;
      state = state.copyWith(references: currentReferences);
      _saveStateImmediately();
    }
  }

  void removeReference(int index) {
    final currentReferences = List<Reference>.from(state.references);
    currentReferences.removeAt(index);
    state = state.copyWith(references: currentReferences);
    _saveStateImmediately();
  }
}

final cvFormProvider = StateNotifierProvider<CvFormNotifier, CVData>((ref) {
  final storageService = ref.watch(storageServiceProvider);
  final imageCropperService = ref.watch(imageCropperServiceProvider);
  return CvFormNotifier(storageService, imageCropperService);
});
