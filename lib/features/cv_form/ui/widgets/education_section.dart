// features/cv_form/ui/widgets/education_section.dart

import 'package:cv_pro/core/widgets/english_only_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cv_pro/features/cv_form/data/models/cv_data.dart';
import 'package:cv_pro/features/cv_form/data/providers/cv_form_provider.dart';

class EducationSection extends ConsumerStatefulWidget {
  const EducationSection({super.key});

  @override
  ConsumerState<EducationSection> createState() => _EducationSectionState();
}

class _EducationSectionState extends ConsumerState<EducationSection> {
  final _schoolController = TextEditingController();
  final _degreeController = TextEditingController();

  @override
  void dispose() {
    _schoolController.dispose();
    _degreeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final educationList = ref.watch(cvFormProvider).education;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                const Icon(Icons.school, color: Colors.blueGrey),
                const SizedBox(width: 8),
                Text(
                  'Education',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            const SizedBox(height: 16),
            EnglishOnlyTextField(
                controller: _degreeController,
                labelText: 'Degree (e.g., Bachelor of Science)'),
            const SizedBox(height: 12),
            EnglishOnlyTextField(
                controller: _schoolController,
                labelText: 'School / University'),
            const SizedBox(height: 16),
            ElevatedButton(
                onPressed: () {
                  ref.read(cvFormProvider.notifier).addEducation(
                        school: _schoolController.text,
                        degree: _degreeController.text,
                      );
                  _schoolController.clear();
                  _degreeController.clear();
                },
                child: const Text('Add Education')),
            if (educationList.isNotEmpty) const SizedBox(height: 16),
            for (var i = 0; i < educationList.length; i++)
              _buildEducationCard(educationList[i], i),
          ],
        ),
      ),
    );
  }

  Widget _buildEducationCard(Education edu, int index) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: ListTile(
        leading: const Icon(Icons.menu_book, color: Colors.purple),
        title: Text(edu.degree, style: Theme.of(context).textTheme.titleMedium),
        subtitle:
            Text(edu.school, style: Theme.of(context).textTheme.bodyMedium),
        trailing: IconButton(
          icon: Icon(Icons.delete_outline,
              color: Theme.of(context).colorScheme.error),
          onPressed: () {
            ref.read(cvFormProvider.notifier).removeEducation(index);
          },
        ),
      ),
    );
  }
}
