// lib/features/history/data/models/cv_history.dart
import 'package:cv_pro/features/cv_form/data/models/cv_data.dart';
import 'package:isar/isar.dart';

part 'cv_history.g.dart';

@collection
class CVHistory {
  Id id = Isar.autoIncrement;

  late String displayName;
  late DateTime createdAt;

  final PersonalInfo personalInfo;
  final List<Experience> experiences;
  final List<Skill> skills;
  final List<Language> languages;
  final List<Education> education;
  final List<Reference> references;

  CVHistory({
    required this.displayName,
    required this.createdAt,
    required this.personalInfo,
    required this.experiences,
    required this.skills,
    required this.languages,
    required this.education,
    required this.references,
  });

  factory CVHistory.fromCVData(CVData cvData, String displayName) {
    return CVHistory(
      displayName: displayName,
      createdAt: DateTime.now(),
      personalInfo: cvData.personalInfo,
      experiences: cvData.experiences,
      skills: cvData.skills,
      languages: cvData.languages,
      education: cvData.education,
      references: cvData.references,
    );
  }
}
