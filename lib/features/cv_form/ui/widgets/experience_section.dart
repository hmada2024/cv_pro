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
      // استخدام المنشئ الجديد .create
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
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Experience Added')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final experiences = ref.watch(cvFormProvider).experiences;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Work Experience',
            style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 10),
        TextFormField(
            controller: _positionController,
            decoration: const InputDecoration(labelText: 'Position')),
        const SizedBox(height: 10),
        TextFormField(
            controller: _companyController,
            decoration: const InputDecoration(labelText: 'Company Name')),
        const SizedBox(height: 10),
        TextFormField(
            controller: _descriptionController,
            decoration: const InputDecoration(labelText: 'Description'),
            maxLines: 3),
        const SizedBox(height: 10),
        SizedBox(
            width: double.infinity,
            child: ElevatedButton(
                onPressed: _addExperience,
                child: const Text('Add Experience'))),
        const SizedBox(height: 10),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: experiences.length,
          itemBuilder: (context, index) {
            final exp = experiences[index];
            return Card(
                margin: const EdgeInsets.only(top: 8),
                child: ListTile(
                    title: Text(exp.position),
                    subtitle: Text(exp.companyName)));
          },
        )
      ],
    );
  }
}
