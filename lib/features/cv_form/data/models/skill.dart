// features/cv_form/data/models/skill.dart

part of 'cv_data.dart';

@embedded
class Skill {
  late String name;
  late String level;

  Skill() {
    name = '';
    level = kSkillLevels[1];
  }

  Skill.create({required this.name, required this.level});
}
