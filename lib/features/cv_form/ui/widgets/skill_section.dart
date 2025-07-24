import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cv_pro/features/cv_form/data/models/cv_data.dart';
import 'package:cv_pro/features/cv_form/data/providers/cv_form_provider.dart';

class SkillSection extends ConsumerStatefulWidget {
  const SkillSection({super.key});

  @override
  ConsumerState<SkillSection> createState() => _SkillSectionState();
}

class _SkillSectionState extends ConsumerState<SkillSection> {
  final _skillController = TextEditingController();

  @override
  void dispose() {
    _skillController.dispose();
    super.dispose();
  }

  void _addSkill(String value) {
    if (value.isNotEmpty) {
      ref.read(cvFormProvider.notifier).addSkill(Skill(name: value));
      _skillController.clear();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('تمت إضافة المهارة: $value')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final skills = ref.watch(cvFormProvider).skills;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('المهارات', style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 10),
        TextFormField(
          controller: _skillController,
          decoration:
              const InputDecoration(labelText: 'اسم المهارة (مثل: Flutter)'),
          onFieldSubmitted: _addSkill,
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8.0,
          runSpacing: 4.0,
          children:
              skills.map((skill) => Chip(label: Text(skill.name))).toList(),
        ),
      ],
    );
  }
}
