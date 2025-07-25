import 'dart:io';
import 'package:isar/isar.dart';

part 'cv_data.g.dart';

@collection
class CVData {
  Id id = Isar.autoIncrement;

  final PersonalInfo personalInfo;
  final List<Experience> experiences;
  final List<Skill> skills;
  final List<Language> languages;

  CVData({
    required this.personalInfo,
    required this.experiences,
    required this.skills,
    required this.languages,
  });

  factory CVData.initial() {
    return CVData(
      personalInfo: PersonalInfo(),
      experiences: [],
      skills: [],
      languages: [],
    );
  }

  CVData copyWith({
    PersonalInfo? personalInfo,
    List<Experience>? experiences,
    List<Skill>? skills,
    List<Language>? languages,
  }) {
    return CVData(
      personalInfo: personalInfo ?? this.personalInfo,
      experiences: experiences ?? this.experiences,
      skills: skills ?? this.skills,
      languages: languages ?? this.languages,
    );
  }
}

@embedded
class PersonalInfo {
  final String name;
  final String jobTitle;
  final String email;

  @ignore
  final File? profileImage;

  PersonalInfo({
    this.name = '',
    this.jobTitle = '',
    this.email = '',
    this.profileImage,
  });

  PersonalInfo copyWith({
    String? name,
    String? jobTitle,
    String? email,
    File? profileImage,
  }) {
    return PersonalInfo(
      name: name ?? this.name,
      jobTitle: jobTitle ?? this.jobTitle,
      email: email ?? this.email,
      profileImage: profileImage ?? this.profileImage,
    );
  }
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

  Skill() {
    name = '';
  }

  Skill.create({required this.name});
}

@embedded
class Language {
  late String name;
  late String proficiency;

  Language() {
    name = '';
    proficiency = '';
  }

  Language.create({required this.name, required this.proficiency});
}
