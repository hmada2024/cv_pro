import 'dart:io';

// النموذج الرئيسي الذي يجمع كل البيانات
class CVData {
  final PersonalInfo personalInfo;
  final List<Experience> experiences;

  CVData({
    required this.personalInfo,
    required this.experiences,
  });

  // دالة مساعدة لتحديث البيانات بسهولة (مهم جداً مع Riverpod)
  CVData copyWith({
    PersonalInfo? personalInfo,
    List<Experience>? experiences,
  }) {
    return CVData(
      personalInfo: personalInfo ?? this.personalInfo,
      experiences: experiences ?? this.experiences,
    );
  }
}

class PersonalInfo {
  final String name;
  final String jobTitle;
  final String email;
  final File? profileImage; // اختياري في البداية

  PersonalInfo({
    this.name = '',
    this.jobTitle = '',
    this.email = '',
    this.profileImage,
  });

  PersonalInfo copyWith({String? name, String? jobTitle, String? email}) {
    return PersonalInfo(
      name: name ?? this.name,
      jobTitle: jobTitle ?? this.jobTitle,
      email: email ?? this.email,
      profileImage: profileImage,
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
