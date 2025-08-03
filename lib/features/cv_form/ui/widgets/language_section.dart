// features/cv_form/ui/widgets/language_section.dart

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
  String? _selectedProficiencyLevel;

  @override
  void initState() {
    super.initState();
    _selectedProficiencyLevel = kSkillLevels[1]; // "Intermediate"
  }

  @override
  void dispose() {
    _languageController.dispose();
    super.dispose();
  }

  void _addLanguage() {
    if (_languageController.text.isNotEmpty &&
        _selectedProficiencyLevel != null) {
      ref.read(cvFormProvider.notifier).addLanguage(
            name: _languageController.text,
            proficiency: _selectedProficiencyLevel!,
          );
      _languageController.clear();
      setState(() {
        _selectedProficiencyLevel = kSkillLevels[1];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final languages = ref.watch(cvFormProvider).languages;
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Icon(Icons.language, color: theme.colorScheme.secondary),
                const SizedBox(width: 8),
                Text('Languages', style: theme.textTheme.titleLarge),
              ],
            ),
            const SizedBox(height: 16),
            EnglishOnlyTextField(
              controller: _languageController,
              labelText: 'Language (e.g., English)',
              onFieldSubmitted: (_) => _addLanguage(),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: _selectedProficiencyLevel,
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
                setState(() {
                  _selectedProficiencyLevel = newValue;
                });
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _addLanguage,
              child: const Text('Add Language'),
            ),
            if (languages.isNotEmpty) const SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: languages.length,
              itemBuilder: (context, index) {
                final lang = languages[index];
                return _buildLanguageCard(context, theme, lang, index);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageCard(
      BuildContext context, ThemeData theme, Language lang, int index) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
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
