// features/pdf_export/data/dummy_data/_dummy_references.dart
part of 'cv_data_dummy.dart';

List<Reference> _createDummyReferences() {
  return [
    Reference.create(
      name: 'Dr. Jane Doe',
      company: 'Fauget Studio',
      position: 'Art Director',
      email: 'jane.doe@fauget.com',
      phone: '+098-765-4321',
    ),
  ];
}
