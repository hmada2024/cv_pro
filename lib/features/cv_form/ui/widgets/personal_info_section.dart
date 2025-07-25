import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cv_pro/features/cv_form/data/providers/cv_form_provider.dart';
import 'package:image_picker/image_picker.dart';

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
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _summaryController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final cvData = ref.read(cvFormProvider);
    _nameController.text = cvData.personalInfo.name;
    _jobTitleController.text = cvData.personalInfo.jobTitle;
    _emailController.text = cvData.personalInfo.email;
    _phoneController.text = cvData.personalInfo.phone ?? '';
    _addressController.text = cvData.personalInfo.address ?? '';
    _summaryController.text = cvData.personalInfo.summary;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _jobTitleController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _summaryController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      ref
          .read(cvFormProvider.notifier)
          .updatePersonalInfo(profileImage: File(pickedFile.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    final profileImage = ref.watch(cvFormProvider).personalInfo.profileImage;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.person, color: Colors.blueGrey),
                const SizedBox(width: 8),
                Text('Personal Information',
                    style: Theme.of(context).textTheme.titleLarge),
              ],
            ),
            const SizedBox(height: 16),
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey.shade200,
                    backgroundImage:
                        profileImage != null ? FileImage(profileImage) : null,
                    child: profileImage == null
                        ? const Icon(Icons.camera_alt,
                            size: 40, color: Colors.grey)
                        : null,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: InkWell(
                      onTap: _pickImage,
                      child: const CircleAvatar(
                        radius: 18,
                        backgroundColor: Colors.blue,
                        child: Icon(Icons.edit, color: Colors.white, size: 20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            _buildTextField(
              controller: _nameController,
              label: 'Full Name',
              icon: Icons.badge_outlined,
              onChanged: (value) => ref
                  .read(cvFormProvider.notifier)
                  .updatePersonalInfo(name: value),
            ),
            _buildTextField(
              controller: _jobTitleController,
              label: 'Job Title',
              icon: Icons.work_outline,
              onChanged: (value) => ref
                  .read(cvFormProvider.notifier)
                  .updatePersonalInfo(jobTitle: value),
            ),
            _buildTextField(
              controller: _emailController,
              label: 'Email Address',
              icon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) => ref
                  .read(cvFormProvider.notifier)
                  .updatePersonalInfo(email: value),
            ),
            _buildTextField(
              controller: _phoneController,
              label: 'Phone Number',
              icon: Icons.phone_outlined,
              keyboardType: TextInputType.phone,
              onChanged: (value) => ref
                  .read(cvFormProvider.notifier)
                  .updatePersonalInfo(phone: value),
            ),
            _buildTextField(
              controller: _addressController,
              label: 'Address',
              icon: Icons.location_on_outlined,
              onChanged: (value) => ref
                  .read(cvFormProvider.notifier)
                  .updatePersonalInfo(address: value),
            ),
            _buildTextField(
              controller: _summaryController,
              label: 'Summary / About Me',
              icon: Icons.notes_outlined,
              maxLines: 4,
              onChanged: (value) => ref
                  .read(cvFormProvider.notifier)
                  .updatePersonalInfo(summary: value),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required ValueChanged<String> onChanged,
    TextInputType? keyboardType,
    int? maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
        ),
        keyboardType: keyboardType,
        maxLines: maxLines,
        onChanged: onChanged,
      ),
    );
  }
}
