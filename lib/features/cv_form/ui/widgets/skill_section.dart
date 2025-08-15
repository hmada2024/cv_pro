// features/cv_form/ui/widgets/skill_section.dart
import 'package:cv_pro/core/widgets/empty_state_widget.dart';
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
  bool _isFormVisible = false;

  @override
  void initState() {
    super.initState();
    _selectedSkillLevel = ValueNotifier(kSkillLevels[1]);
  }

  @override
  void dispose() {
    _skillController.dispose();
    _selectedSkillLevel.dispose();
    super.dispose();
  }

  void _resetForm() {
    setState(() {
      _skillController.clear();
      _selectedSkillLevel.value = kSkillLevels[1];
      _isFormVisible = false;
    });
  }

  void _addSkill() {
    if (_skillController.text.isNotEmpty) {
      ref.read(cvFormProvider.notifier).addSkill(
            name: _skillController.text,
            level: _selectedSkillLevel.value,
          );
      _resetForm();
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
            if (skills.isNotEmpty)
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
            if (_isFormVisible)
              _buildFormFields()
            else ...[
              if (skills.isEmpty) ...[
                const EmptyStateWidget(
                  icon: Icons.star_border,
                  title: 'No skills added yet',
                  subtitle: 'Highlight your key abilities to catch attention.',
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () => setState(() => _isFormVisible = true),
                  icon: const Icon(Icons.add),
                  label: const Text('Add First Skill'),
                ),
              ] else ...[
                const SizedBox(height: 16),
                OutlinedButton.icon(
                  onPressed: () => setState(() => _isFormVisible = true),
                  icon: const Icon(Icons.add),
                  label: const Text('Add New Skill'),
                ),
              ]
            ]
          ],
        ),
      ),
    );
  }

  Widget _buildFormFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Divider(height: 32),
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
              items: kSkillLevels.map<DropdownMenuItem<String>>((String value) {
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
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: _resetForm,
                child: const Text('Cancel'),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: ElevatedButton(
                onPressed: _addSkill,
                child: const Text('Save Skill'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
