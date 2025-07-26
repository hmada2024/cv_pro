import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cv_pro/core/di/injector.dart';
import 'package:cv_pro/core/services/image_cropper_service.dart';
import 'package:cv_pro/core/services/pdf_service.dart';
import 'package:cv_pro/core/services/storage_service.dart';
import 'package:cv_pro/features/cv_form/data/models/cv_data.dart';
import 'package:cv_pro/features/pdf_export/data/services/pdf_service_impl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:printing/printing.dart';

class CvFormNotifier extends StateNotifier<CVData> {
  final StorageService _storageService;
  final PdfService _pdfService;
  final ImageCropperService _imageCropperService;
  final ImagePicker _imagePicker = ImagePicker();

  CvFormNotifier(
      this._storageService, this._pdfService, this._imageCropperService)
      : super(CVData.initial()) {
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
    String? profileImagePath,
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
      ),
    );
    _saveStateToDb();
  }

  void addExperience({
    required String position,
    required String companyName,
    required String description,
  }) {
    if (companyName.isNotEmpty && position.isNotEmpty) {
      final newExperience = Experience.create(
          companyName: companyName,
          position: position,
          description: description,
          startDate: DateTime.now().subtract(const Duration(days: 365)),
          endDate: DateTime.now());
      state =
          state.copyWith(experiences: [...state.experiences, newExperience]);
      _saveStateToDb();
    }
  }

  void removeExperience(int index) {
    final currentExperiences = List<Experience>.from(state.experiences);
    currentExperiences.removeAt(index);
    state = state.copyWith(experiences: currentExperiences);
    _saveStateToDb();
  }

  void addEducation({required String school, required String degree}) {
    if (school.isNotEmpty && degree.isNotEmpty) {
      final newEducation = Education.create(
        school: school,
        degree: degree,
        startDate: DateTime.now().subtract(const Duration(days: 365 * 4)),
        endDate: DateTime.now().subtract(const Duration(days: 365)),
      );
      state = state.copyWith(education: [...state.education, newEducation]);
      _saveStateToDb();
    }
  }

  void removeEducation(int index) {
    final currentEducation = List<Education>.from(state.education);
    currentEducation.removeAt(index);
    state = state.copyWith(education: currentEducation);
    _saveStateToDb();
  }

  void addSkill({required String name, required int level}) {
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

  void removeLanguage(int index) {
    final currentLanguages = List<Language>.from(state.languages);
    currentLanguages.removeAt(index);
    state = state.copyWith(languages: currentLanguages);
    _saveStateToDb();
  }

  // ✅ تم التصحيح: الدالة لم تعد تستقبل السياق، بل الألوان مباشرة.
  Future<void> pickProfileImage({
    required Color toolbarColor,
    required Color toolbarWidgetColor,
    required Color backgroundColor,
    required Color activeControlsWidgetColor,
  }) async {
    final pickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      // بعد اختيار الصورة، يتم استدعاء خدمة القص مع تمرير الألوان
      final croppedFile = await _imageCropperService.cropImage(
        sourcePath: pickedFile.path,
        toolbarColor: toolbarColor,
        toolbarWidgetColor: toolbarWidgetColor,
        backgroundColor: backgroundColor,
        activeControlsWidgetColor: activeControlsWidgetColor,
      );

      if (croppedFile != null) {
        updatePersonalInfo(profileImagePath: croppedFile.path);
      }
    }
  }

  Future<void> generateAndPreviewPdf(CvTemplate template) async {
    final pdfBytes = await _pdfService.generateCv(state, template);
    await Printing.layoutPdf(onLayout: (format) => pdfBytes);
  }
}

final cvFormProvider = StateNotifierProvider<CvFormNotifier, CVData>((ref) {
  final storageService = ref.watch(storageServiceProvider);
  final pdfService = ref.watch(pdfServiceProvider);
  final imageCropperService = ref.watch(imageCropperServiceProvider);
  return CvFormNotifier(storageService, pdfService, imageCropperService);
});
