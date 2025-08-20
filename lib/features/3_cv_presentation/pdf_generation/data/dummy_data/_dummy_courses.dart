// lib/features/3_cv_presentation/pdf_generation/data/dummy_data/_dummy_courses.dart
part of 'cv_data_dummy.dart';

List<Course> _createDummyCourses() {
  return [
    Course.create(
      name: 'UI/UX Design Masterclass',
      institution: 'Udemy',
      completionDate: DateTime(2022, 5, 15),
      description:
          'Comprehensive course on user interface and experience design principles.',
    ),
    Course.create(
      name: 'Adobe Certified Expert (ACE) - Photoshop',
      institution: 'Adobe',
      completionDate: DateTime(2021, 11, 20),
    ),
    Course.create(
      name: 'Advanced Prototyping in Figma',
      institution: 'Coursera',
      completionDate: null, // Ongoing course
      description: 'Focusing on interactive components and design systems.',
    ),
  ];
}
