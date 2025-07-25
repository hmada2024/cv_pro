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
      // استخدام المنشئ الجديد .create
      ref.read(cvFormProvider.notifier).addLanguage(Language.create(
          name: _languageController.text,
          proficiency: _proficiencyController.text));
      _languageController.clear();
      _proficiencyController.clear();
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Language Added')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final languages = ref.watch(cvFormProvider).languages;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Languages', style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 10),
        TextFormField(
            controller: _languageController,
            decoration:
                const InputDecoration(labelText: 'Language (e.g., English)')),
        const SizedBox(height: 10),
        TextFormField(
            controller: _proficiencyController,
            decoration: const InputDecoration(
                labelText: 'Proficiency (e.g., Native, Fluent)')),
        const SizedBox(height: 10),
        SizedBox(
            width: double.infinity,
            child: ElevatedButton(
                onPressed: _addLanguage, child: const Text('Add Language'))),
        const SizedBox(height: 10),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: languages.length,
          itemBuilder: (context, index) {
            final lang = languages[index];
            return Card(
                margin: const EdgeInsets.only(top: 8),
                child: ListTile(
                    title: Text(lang.name), subtitle: Text(lang.proficiency)));
          },
        )
      ],
    );
  }
}
