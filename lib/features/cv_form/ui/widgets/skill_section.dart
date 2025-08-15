// features/cv_form/ui/widgets/skill_section.dart
import 'package:cv_pro/core/widgets/english_only_text_field.dart';
import 'package:cv_pro/features/cv_form/data/models/cv_constants.dart';
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

  late final ValueNotifier<String> _selectedSkillLevel;

  @override
  void initState() {
    super.initState();
    _selectedSkillLevel = ValueNotifier(kSkillLevels[1]); // 'Intermediate'
  }

  @override
  void dispose() {
    _skillController.dispose();
    _selectedSkillLevel.dispose();
    super.dispose();
  }

  void _addSkill() {
    if (_skillController.text.isNotEmpty) {
      ref.read(cvFormProvider.notifier).addSkill(
            name: _skillController.text,
            level: _selectedSkillLevel.value,
          );
      _skillController.clear();
      _selectedSkillLevel.value = kSkillLevels[1];
    }
  }

  @override
  Widget build(BuildContext context) {
    final skills = ref.watch(cvFormProvider.select((cv) => cv.skills));
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Icon(Icons.star, color: theme.colorScheme.secondary),
                const SizedBox(width: 8),
                Text('Skills', style: theme.textTheme.titleLarge),
              ],
            ),
            const SizedBox(height: 16),
            EnglishOnlyTextField(
              controller: _skillController,
              labelText: 'Skill Name (e.g., Flutter)',
              onFieldSubmitted: (value) => _addSkill(),
            ),
            const SizedBox(height: 12),
            ValueListenableBuilder<String>(
              valueListenable: _selectedSkillLevel,
              builder: (context, currentValue, child) {
                return DropdownButtonFormField<String>(
                  value: currentValue,
                  decoration: const InputDecoration(
                    labelText: 'Proficiency Level',
                    prefixIcon: Icon(Icons.assessment_outlined),
                  ),
                  items: kSkillLevels
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      _selectedSkillLevel.value = newValue;
                    }
                  },
                );
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _addSkill,
              child: const Text('Add Skill'),
            ),
            if (skills.isNotEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Divider(),
              ),
            if (skills.isEmpty)
              const Padding(
                padding: EdgeInsets.only(top: 16.0),
                child: _EmptyStateWidget(
                  icon: Icons.star_border,
                  title: 'No skills added yet',
                  subtitle: 'Highlight your key abilities to catch attention.',
                ),
              ),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: [
                for (var i = 0; i < skills.length; i++)
                  Chip(
                    label: Text('${skills[i].name} (${skills[i].level})'),
                    onDeleted: () {
                      ref.read(cvFormProvider.notifier).removeSkill(i);
                    },
                  )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyStateWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _EmptyStateWidget({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        children: [
          Icon(icon, size: 40, color: theme.colorScheme.secondary),
          const SizedBox(height: 8),
          Text(
            title,
            style: theme.textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: theme.textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
