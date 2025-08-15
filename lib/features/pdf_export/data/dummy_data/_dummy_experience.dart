// features/pdf_export/data/dummy_data/_dummy_experience.dart
part of 'cv_data_dummy.dart';

List<Experience> _createDummyExperiences() {
  return [
    Experience.create(
      position: 'Senior Graphic Designer',
      companyName: 'Fauget Studio',
      startDate: DateTime(2020, 1, 1),
      description:
          '• create more than 100 graphic designs for big companies\n• complete a lot of complicated work',
    ),
    Experience.create(
      position: 'Graphic Designer',
      companyName: 'Iarana, Inc',
      startDate: DateTime(2017, 1, 1),
      endDate: DateTime(2019, 12, 1),
      description:
          '• create more than 100 graphic designs for big companies\n• complete a lot of complicated work',
    ),
  ];
}
