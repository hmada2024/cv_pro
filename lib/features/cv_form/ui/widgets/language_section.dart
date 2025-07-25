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

  void _addLanguage() {
    if (_languageController.text.isNotEmpty &&
        _proficiencyController.text.isNotEmpty) {
      ref.read(cvFormProvider.notifier).addLanguage(Language.create(
          name: _languageController.text,
          proficiency: _proficiencyController.text));
      _languageController.clear();
      _proficiencyController.clear();
    }
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
                Text('اللغات', style: Theme.of(context).textTheme.titleLarge),
              ],
            ),
            const SizedBox(height: 16),
            TextFormField(
                controller: _languageController,
                decoration:
                    const InputDecoration(labelText: 'اللغة (مثال: العربية)')),
            const SizedBox(height: 12),
            TextFormField(
                controller: _proficiencyController,
                decoration:
                    const InputDecoration(labelText: 'المستوى (مثال: لغة أم)')),
            const SizedBox(height: 16),
            ElevatedButton(
                onPressed: _addLanguage, child: const Text('أضف لغة')),
            if (languages.isNotEmpty) const SizedBox(height: 16),
            ...languages.map((lang) => _buildLanguageCard(lang)),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageCard(Language lang) {
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
      ),
    );
  }
}
