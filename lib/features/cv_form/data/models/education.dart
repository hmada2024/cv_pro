// features/cv_form/data/models/education.dart

part of 'cv_data.dart';

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
