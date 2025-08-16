// lib/features/cv_form/data/providers/cv_form_provider.dart
import 'dart:async';
import 'package:cv_pro/core/di/injector.dart';
import 'package:cv_pro/core/services/image_cropper_service.dart';
import 'package:cv_pro/core/services/storage_service.dart';
import 'package:cv_pro/features/cv_form/data/models/cv_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class CvFormNotifier extends StateNotifier<CVData?> {
  final StorageService _storageService;
  final ImageCropperService _imageCropperService;
  final ImagePicker _imagePicker = ImagePicker();
  Timer? _debounce;

  CvFormNotifier(this._storageService, this._imageCropperService)
      : super(null) {
    _loadInitialData();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  Future<void> _loadInitialData() async {
    // On app start, load the very first CV if it exists.
    final firstCv = await _storageService.getFirstCV();
    if (firstCv != null) {
      state = firstCv;
    }
  }

  void _saveStateWithDebounce() {
    if (state == null) return;
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 700), () {
      final updatedCv = state!.copyWith(lastModified: DateTime.now());
      _storageService.saveCV(updatedCv);
    });
  }

  Future<void> _saveStateImmediately() async {
    if (state == null) return;
    _debounce?.cancel();
    final updatedCv = state!.copyWith(lastModified: DateTime.now());
    await _storageService.saveCV(updatedCv);
  }

  void loadCvProject(CVData cv) {
    state = cv;
  }

  void createNewCvProject(String projectName) {
    state = CVData.initial(projectName);
    _saveStateImmediately();
  }

  void clearActiveCV() {
    state = null;
  }

  void updatePersonalInfo({
    String? name,
    String? jobTitle,
    String? email,
    String? summary,
    String? phone,
    String? address,
    DateTime? birthDate,
    String? maritalStatus,
    String? militaryServiceStatus,
  }) {
    if (state == null) return;
    state = state!.copyWith(
      personalInfo: state!.personalInfo.copyWith(
        name: name,
        jobTitle: jobTitle,
        email: email,
        summary: summary,
        phone: phone,
        address: address,
        birthDate: birthDate,
        maritalStatus: maritalStatus,
        militaryServiceStatus: militaryServiceStatus,
      ),
    );
    _saveStateWithDebounce();
  }

  void updatePersonalInfoImagePath(String? path) {
    if (state == null) return;
    state = state!.copyWith(
      personalInfo: state!.personalInfo.copyWith(profileImagePath: path),
    );
    _saveStateImmediately();
  }

  void removeProfileImage() {
    updatePersonalInfoImagePath(null);
  }

  void updateLicenseInfo({bool? hasLicense, LicenseType? type}) {
    if (state == null) return;
    bool currentHasLicense = hasLicense ?? state!.personalInfo.hasDriverLicense;
    LicenseType newType;

    if (currentHasLicense) {
      newType = type ?? state!.personalInfo.licenseType;
      if (newType == LicenseType.none) {
        newType = LicenseType.local;
      }
    } else {
      newType = LicenseType.none;
    }

    state = state!.copyWith(
      personalInfo: state!.personalInfo.copyWith(
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
        updatePersonalInfoImagePath(croppedFile.path);
      }
    }
  }

  // --- Experience ---
  void addExperience(Experience newExperience) {
    if (state == null) return;
    state =
        state!.copyWith(experiences: [...state!.experiences, newExperience]);
    _saveStateImmediately();
  }

  void updateExperience(int index, Experience updatedExperience) {
    if (state == null) return;
    final currentExperiences = List<Experience>.from(state!.experiences);
    if (index >= 0 && index < currentExperiences.length) {
      currentExperiences[index] = updatedExperience;
      state = state!.copyWith(experiences: currentExperiences);
      _saveStateImmediately();
    }
  }

  void removeExperience(int index) {
    if (state == null) return;
    final currentExperiences = List<Experience>.from(state!.experiences);
    currentExperiences.removeAt(index);
    state = state!.copyWith(experiences: currentExperiences);
    _saveStateImmediately();
  }

  void reorderExperience(int oldIndex, int newIndex) {
    if (state == null) return;
    if (oldIndex < newIndex) newIndex -= 1;
    final items = List<Experience>.from(state!.experiences);
    final item = items.removeAt(oldIndex);
    items.insert(newIndex, item);
    state = state!.copyWith(experiences: items);
    _saveStateImmediately();
  }

  // --- Education ---
  void addEducation(Education newEducation) {
    if (state == null) return;
    state = state!.copyWith(education: [...state!.education, newEducation]);
    _saveStateImmediately();
  }

  void updateEducation(int index, Education updatedEducation) {
    if (state == null) return;
    final currentEducation = List<Education>.from(state!.education);
    if (index >= 0 && index < currentEducation.length) {
      currentEducation[index] = updatedEducation;
      state = state!.copyWith(education: currentEducation);
      _saveStateImmediately();
    }
  }

  void removeEducation(int index) {
    if (state == null) return;
    final currentEducation = List<Education>.from(state!.education);
    currentEducation.removeAt(index);
    state = state!.copyWith(education: currentEducation);
    _saveStateImmediately();
  }

  void reorderEducation(int oldIndex, int newIndex) {
    if (state == null) return;
    if (oldIndex < newIndex) newIndex -= 1;
    final items = List<Education>.from(state!.education);
    final item = items.removeAt(oldIndex);
    items.insert(newIndex, item);
    state = state!.copyWith(education: items);
    _saveStateImmediately();
  }

  // --- Skills ---
  void addSkill(Skill skill) {
    if (state == null) return;
    state = state!.copyWith(skills: [...state!.skills, skill]);
    _saveStateImmediately();
  }

  void removeSkill(int index) {
    if (state == null) return;
    final currentSkills = List<Skill>.from(state!.skills);
    currentSkills.removeAt(index);
    state = state!.copyWith(skills: currentSkills);
    _saveStateImmediately();
  }

  // --- Languages ---
  void addLanguage(Language language) {
    if (state == null) return;
    state = state!.copyWith(languages: [...state!.languages, language]);
    _saveStateImmediately();
  }

  void removeLanguage(int index) {
    if (state == null) return;
    final currentLanguages = List<Language>.from(state!.languages);
    currentLanguages.removeAt(index);
    state = state!.copyWith(languages: currentLanguages);
    _saveStateImmediately();
  }

  // --- References ---
  void addReference(Reference reference) {
    if (state == null) return;
    state = state!.copyWith(references: [...state!.references, reference]);
    _saveStateImmediately();
  }

  void updateReference(int index, Reference updatedReference) {
    if (state == null) return;
    final currentReferences = List<Reference>.from(state!.references);
    if (index >= 0 && index < currentReferences.length) {
      currentReferences[index] = updatedReference;
      state = state!.copyWith(references: currentReferences);
      _saveStateImmediately();
    }
  }

  void removeReference(int index) {
    if (state == null) return;
    final currentReferences = List<Reference>.from(state!.references);
    currentReferences.removeAt(index);
    state = state!.copyWith(references: currentReferences);
    _saveStateImmediately();
  }
}

// Renamed from cvFormProvider to activeCvProvider for clarity
final activeCvProvider = StateNotifierProvider<CvFormNotifier, CVData?>((ref) {
  final storageService = ref.watch(storageServiceProvider);
  final imageCropperService = ref.watch(imageCropperServiceProvider);
  return CvFormNotifier(storageService, imageCropperService);
});
