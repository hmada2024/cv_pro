import 'dart:io';

class CVData {
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

  // دالة مصنعية للحصول على الحالة الأولية بسهولة
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

class PersonalInfo {
  final String name;
  final String jobTitle;
  final String email;
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

class Experience {
  final String companyName;
  final String position;
  final DateTime startDate;
  final DateTime endDate;
  final String description;

  Experience({
    required this.companyName,
    required this.position,
    required this.startDate,
    required this.endDate,
    required this.description,
  });
}

class Skill {
  final String name;
  Skill({required this.name});
}

class Language {
  final String name;
  final String proficiency;
  Language({required this.name, required this.proficiency});
}
