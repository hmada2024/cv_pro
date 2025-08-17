// features/cv_form/data/models/experience.dart

part of 'cv_data.dart';

@embedded
class Experience {
  late String companyName;
  late String position;
  late DateTime startDate;
  late DateTime? endDate; // Nullable to indicate "Present"
  late String description;

  /// A getter to easily check if this is the current job.
  bool get isCurrent => endDate == null;

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
    this.endDate,
    required this.description,
  });

  /// A utility method for copying the object with new values.
  Experience copyWith({
    String? companyName,
    String? position,
    DateTime? startDate,
    DateTime? endDate,
    String? description,
    bool? isCurrent, // To easily set/unset the end date
  }) {
    return Experience.create(
      companyName: companyName ?? this.companyName,
      position: position ?? this.position,
      startDate: startDate ?? this.startDate,
      description: description ?? this.description,
      // If isCurrent is provided, it dictates if endDate is null or not.
      endDate: (isCurrent == true) ? null : (endDate ?? this.endDate),
    );
  }
}
