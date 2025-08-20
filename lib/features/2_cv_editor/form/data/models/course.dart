// lib/features/2_cv_editor/form/data/models/course.dart
part of 'cv_data.dart';

@embedded
class Course {
  late String name;
  late String institution;
  DateTime? completionDate;
  String? description;

  // A getter to easily check if this is an ongoing course.
  bool get isCurrent => completionDate == null;

  Course() {
    name = '';
    institution = '';
    description = '';
    completionDate = DateTime.now();
  }

  Course.create({
    required this.name,
    required this.institution,
    this.completionDate,
    this.description,
  });

  /// A utility method for copying the object with new values.
  Course copyWith({
    String? name,
    String? institution,
    DateTime? completionDate,
    String? description,
    bool? isCurrent, // To easily set/unset the completion date
  }) {
    return Course.create(
      name: name ?? this.name,
      institution: institution ?? this.institution,
      description: description ?? this.description,
      // If isCurrent is provided, it dictates if completionDate is null or not.
      completionDate:
          (isCurrent == true) ? null : (completionDate ?? this.completionDate),
    );
  }
}
