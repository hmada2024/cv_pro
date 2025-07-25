import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cv_pro/features/cv_form/data/providers/cv_form_provider.dart';

class PersonalInfoSection extends ConsumerStatefulWidget {
  const PersonalInfoSection({super.key});

  @override
  ConsumerState<PersonalInfoSection> createState() =>
      _PersonalInfoSectionState();
}

class _PersonalInfoSectionState extends ConsumerState<PersonalInfoSection> {
  final _nameController = TextEditingController();
  final _jobTitleController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final cvData = ref.read(cvFormProvider);
    _nameController.text = cvData.personalInfo.name;
    _jobTitleController.text = cvData.personalInfo.jobTitle;
    _emailController.text = cvData.personalInfo.email;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _jobTitleController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Personal Information',
            style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 10),
        TextFormField(
          controller: _nameController,
          decoration: const InputDecoration(labelText: 'Full Name'),
          onChanged: (value) {
            ref.read(cvFormProvider.notifier).updatePersonalInfo(name: value);
          },
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: _jobTitleController,
          decoration: const InputDecoration(labelText: 'Job Title'),
          onChanged: (value) {
            ref
                .read(cvFormProvider.notifier)
                .updatePersonalInfo(jobTitle: value);
          },
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: _emailController,
          decoration: const InputDecoration(labelText: 'Email Address'),
          keyboardType: TextInputType.emailAddress,
          onChanged: (value) {
            ref.read(cvFormProvider.notifier).updatePersonalInfo(email: value);
          },
        ),
      ],
    );
  }
}
