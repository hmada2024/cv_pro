// features/cv_form/ui/widgets/language_section.dart
import 'package:cv_pro/core/constants/app_sizes.dart';
import 'package:cv_pro/core/widgets/empty_state_widget.dart';
import 'package:cv_pro/core/widgets/english_only_text_field.dart';
import 'package:cv_pro/features/cv_form/data/models/cv_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cv_pro/features/cv_form/data/models/cv_data.dart';
import 'package:cv_pro/features/cv_form/data/providers/cv_form_provider.dart';

class LanguageSection extends ConsumerStatefulWidget {
  const LanguageSection({super.key});

  @override
  ConsumerState<LanguageSection> createState() => _LanguageSectionState();
}

class _LanguageSectionState extends ConsumerState<LanguageSection> {
  final _languageController = TextEditingController();
  late final ValueNotifier<String> _selectedProficiencyLevel;
  bool _isFormVisible = false;

  @override
  void initState() {
    super.initState();
    _selectedProficiencyLevel =
        ValueNotifier(kSkillLevels[1]); // "Intermediate"
  }

  @override
  void dispose() {
    _languageController.dispose();
    _selectedProficiencyLevel.dispose();
    super.dispose();
  }

  void _resetForm() {
    setState(() {
      _languageController.clear();
      _selectedProficiencyLevel.value = kSkillLevels[1];
      _isFormVisible = false;
    });
  }

  void _addLanguage() {
    if (_languageController.text.isNotEmpty) {
      ref.read(cvFormProvider.notifier).addLanguage(
            name: _languageController.text,
            proficiency: _selectedProficiencyLevel.value,
          );
      _resetForm();
    }
  }

  @override
  Widget build(BuildContext context) {
    final languages = ref.watch(cvFormProvider.select((cv) => cv.languages));
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.p16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Icon(Icons.language, color: theme.colorScheme.secondary),
                const SizedBox(width: AppSizes.p8),
                Text('Languages', style: theme.textTheme.titleLarge),
              ],
            ),
            const SizedBox(height: AppSizes.p16),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: languages.length,
              itemBuilder: (context, index) {
                final lang = languages[index];
                return _buildLanguageCard(context, theme, lang, index);
              },
            ),
            if (_isFormVisible)
              _buildFormFields()
            else ...[
              if (languages.isEmpty) ...[
                const EmptyStateWidget(
                  icon: Icons.translate,
                  title: 'No languages added',
                  subtitle: 'Showcase your language skills to employers.',
                ),
                const SizedBox(height: AppSizes.p16),
                ElevatedButton.icon(
                  onPressed: () => setState(() => _isFormVisible = true),
                  icon: const Icon(Icons.add),
                  label: const Text('Add First Language'),
                ),
              ] else ...[
                const SizedBox(height: AppSizes.p16),
                OutlinedButton.icon(
                  onPressed: () => setState(() => _isFormVisible = true),
                  icon: const Icon(Icons.add),
                  label: const Text('Add New Language'),
                ),
              ],
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
        const Divider(height: AppSizes.p32),
        EnglishOnlyTextField(
          controller: _languageController,
          labelText: 'Language (e.g., English)',
          onFieldSubmitted: (_) => _addLanguage(),
        ),
        const SizedBox(height: AppSizes.p12),
        ValueListenableBuilder<String>(
          valueListenable: _selectedProficiencyLevel,
          builder: (context, currentValue, child) {
            return DropdownButtonFormField<String>(
              value: currentValue,
              decoration: const InputDecoration(
                labelText: 'Proficiency Level',
                prefixIcon: Icon(Icons.bar_chart_outlined),
              ),
              items: kSkillLevels.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  _selectedProficiencyLevel.value = newValue;
                }
              },
            );
          },
        ),
        const SizedBox(height: AppSizes.p16),
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: _resetForm,
                child: const Text('Cancel'),
              ),
            ),
            const SizedBox(width: AppSizes.p8),
            Expanded(
              child: ElevatedButton(
                onPressed: _addLanguage,
                child: const Text('Save Language'),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLanguageCard(
      BuildContext context, ThemeData theme, Language lang, int index) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: AppSizes.p8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.buttonRadius),
        side: BorderSide(color: theme.dividerColor),
      ),
      child: ListTile(
        leading: Icon(Icons.translate, color: theme.colorScheme.primary),
        title: Text(lang.name, style: theme.textTheme.titleMedium),
        subtitle: Text(lang.proficiency, style: theme.textTheme.bodyMedium),
        trailing: IconButton(
          icon: Icon(Icons.delete_outline, color: theme.colorScheme.error),
          onPressed: () {
            ref.read(cvFormProvider.notifier).removeLanguage(index);
          },
        ),
      ),
    );
  }
}
