// lib/features/3_cv_presentation/pdf_generation/data/dummy_data/cv_data_dummy.dart
import 'package:cv_pro/features/2_cv_editor/form/data/models/cv_data.dart';

part '_dummy_personal_info.dart';
part '_dummy_experience.dart';
part '_dummy_education.dart';
part '_dummy_skills.dart';
part '_dummy_languages.dart';
part '_dummy_references.dart';
part '_dummy_courses.dart';

CVData createDummyCvData() {
  return CVData(
    personalInfo: _createDummyPersonalInfo(),
    experiences: _createDummyExperiences(),
    education: _createDummyEducation(),
    skills: _createDummySkills(),
    languages: _createDummyLanguages(),
    references: _createDummyReferences(),
    courses: _createDummyCourses(),
  );
}
