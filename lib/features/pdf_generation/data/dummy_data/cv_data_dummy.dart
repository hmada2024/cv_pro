// features/pdf_export/data/dummy_data/cv_data_dummy.dart
import 'package:cv_pro/features/form/data/models/cv_data.dart';

part '_dummy_personal_info.dart';
part '_dummy_experience.dart';
part '_dummy_education.dart';
part '_dummy_skills.dart';
part '_dummy_languages.dart';
part '_dummy_references.dart';

/// This is the main function that assembles the complete dummy CVData object
/// by calling helper functions from the 'part' files.
/// This is the only function that should be used outside this folder.
CVData createDummyCvData() {
  return CVData(
    personalInfo: _createDummyPersonalInfo(),
    experiences: _createDummyExperiences(),
    education: _createDummyEducation(),
    skills: _createDummySkills(),
    languages: _createDummyLanguages(),
    references: _createDummyReferences(),
  );
}
