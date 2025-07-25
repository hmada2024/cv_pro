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

  void _addSkill() {
    final value = _skillController.text;
    if (value.isNotEmpty) {
      ref.read(cvFormProvider.notifier).addSkill(Skill.create(name: value));
      _skillController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final skills = ref.watch(cvFormProvider).skills;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                const Icon(Icons.star, color: Colors.blueGrey),
                const SizedBox(width: 8),
                Text('المهارات', style: Theme.of(context).textTheme.titleLarge),
              ],
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _skillController,
              decoration: const InputDecoration(
                  labelText: 'اسم المهارة (مثال: Flutter)'),
              onFieldSubmitted: (value) => _addSkill(),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _addSkill,
              child: const Text('أضف مهارة'),
            ),
            if (skills.isNotEmpty) const SizedBox(height: 16),
            // عرض المهارات باستخدام Wrap و Chip
            Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
              children: skills
                  .map((skill) => Chip(
                        label: Text(skill.name),
                        backgroundColor: Colors.blueGrey.shade50,
                        labelStyle: const TextStyle(color: Colors.blueGrey),
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
