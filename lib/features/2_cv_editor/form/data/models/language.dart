// features/cv_form/data/models/language.dart

part of 'cv_data.dart';

@embedded
class Language {
  late String name;
  late String proficiency;

  Language() {
    name = '';
    proficiency = kSkillLevels[1];
  }

  Language.create({required this.name, required this.proficiency});
}
