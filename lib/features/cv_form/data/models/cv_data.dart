// features/cv_form/data/models/cv_data.dart
import 'package:cv_pro/features/history/data/models/cv_history.dart';
import 'package:isar/isar.dart';
import 'package:cv_pro/features/cv_form/data/models/cv_constants.dart';

part 'personal_info.dart';
part 'experience.dart';
part 'skill.dart';
part 'language.dart';
part 'education.dart';
part 'reference.dart';
part 'cv_data.g.dart';

@collection
class CVData {
  Id id = Isar.autoIncrement;

  final PersonalInfo personalInfo;
  final List<Experience> experiences;
  final List<Skill> skills;
  final List<Language> languages;
  final List<Education> education;
  final List<Reference> references;

  CVData({
    required this.personalInfo,
    required this.experiences,
    required this.skills,
    required this.languages,
    required this.education,
    required this.references,
  });

  factory CVData.initial() {
    return CVData(
      personalInfo: PersonalInfo(),
      experiences: [],
      skills: [],
      languages: [],
      education: [],
      references: [],
    );
  }

  // Factory to convert a CVHistory object back to a live CVData object.
  factory CVData.fromHistory(CVHistory history) {
    return CVData(
      personalInfo: history.personalInfo,
      experiences: history.experiences,
      skills: history.skills,
      languages: history.languages,
      education: history.education,
      references: history.references,
    );
  }

  CVData copyWith({
    PersonalInfo? personalInfo,
    List<Experience>? experiences,
    List<Skill>? skills,
    List<Language>? languages,
    List<Education>? education,
    List<Reference>? references,
  }) {
    return CVData(
      personalInfo: personalInfo ?? this.personalInfo,
      experiences: experiences ?? this.experiences,
      skills: skills ?? this.skills,
      languages: languages ?? this.languages,
      education: education ?? this.education,
      references: references ?? this.references,
    );
  }
}
