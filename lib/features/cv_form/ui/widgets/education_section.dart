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

  void _addEducation() {
    if (_schoolController.text.isNotEmpty &&
        _degreeController.text.isNotEmpty) {
      final newEducation = Education.create(
        school: _schoolController.text,
        degree: _degreeController.text,
        startDate: DateTime.now().subtract(const Duration(days: 365 * 4)),
        endDate: DateTime.now().subtract(const Duration(days: 365)),
      );
      ref.read(cvFormProvider.notifier).addEducation(newEducation);
      _schoolController.clear();
      _degreeController.clear();
    }
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
            TextFormField(
                controller: _degreeController,
                decoration: const InputDecoration(
                    labelText: 'Degree (e.g., Bachelor of Science)')),
            const SizedBox(height: 12),
            TextFormField(
                controller: _schoolController,
                decoration:
                    const InputDecoration(labelText: 'School / University')),
            const SizedBox(height: 16),
            ElevatedButton(
                onPressed: _addEducation, child: const Text('Add Education')),
            if (educationList.isNotEmpty) const SizedBox(height: 16),
            ...educationList.map((edu) => _buildEducationCard(edu)),
          ],
        ),
      ),
    );
  }

  Widget _buildEducationCard(Education edu) {
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
      ),
    );
  }
}
