// lib/features/2_cv_editor/form/data/models/cv_data.dart
import 'package:isar/isar.dart';
import 'package:cv_pro/features/2_cv_editor/form/data/models/cv_constants.dart';

part 'personal_info.dart';
part 'experience.dart';
part 'skill.dart';
part 'language.dart';
part 'education.dart';
part 'reference.dart';
part 'course.dart';
part 'cv_data.g.dart';

@collection
class CVData {
  Id id; // تم التعديل: لم يعد افتراضيًا هنا مباشرةً

  @Index(unique: true, replace: false)
  late String projectName;

  late DateTime lastModified;

  final PersonalInfo personalInfo;
  final List<Experience> experiences;
  final List<Skill> skills;
  final List<Language> languages;
  final List<Education> education;
  final List<Reference> references;
  final List<Course> courses;

  CVData({
    this.id = Isar.autoIncrement, // تم التعديل: القيمة الافتراضية هنا في المنشئ
    this.projectName = '',
    required this.personalInfo,
    required this.experiences,
    required this.skills,
    required this.languages,
    required this.education,
    required this.references,
    required this.courses,
  }) {
    // يتم تعيينه هنا لضمان تحديثه مع كل نسخة جديدة
    lastModified = DateTime.now();
  }

  factory CVData.initial(String name) {
    return CVData(
      projectName: name,
      personalInfo: PersonalInfo(),
      experiences: [],
      skills: [],
      languages: [],
      education: [],
      references: [],
      courses: [],
    );
  }

  // تم تعديل هذه الدالة بالكامل لحل المشكلة
  CVData copyWith({
    String? projectName,
    PersonalInfo? personalInfo,
    List<Experience>? experiences,
    List<Skill>? skills,
    List<Language>? languages,
    List<Education>? education,
    List<Reference>? references,
    List<Course>? courses,
  }) {
    return CVData(
      id: id, // <-- هذا هو السطر الأهم: الحفاظ على الـ ID الأصلي
      projectName: projectName ?? this.projectName,
      personalInfo: personalInfo ?? this.personalInfo,
      experiences: experiences ?? this.experiences,
      skills: skills ?? this.skills,
      languages: languages ?? this.languages,
      education: education ?? this.education,
      references: references ?? this.references,
      courses: courses ?? this.courses,
    );
  }
}
