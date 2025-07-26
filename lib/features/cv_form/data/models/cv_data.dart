import 'package:isar/isar.dart';

part 'cv_data.g.dart';

@collection
class CVData {
  Id id = Isar.autoIncrement;

  final PersonalInfo personalInfo;
  final List<Experience> experiences;
  final List<Skill> skills;
  final List<Language> languages;
  final List<Education> education;
  final List<Reference> references; // ✅ NEW: Added references list

  CVData({
    required this.personalInfo,
    required this.experiences,
    required this.skills,
    required this.languages,
    required this.education,
    required this.references, // ✅ NEW: Added to constructor
  });

  factory CVData.initial() {
    return CVData(
      personalInfo: PersonalInfo(),
      experiences: [],
      skills: [],
      languages: [],
      education: [],
      references: [], // ✅ NEW: Initialized as empty list
    );
  }

  CVData copyWith({
    PersonalInfo? personalInfo,
    List<Experience>? experiences,
    List<Skill>? skills,
    List<Language>? languages,
    List<Education>? education,
    List<Reference>? references, // ✅ NEW: Added to copyWith
  }) {
    return CVData(
      personalInfo: personalInfo ?? this.personalInfo,
      experiences: experiences ?? this.experiences,
      skills: skills ?? this.skills,
      languages: languages ?? this.languages,
      education: education ?? this.education,
      references: references ?? this.references, // ✅ NEW: Added to copyWith
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

  PersonalInfo({
    this.name = '',
    this.jobTitle = '',
    this.email = '',
    this.summary = '',
    this.phone = '',
    this.address = '',
    this.profileImagePath,
  });

  PersonalInfo copyWith({
    String? name,
    String? jobTitle,
    String? email,
    String? summary,
    String? phone,
    String? address,
    String? profileImagePath,
  }) {
    return PersonalInfo(
      name: name ?? this.name,
      jobTitle: jobTitle ?? this.jobTitle,
      email: email ?? this.email,
      summary: summary ?? this.summary,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      profileImagePath: profileImagePath ?? this.profileImagePath,
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
  late int level;

  Skill() {
    name = '';
    level = 50;
  }

  Skill.create({required this.name, required this.level});
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

// ✅ NEW: Added Reference class
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
