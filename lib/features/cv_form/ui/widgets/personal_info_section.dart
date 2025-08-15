// features/cv_form/ui/widgets/personal_info_section.dart
import 'dart:io';
import 'package:cv_pro/core/theme/app_colors.dart';
import 'package:cv_pro/core/widgets/english_only_text_field.dart';
import 'package:cv_pro/features/cv_form/data/models/cv_constants.dart';
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
  // Controllers manage the text field's state locally for performance.
  final _nameController = TextEditingController();
  final _jobTitleController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _summaryController = TextEditingController();
  final _birthDateController = TextEditingController();

  final DateFormat _dateFormatter = DateFormat('d MMMM yyyy');

  // Focus nodes to enhance UI feedback.
  final _nameFocus = FocusNode();
  final _jobTitleFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _phoneFocus = FocusNode();
  final _addressFocus = FocusNode();
  final _summaryFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    // Initialize controllers with the current state from the provider.
    _syncControllers(ref.read(cvFormProvider).personalInfo);

    // Add listeners to rebuild for focus-based UI changes (e.g., icon color).
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
    _nameFocus.dispose();
    _jobTitleFocus.dispose();
    _emailFocus.dispose();
    _phoneFocus.dispose();
    _addressFocus.dispose();
    _summaryFocus.dispose();
    super.dispose();
  }

  void _syncControllers(PersonalInfo info) {
    if (_nameController.text != info.name) _nameController.text = info.name;
    if (_jobTitleController.text != info.jobTitle) {
      _jobTitleController.text = info.jobTitle;
    }
    if (_emailController.text != info.email) _emailController.text = info.email;
    if (_phoneController.text != (info.phone ?? '')) {
      _phoneController.text = info.phone ?? '';
    }
    if (_addressController.text != (info.address ?? '')) {
      _addressController.text = info.address ?? '';
    }
    if (_summaryController.text != info.summary) {
      _summaryController.text = info.summary;
    }
    final formattedDate =
        info.birthDate != null ? _dateFormatter.format(info.birthDate!) : '';
    if (_birthDateController.text != formattedDate) {
      _birthDateController.text = formattedDate;
    }
  }

  Future<void> _selectBirthDate(BuildContext context) async {
    // ✅ CORRECT: Use `ref.read` inside a callback.
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
      // The `ref.listen` below will handle updating the controller text.
    }
  }

  // ✅ NEW: Encapsulated image picker action for reusability.
  void _pickImage(ThemeData theme) {
    ref.read(cvFormProvider.notifier).pickProfileImage(
          toolbarColor: theme.appBarTheme.backgroundColor!,
          toolbarWidgetColor: theme.appBarTheme.foregroundColor!,
          backgroundColor: theme.scaffoldBackgroundColor,
          activeControlsWidgetColor: AppColors.accent,
        );
  }

  @override
  Widget build(BuildContext context) {
    final personalInfo =
        ref.watch(cvFormProvider.select((s) => s.personalInfo));

    ref.listen<PersonalInfo>(
      cvFormProvider.select((s) => s.personalInfo),
      (previous, next) {
        if (previous != next) {
          _syncControllers(next);
        }
      },
    );

    final theme = Theme.of(context);
    final hasImage = personalInfo.profileImagePath != null &&
        personalInfo.profileImagePath!.isNotEmpty;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.person, color: theme.colorScheme.secondary),
                const SizedBox(width: 8),
                Text('Personal Information', style: theme.textTheme.titleLarge),
              ],
            ),
            const SizedBox(height: 16),
            Center(
              child: GestureDetector(
                onTap: () => _pickImage(theme),
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: theme.dividerColor.withOpacity(0.5),
                      backgroundImage: hasImage
                          ? FileImage(File(personalInfo.profileImagePath!))
                          : null,
                      child: !hasImage
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add_a_photo_outlined,
                                  size: 32,
                                  color: theme.colorScheme.secondary,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Add Photo',
                                  style: theme.textTheme.bodySmall,
                                )
                              ],
                            )
                          : null,
                    ),
                    Positioned(
                      bottom: 2,
                      right: 2,
                      child: CircleAvatar(
                        radius: 12,
                        backgroundColor: theme.colorScheme.primary,
                        child: const Icon(Icons.edit,
                            color: Colors.white, size: 18),
                      ),
                    ),
                  ],
                ),
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
          color: isFocused
              ? theme.colorScheme.primary
              : theme.colorScheme.onSurface.withOpacity(0.6),
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
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: DropdownButtonFormField<String>(
        value: value,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon:
              Icon(icon, color: theme.colorScheme.onSurface.withOpacity(0.6)),
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
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon:
              Icon(icon, color: theme.colorScheme.onSurface.withOpacity(0.6)),
        ),
        readOnly: true,
        onTap: onTap,
      ),
    );
  }
}
