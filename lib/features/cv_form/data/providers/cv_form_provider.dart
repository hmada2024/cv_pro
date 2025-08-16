// lib/features/cv_form/data/providers/cv_form_provider.dart
import 'dart:async';
import 'dart:io';
import 'package:cv_pro/core/di/injector.dart';
import 'package:cv_pro/core/services/image_cropper_service.dart';
import 'package:cv_pro/core/services/storage_service.dart';
import 'package:cv_pro/features/cv_form/data/models/cv_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

// Enum لتتبع حالة الحفظ في الواجهة
enum SaveStatus { idle, saving, saved }

// Provider جديد لتتبع حالة الحفظ
final saveStatusProvider = StateProvider<SaveStatus>((ref) => SaveStatus.idle);

class CvFormNotifier extends StateNotifier<CVData?> {
  final StorageService _storageService;
  final ImageCropperService _imageCropperService;
  final Ref _ref;
  final ImagePicker _imagePicker = ImagePicker();
  Timer? _debounce;

  CvFormNotifier(this._storageService, this._imageCropperService, this._ref)
      : super(null) {
    _loadInitialData();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  Future<void> _loadInitialData() async {
    final firstCv = await _storageService.getFirstCV();
    if (firstCv != null) {
      state = firstCv;
    }
  }

  void _saveStateWithDebounce() {
    if (state == null) return;
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _ref.read(saveStatusProvider.notifier).state = SaveStatus.saving;
    _debounce = Timer(const Duration(milliseconds: 700), () {
      final updatedCv = state!.copyWith(lastModified: DateTime.now());
      _storageService.saveCV(updatedCv).then((_) {
        if (mounted) {
          _ref.read(saveStatusProvider.notifier).state = SaveStatus.saved;
          Timer(const Duration(seconds: 2), () {
            if (mounted && _ref.read(saveStatusProvider) == SaveStatus.saved) {
              _ref.read(saveStatusProvider.notifier).state = SaveStatus.idle;
            }
          });
        }
      });
    });
  }

  Future<void> _saveStateImmediately() async {
    if (state == null) return;
    _debounce?.cancel();
    _ref.read(saveStatusProvider.notifier).state = SaveStatus.saving;
    final updatedCv = state!.copyWith(lastModified: DateTime.now());
    await _storageService.saveCV(updatedCv);
    if (mounted) {
      _ref.read(saveStatusProvider.notifier).state = SaveStatus.saved;
      Timer(const Duration(seconds: 2), () {
        if (mounted && _ref.read(saveStatusProvider) == SaveStatus.saved) {
          _ref.read(saveStatusProvider.notifier).state = SaveStatus.idle;
        }
      });
    }
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
    // Before removing, delete the old file to save space
    final oldPath = state?.personalInfo.profileImagePath;
    if (oldPath != null) {
      final oldFile = File(oldPath);
      if (oldFile.existsSync()) {
        oldFile.delete();
      }
    }
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
        final dir = await getTemporaryDirectory();
        final targetPath =
            p.join(dir.path, "${DateTime.now().millisecondsSinceEpoch}.jpg");

        final XFile? compressedFile =
            await FlutterImageCompress.compressAndGetFile(
          croppedFile.path,
          targetPath,
          quality: 80,
          minWidth: 512,
          minHeight: 512,
        );

        if (compressedFile != null) {
          updatePersonalInfoImagePath(compressedFile.path);
        }
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

final activeCvProvider = StateNotifierProvider<CvFormNotifier, CVData?>((ref) {
  final storageService = ref.watch(storageServiceProvider);
  final imageCropperService = ref.watch(imageCropperServiceProvider);
  return CvFormNotifier(storageService, imageCropperService, ref);
});
