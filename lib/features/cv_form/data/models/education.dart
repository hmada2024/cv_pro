// features/cv_form/data/models/education.dart

part of 'cv_data.dart';

enum EducationLevel {
  bachelor,
  master,
  doctor,
}

extension EducationLevelExtension on EducationLevel {
  String toDisplayString() {
    switch (this) {
      case EducationLevel.bachelor:
        return 'Bachelor';
      case EducationLevel.master:
        return 'Master';
      case EducationLevel.doctor:
        return 'Doctorate';
    }
  }
}

@embedded
class Education {
  @Enumerated(EnumType.name)
  late EducationLevel level;

  late String degreeName;
  late String school;
  late DateTime startDate;
  late DateTime? endDate; // Nullable to indicate "Present"

  /// A getter to easily check if this is the current place of study.
  bool get isCurrent => endDate == null;

  Education() {
    level = EducationLevel.bachelor;
    degreeName = '';
    school = '';
    startDate = DateTime.now();
    endDate = DateTime.now();
  }

  Education.create({
    required this.level,
    required this.degreeName,
    required this.school,
    required this.startDate,
    this.endDate,
  });

  /// A utility method for copying the object with new values.
  Education copyWith({
    EducationLevel? level,
    String? degreeName,
    String? school,
    DateTime? startDate,
    DateTime? endDate,
    bool? isCurrent, // To easily set/unset the end date
  }) {
    return Education.create(
      level: level ?? this.level,
      degreeName: degreeName ?? this.degreeName,
      school: school ?? this.school,
      startDate: startDate ?? this.startDate,
      // If isCurrent is provided, it dictates if endDate is null or not.
      endDate: (isCurrent == true) ? null : (endDate ?? this.endDate),
    );
  }
}
