import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cv_pro/features/cv_form/data/providers/cv_form_provider.dart';

class SkillSection extends ConsumerStatefulWidget {
  const SkillSection({super.key});

  @override
  ConsumerState<SkillSection> createState() => _SkillSectionState();
}

class _SkillSectionState extends ConsumerState<SkillSection> {
  final _skillController = TextEditingController();
  // ✅✅ تم التحديث: إضافة متغير حالة لتخزين قيمة الـ Slider ✅✅
  double _currentSkillLevel = 50.0;

  @override
  void dispose() {
    _skillController.dispose();
    super.dispose();
  }

  // ✅✅ تم التحديث: دالة لإضافة المهارة ✅✅
  void _addSkill() {
    if (_skillController.text.isNotEmpty) {
      ref.read(cvFormProvider.notifier).addSkill(
            name: _skillController.text,
            level: _currentSkillLevel.round(),
          );
      _skillController.clear();
      setState(() {
        _currentSkillLevel = 50.0; // Reset slider
      });
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
                Text('Skills', style: Theme.of(context).textTheme.titleLarge),
              ],
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _skillController,
              decoration: const InputDecoration(
                  labelText: 'Skill Name (e.g., Flutter)'),
              onFieldSubmitted: (value) => _addSkill(),
            ),
            // ✅✅ تم التحديث: إضافة Slider ومؤشر النسبة ✅✅
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Slider(
                    value: _currentSkillLevel,
                    min: 0,
                    max: 100,
                    divisions: 100,
                    label: '${_currentSkillLevel.round()}%',
                    onChanged: (double value) {
                      setState(() {
                        _currentSkillLevel = value;
                      });
                    },
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    '${_currentSkillLevel.round()}%',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: _addSkill,
              child: const Text('Add Skill'),
            ),
            if (skills.isNotEmpty) const SizedBox(height: 16),
            Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
              // ✅✅ تم التحديث: عرض المستوى بجانب اسم المهارة ✅✅
              children: skills
                  .map((skill) => Chip(
                        label: Text('${skill.name} (${skill.level}%)'),
                        avatar: CircleAvatar(
                          backgroundColor: Colors.blueGrey.shade200,
                          child: Text(
                            '${skill.level}',
                            style: const TextStyle(
                                fontSize: 10, color: Colors.white),
                          ),
                        ),
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
