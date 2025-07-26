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
  final _proficiencyController = TextEditingController();

  @override
  void dispose() {
    _languageController.dispose();
    _proficiencyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final languages = ref.watch(cvFormProvider).languages;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                const Icon(Icons.language, color: Colors.blueGrey),
                const SizedBox(width: 8),
                Text('Languages',
                    style: Theme.of(context).textTheme.titleLarge),
              ],
            ),
            const SizedBox(height: 16),
            TextFormField(
                controller: _languageController,
                decoration: const InputDecoration(
                    labelText: 'Language (e.g., English)')),
            const SizedBox(height: 12),
            TextFormField(
                controller: _proficiencyController,
                decoration: const InputDecoration(
                    labelText: 'Proficiency (e.g., Native)')),
            const SizedBox(height: 16),
            ElevatedButton(
                onPressed: () {
                  ref.read(cvFormProvider.notifier).addLanguage(
                        name: _languageController.text,
                        proficiency: _proficiencyController.text,
                      );
                  _languageController.clear();
                  _proficiencyController.clear();
                },
                child: const Text('Add Language')),
            if (languages.isNotEmpty) const SizedBox(height: 16),
            for (var i = 0; i < languages.length; i++)
              _buildLanguageCard(languages[i], i),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageCard(Language lang, int index) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: ListTile(
        leading: const Icon(Icons.translate, color: Colors.blue),
        title: Text(lang.name, style: Theme.of(context).textTheme.titleMedium),
        subtitle: Text(lang.proficiency,
            style: Theme.of(context).textTheme.bodyMedium),
        trailing: IconButton(
          icon: Icon(Icons.delete_outline,
              color: Theme.of(context).colorScheme.error),
          onPressed: () {
            ref.read(cvFormProvider.notifier).removeLanguage(index);
          },
        ),
      ),
    );
  }
}
