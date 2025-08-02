// features/cv_form/data/providers/cv_form_provider.dart

import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cv_pro/core/di/injector.dart';
import 'package:cv_pro/core/services/image_cropper_service.dart';
import 'package:cv_pro/core/services/storage_service.dart';
import 'package:cv_pro/features/cv_form/data/models/cv_data.dart';
import 'package:cv_pro/features/pdf_export/data/models/dummy_cv_data.dart';
import 'package:cv_pro/features/pdf_export/data/services/pdf_service_impl.dart';
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

    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      _saveStateToDb();
    });
  }

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
      _saveStateToDb();
    }
  }

  void updateExperience(int index, Experience updatedExperience) {
    final currentExperiences = List<Experience>.from(state.experiences);
    if (index >= 0 && index < currentExperiences.length) {
      currentExperiences[index] = updatedExperience;
      state = state.copyWith(experiences: currentExperiences);
      _saveStateToDb();
    }
  }

  void removeExperience(int index) {
    final currentExperiences = List<Experience>.from(state.experiences);
    currentExperiences.removeAt(index);
    state = state.copyWith(experiences: currentExperiences);
    _saveStateToDb();
  }

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
      _saveStateToDb();
    }
  }

  void updateEducation(int index, Education updatedEducation) {
    final currentEducation = List<Education>.from(state.education);
    if (index >= 0 && index < currentEducation.length) {
      currentEducation[index] = updatedEducation;
      state = state.copyWith(education: currentEducation);
      _saveStateToDb();
    }
  }

  void removeEducation(int index) {
    final currentEducation = List<Education>.from(state.education);
    currentEducation.removeAt(index);
    state = state.copyWith(education: currentEducation);
    _saveStateToDb();
  }

  void addSkill({required String name, required String level}) {
    if (name.isNotEmpty) {
      state = state.copyWith(
          skills: [...state.skills, Skill.create(name: name, level: level)]);
      _saveStateToDb();
    }
  }

  void removeSkill(int index) {
    final currentSkills = List<Skill>.from(state.skills);
    currentSkills.removeAt(index);
    state = state.copyWith(skills: currentSkills);
    _saveStateToDb();
  }

  void addLanguage({required String name, required String proficiency}) {
    if (name.isNotEmpty && proficiency.isNotEmpty) {
      state = state.copyWith(languages: [
        ...state.languages,
        Language.create(name: name, proficiency: proficiency)
      ]);
      _saveStateToDb();
    }
  }

  void updateLanguage(int index, Language updatedLanguage) {
    final currentLanguages = List<Language>.from(state.languages);
    if (index >= 0 && index < currentLanguages.length) {
      currentLanguages[index] = updatedLanguage;
      state = state.copyWith(languages: currentLanguages);
      _saveStateToDb();
    }
  }

  void removeLanguage(int index) {
    final currentLanguages = List<Language>.from(state.languages);
    currentLanguages.removeAt(index);
    state = state.copyWith(languages: currentLanguages);
    _saveStateToDb();
  }

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
      _saveStateToDb();
    }
  }

  void updateReference(int index, Reference updatedReference) {
    final currentReferences = List<Reference>.from(state.references);
    if (index >= 0 && index < currentReferences.length) {
      currentReferences[index] = updatedReference;
      state = state.copyWith(references: currentReferences);
      _saveStateToDb();
    }
  }

  void removeReference(int index) {
    final currentReferences = List<Reference>.from(state.references);
    currentReferences.removeAt(index);
    state = state.copyWith(references: currentReferences);
    _saveStateToDb();
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
        _saveStateToDb();
      }
    }
  }
}

final cvFormProvider = StateNotifierProvider<CvFormNotifier, CVData>((ref) {
  final storageService = ref.watch(storageServiceProvider);
  final imageCropperService = ref.watch(imageCropperServiceProvider);
  return CvFormNotifier(storageService, imageCropperService);
});

final sortedExperiencesProvider = Provider<List<Experience>>((ref) {
  final experiences = ref.watch(cvFormProvider).experiences;
  final sortedList = List<Experience>.from(experiences);

  sortedList.sort((a, b) {
    // Current jobs come first
    if (a.isCurrent && !b.isCurrent) return -1;
    if (!a.isCurrent && b.isCurrent) return 1;

    // If both are current, or both are past, sort by end date (newest first)
    // For current jobs, endDate is null but they are already grouped at the top.
    // For past jobs, endDate is not null.
    if (!a.isCurrent && !b.isCurrent) {
      return b.endDate!.compareTo(a.endDate!);
    }

    // If both are current, sort by start date
    return b.startDate.compareTo(a.startDate);
  });

  return sortedList;
});

final sortedEducationProvider = Provider<List<Education>>((ref) {
  final educationList = ref.watch(cvFormProvider).education;
  final sortedList = List<Education>.from(educationList);

  // Sort by level (Doctor > Master > Bachelor), then by end date
  sortedList.sort((a, b) {
    final levelComparison = b.level.index.compareTo(a.level.index);
    if (levelComparison != 0) return levelComparison;

    // If levels are the same, sort by end date (newest first)
    if (a.isCurrent && !b.isCurrent) return -1;
    if (!a.isCurrent && b.isCurrent) return 1;

    if (!a.isCurrent && !b.isCurrent) {
      return b.endDate!.compareTo(a.endDate!);
    }

    return b.startDate.compareTo(a.startDate);
  });

  return sortedList;
});

final pdfBytesProvider = FutureProvider.autoDispose
    .family<Uint8List, CvTemplate>((ref, template) async {
  final pdfService = ref.read(pdfServiceProvider);
  final cvData = ref.watch(cvFormProvider);
  final showNote = ref.watch(showReferencesNoteProvider);
  return pdfService.generateCv(cvData, template, showReferencesNote: showNote);
});

final dummyPdfBytesProvider = FutureProvider.autoDispose
    .family<Uint8List, CvTemplate>((ref, template) async {
  final pdfService = ref.read(pdfServiceProvider);
  final dummyData = createDummyCvData();
  final showNote = ref.watch(showReferencesNoteProvider);
  return pdfService.generateCv(dummyData, template,
      showReferencesNote: showNote);
});
