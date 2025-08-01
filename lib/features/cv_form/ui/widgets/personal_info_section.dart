// features/cv_form/ui/widgets/personal_info_section.dart

import 'dart:io';
import 'package:cv_pro/core/theme/app_colors.dart';
import 'package:cv_pro/core/widgets/english_only_text_field.dart';
import 'package:cv_pro/features/cv_form/data/models/cv_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cv_pro/features/cv_form/data/providers/cv_form_provider.dart';
import 'package:intl/intl.dart';

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
  final _birthDateController = TextEditingController();
  final DateFormat _dateFormatter = DateFormat('d MMMM yyyy');

  final _nameFocus = FocusNode();
  final _jobTitleFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _phoneFocus = FocusNode();
  final _addressFocus = FocusNode();
  final _summaryFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    final cvData = ref.read(cvFormProvider);
    final personalInfo = cvData.personalInfo;

    _nameController.text = personalInfo.name;
    _jobTitleController.text = personalInfo.jobTitle;
    _emailController.text = personalInfo.email;
    _phoneController.text = personalInfo.phone ?? '';
    _addressController.text = personalInfo.address ?? '';
    _summaryController.text = personalInfo.summary;

    if (personalInfo.birthDate != null) {
      _birthDateController.text =
          _dateFormatter.format(personalInfo.birthDate!);
    }

    // Add listeners to rebuild on focus change
    _nameFocus.addListener(() => setState(() {}));
    _jobTitleFocus.addListener(() => setState(() {}));
    _emailFocus.addListener(() => setState(() {}));
    _phoneFocus.addListener(() => setState(() {}));
    _addressFocus.addListener(() => setState(() {}));
    _summaryFocus.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _nameController.dispose();
    _jobTitleController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _summaryController.dispose();
    _birthDateController.dispose();

    // Dispose focus nodes
    _nameFocus.dispose();
    _jobTitleFocus.dispose();
    _emailFocus.dispose();
    _phoneFocus.dispose();
    _addressFocus.dispose();
    _summaryFocus.dispose();

    super.dispose();
  }

  Future<void> _selectBirthDate(BuildContext context) async {
    final notifier = ref.read(cvFormProvider.notifier);
    final initialDate = ref.read(cvFormProvider).personalInfo.birthDate ??
        DateTime.now().subtract(const Duration(days: 365 * 25));

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != initialDate) {
      notifier.updatePersonalInfo(birthDate: picked);
      setState(() {
        _birthDateController.text = _dateFormatter.format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final personalInfo = ref.watch(cvFormProvider).personalInfo;
    final theme = Theme.of(context);

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
                Text('Personal Information', style: theme.textTheme.titleLarge),
              ],
            ),
            const SizedBox(height: 16),
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey.shade200,
                    backgroundImage: personalInfo.profileImagePath != null
                        ? FileImage(File(personalInfo.profileImagePath!))
                        : null,
                    child: personalInfo.profileImagePath == null
                        ? const Icon(Icons.camera_alt,
                            size: 40, color: Colors.grey)
                        : null,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: InkWell(
                      onTap: () {
                        ref.read(cvFormProvider.notifier).pickProfileImage(
                              toolbarColor: theme.appBarTheme.backgroundColor!,
                              toolbarWidgetColor:
                                  theme.appBarTheme.foregroundColor!,
                              backgroundColor: theme.scaffoldBackgroundColor,
                              activeControlsWidgetColor: AppColors.accent,
                            );
                      },
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
              iconData: Icons.badge_outlined,
              focusNode: _nameFocus,
              onChanged: (value) => ref
                  .read(cvFormProvider.notifier)
                  .updatePersonalInfo(name: value),
            ),
            _buildTextField(
              controller: _jobTitleController,
              label: 'Job Title',
              iconData: Icons.work_outline,
              focusNode: _jobTitleFocus,
              onChanged: (value) => ref
                  .read(cvFormProvider.notifier)
                  .updatePersonalInfo(jobTitle: value),
            ),
            _buildDatePickerField(
              controller: _birthDateController,
              label: 'Date of Birth',
              icon: Icons.cake_outlined,
              onTap: () => _selectBirthDate(context),
            ),
            _buildTextField(
              controller: _emailController,
              label: 'Email Address',
              iconData: Icons.email_outlined,
              focusNode: _emailFocus,
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) => ref
                  .read(cvFormProvider.notifier)
                  .updatePersonalInfo(email: value),
            ),
            _buildTextField(
              controller: _phoneController,
              label: 'Phone Number',
              iconData: Icons.phone_outlined,
              focusNode: _phoneFocus,
              keyboardType: TextInputType.phone,
              onChanged: (value) => ref
                  .read(cvFormProvider.notifier)
                  .updatePersonalInfo(phone: value),
            ),
            _buildTextField(
              controller: _addressController,
              label: 'Address',
              iconData: Icons.location_on_outlined,
              focusNode: _addressFocus,
              onChanged: (value) => ref
                  .read(cvFormProvider.notifier)
                  .updatePersonalInfo(address: value),
            ),
            _buildDropdownField(
              label: 'Marital Status',
              icon: Icons.assignment_ind_outlined,
              value: personalInfo.maritalStatus,
              items: kMaritalStatusOptions,
              onChanged: (value) {
                ref
                    .read(cvFormProvider.notifier)
                    .updatePersonalInfo(maritalStatus: value);
              },
            ),
            _buildDropdownField(
              label: 'Military Service',
              icon: Icons.shield_outlined,
              value: personalInfo.militaryServiceStatus,
              items: kMilitaryServiceOptions,
              onChanged: (value) {
                ref
                    .read(cvFormProvider.notifier)
                    .updatePersonalInfo(militaryServiceStatus: value);
              },
            ),
            _buildTextField(
              controller: _summaryController,
              label: 'Summary / About Me',
              iconData: Icons.notes_outlined,
              focusNode: _summaryFocus,
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

  // ✅✅ UPDATED: Method now accepts FocusNode and IconData for better UX ✅✅
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData iconData,
    required FocusNode focusNode,
    required ValueChanged<String> onChanged,
    TextInputType? keyboardType,
    int maxLines = 1,
  }) {
    final theme = Theme.of(context);
    final bool isFocused = focusNode.hasFocus;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: EnglishOnlyTextField(
        controller: controller,
        focusNode: focusNode,
        labelText: label,
        prefixIcon: Icon(
          iconData,
          // Change color based on focus state
          color: isFocused ? theme.colorScheme.primary : Colors.grey,
        ),
        keyboardType: keyboardType,
        maxLines: maxLines,
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildDropdownField({
    required String label,
    required IconData icon,
    required String? value,
    required List<String> items,
    required void Function(String?) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: DropdownButtonFormField<String>(
        value: value,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Colors.grey),
        ),
        items: items.map<DropdownMenuItem<String>>((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: onChanged,
        isExpanded: true,
      ),
    );
  }

  Widget _buildDatePickerField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Colors.grey),
        ),
        readOnly: true,
        onTap: onTap,
      ),
    );
  }
}
