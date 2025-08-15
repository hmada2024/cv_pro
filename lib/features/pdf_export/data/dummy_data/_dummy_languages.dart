// features/pdf_export/data/dummy_data/_dummy_languages.dart
part of 'cv_data_dummy.dart';

List<Language> _createDummyLanguages() {
  return [
    Language.create(name: 'English', proficiency: 'Expert'),
    Language.create(name: 'French', proficiency: 'Advanced'),
  ];
}
