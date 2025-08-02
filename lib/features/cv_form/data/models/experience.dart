// features/cv_form/data/models/experience.dart

part of 'cv_data.dart';

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
