// features/cv_form/ui/widgets/experience_section.dart

import 'package:cv_pro/core/widgets/english_only_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cv_pro/features/cv_form/data/models/cv_data.dart';
import 'package:cv_pro/features/cv_form/data/providers/cv_form_provider.dart';

class ExperienceSection extends ConsumerStatefulWidget {
  const ExperienceSection({super.key});

  @override
  ConsumerState<ExperienceSection> createState() => _ExperienceSectionState();
}

class _ExperienceSectionState extends ConsumerState<ExperienceSection> {
  final _companyController = TextEditingController();
  final _positionController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void dispose() {
    _companyController.dispose();
    _positionController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _showExperienceDialog({Experience? existingExperience, int? index}) {
    final isEditing = existingExperience != null;

    if (isEditing) {
      _positionController.text = existingExperience.position;
      _companyController.text = existingExperience.companyName;
      _descriptionController.text = existingExperience.description;
    } else {
      _positionController.clear();
      _companyController.clear();
      _descriptionController.clear();
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(isEditing ? 'Edit Experience' : 'Add Experience'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // ✅✅ UPDATED: Using EnglishOnlyTextField ✅✅
                EnglishOnlyTextField(
                    controller: _positionController,
                    labelText: 'Position / Job Title'),
                const SizedBox(height: 12),
                // ✅✅ UPDATED: Using EnglishOnlyTextField ✅✅
                EnglishOnlyTextField(
                    controller: _companyController, labelText: 'Company Name'),
                const SizedBox(height: 12),
                // ✅✅ UPDATED: Using EnglishOnlyTextField ✅✅
                EnglishOnlyTextField(
                    controller: _descriptionController,
                    labelText: 'Description',
                    maxLines: 3),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (isEditing) {
                  final updatedExperience = Experience.create(
                    companyName: _companyController.text,
                    position: _positionController.text,
                    description: _descriptionController.text,
                    startDate: existingExperience.startDate,
                    endDate: existingExperience.endDate,
                  );
                  ref
                      .read(cvFormProvider.notifier)
                      .updateExperience(index!, updatedExperience);
                } else {
                  ref.read(cvFormProvider.notifier).addExperience(
                        position: _positionController.text,
                        companyName: _companyController.text,
                        description: _descriptionController.text,
                      );
                }
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    ).then((_) {
      _positionController.clear();
      _companyController.clear();
      _descriptionController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final experiences = ref.watch(cvFormProvider).experiences;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                const Icon(Icons.business_center, color: Colors.blueGrey),
                const SizedBox(width: 8),
                Text(
                  'Work Experience',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              icon: const Icon(Icons.add),
              label: const Text('Add Experience'),
              onPressed: () => _showExperienceDialog(),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
            if (experiences.isNotEmpty) const SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: experiences.length,
              itemBuilder: (context, index) {
                final exp = experiences[index];
                return _buildExperienceCard(exp, index);
              },
            ),
            if (experiences.isEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  'No work experience added yet.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildExperienceCard(Experience exp, int index) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: ListTile(
        leading: const Icon(Icons.check_circle_outline, color: Colors.green),
        title:
            Text(exp.position, style: Theme.of(context).textTheme.titleMedium),
        subtitle: Text(exp.companyName,
            style: Theme.of(context).textTheme.bodyMedium),
        trailing: IconButton(
          icon: Icon(Icons.delete_outline,
              color: Theme.of(context).colorScheme.error),
          onPressed: () {
            ref.read(cvFormProvider.notifier).removeExperience(index);
          },
        ),
        onTap: () =>
            _showExperienceDialog(existingExperience: exp, index: index),
      ),
    );
  }
}
