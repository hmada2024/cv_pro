// features/cv_form/data/models/cv_data.dart

import 'package:isar/isar.dart';

part 'cv_data.g.dart';

const List<String> kMaritalStatusOptions = [
  'Single',
  'Married',
  'Divorced',
  'Widowed'
];
const List<String> kMilitaryServiceOptions = [
  'Completed',
  'Exempted',
  'Postponed',
  'Not Applicable'
];

const List<String> kSkillLevels = [
  'Beginner',
  'Intermediate',
  'Upper-Intermediate',
  'Advanced',
  'Expert'
];


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

@embedded
class PersonalInfo {
  final String name;
  final String jobTitle;
  final String email;
  final String summary;
  final String? phone;
  final String? address;
  final String? profileImagePath;

  final DateTime? birthDate;
  final String? maritalStatus;
  final String? militaryServiceStatus;

  PersonalInfo({
    this.name = '',
    this.jobTitle = '',
    this.email = '',
    this.summary = '',
    this.phone = '',
    this.address = '',
    this.profileImagePath,
    this.birthDate,
    this.maritalStatus,
    this.militaryServiceStatus,
  });

  PersonalInfo copyWith({
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
    return PersonalInfo(
      name: name ?? this.name,
      jobTitle: jobTitle ?? this.jobTitle,
      email: email ?? this.email,
      summary: summary ?? this.summary,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      profileImagePath: profileImagePath ?? this.profileImagePath,
      birthDate: birthDate ?? this.birthDate,
      maritalStatus: maritalStatus ?? this.maritalStatus,
      militaryServiceStatus:
          militaryServiceStatus ?? this.militaryServiceStatus,
    );
  }
}

@embedded
class Education {
  late String school;
  late String degree;
  late DateTime startDate;
  late DateTime endDate;

  Education() {
    school = '';
    degree = '';
    startDate = DateTime.now();
    endDate = DateTime.now();
  }

  Education.create({
    required this.school,
    required this.degree,
    required this.startDate,
    required this.endDate,
  });
}

@embedded
class Experience {
  late String companyName;
  late String position;
  late DateTime startDate;
  late DateTime endDate;
  late String description;

  Experience() {
    companyName = '';
    position = '';
    startDate = DateTime.now();
    endDate = DateTime.now();
    description = '';
  }

  Experience.create({
    required this.companyName,
    required this.position,
    required this.startDate,
    required this.endDate,
    required this.description,
  });
}

@embedded
class Skill {
  late String name;
  late String level;

  Skill() {
    name = '';
    level = kSkillLevels[1];
  }

  Skill.create({required this.name, required this.level});
}

@embedded
class Language {
  late String name;
  late String proficiency;

  Language() {
    name = '';
    proficiency = kSkillLevels[1];
  }

  Language.create({required this.name, required this.proficiency});
}

@embedded
class Reference {
  late String name;
  late String company;
  late String position;
  late String email;
  String? phone;

  Reference() {
    name = '';
    company = '';
    position = '';
    email = '';
    phone = '';
  }

  Reference.create({
    required this.name,
    required this.company,
    required this.position,
    required this.email,
    this.phone,
  });
}
