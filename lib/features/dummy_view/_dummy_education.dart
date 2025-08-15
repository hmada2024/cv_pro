// features/pdf_export/data/dummy_data/_dummy_education.dart
part of 'cv_data_dummy.dart';

List<Education> _createDummyEducation() {
  return [
    Education.create(
      level: EducationLevel.master,
      degreeName: 'of Graphic Design',
      school: 'Arts University',
      startDate: DateTime(2015, 9, 1),
      endDate: DateTime(2017, 6, 1),
    ),
    Education.create(
      level: EducationLevel.bachelor,
      degreeName: 'of Fine Arts',
      school: 'Wardiere University',
      startDate: DateTime(2011, 9, 1),
      endDate: DateTime(2015, 6, 1),
    ),
    Education.create(
      level: EducationLevel.bachelor, // Example of another degree
      degreeName: 'Diploma in Digital Media',
      school: 'Online Design Institute',
      startDate: DateTime(2010, 1, 1),
      endDate: DateTime(2011, 1, 1),
    ),
  ];
}
