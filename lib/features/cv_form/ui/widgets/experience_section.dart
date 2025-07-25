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

  void _addExperience() {
    if (_companyController.text.isNotEmpty &&
        _positionController.text.isNotEmpty) {
      final newExperience = Experience.create(
          companyName: _companyController.text,
          position: _positionController.text,
          description: _descriptionController.text,
          startDate: DateTime.now().subtract(const Duration(days: 365)),
          endDate: DateTime.now());
      ref.read(cvFormProvider.notifier).addExperience(newExperience);
      _companyController.clear();
      _positionController.clear();
      _descriptionController.clear();
    }
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
            TextFormField(
                controller: _positionController,
                decoration:
                    const InputDecoration(labelText: 'Position / Job Title')),
            const SizedBox(height: 12),
            TextFormField(
                controller: _companyController,
                decoration: const InputDecoration(labelText: 'Company Name')),
            const SizedBox(height: 12),
            TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                maxLines: 3),
            const SizedBox(height: 16),
            ElevatedButton(
                onPressed: _addExperience, child: const Text('Add Experience')),
            if (experiences.isNotEmpty) const SizedBox(height: 16),
            ...experiences.map((exp) => _buildExperienceCard(exp)),
          ],
        ),
      ),
    );
  }

  Widget _buildExperienceCard(Experience exp) {
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
      ),
    );
  }
}
