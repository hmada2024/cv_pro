// lib/features/cv_form/ui/widgets/personal_info_section.dart
import 'dart:io';
import 'package:cv_pro/core/constants/app_sizes.dart';
import 'package:cv_pro/core/theme/app_colors.dart';
import 'package:cv_pro/features/cv_form/data/models/cv_constants.dart';
import 'package:cv_pro/features/cv_form/data/models/cv_data.dart';
import 'package:cv_pro/features/cv_form/ui/widgets/shared/form_date_picker_field.dart';
import 'package:cv_pro/features/cv_form/ui/widgets/shared/form_dropdown_field.dart';
import 'package:cv_pro/features/cv_form/ui/widgets/shared/form_text_field.dart';
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
    _syncControllers(ref.read(cvFormProvider).personalInfo);

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

  Future<void> _selectBirthDate() async {
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
    }
  }

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
    final theme = Theme.of(context);
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

    final hasImage = personalInfo.profileImagePath != null &&
        personalInfo.profileImagePath!.isNotEmpty;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.p20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.person, color: theme.colorScheme.secondary),
                const SizedBox(width: AppSizes.p8),
                Text('Personal Information', style: theme.textTheme.titleLarge),
              ],
            ),
            const SizedBox(height: AppSizes.p16),
            Center(
              child: GestureDetector(
                onTap: () => _pickImage(theme),
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: AppSizes.avatarRadius,
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
                                  size: AppSizes.iconSizeLarge - AppSizes.p8,
                                  color: theme.colorScheme.secondary,
                                ),
                                const SizedBox(height: AppSizes.p4),
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
                        radius: AppSizes.p12,
                        backgroundColor: theme.colorScheme.primary,
                        child: const Icon(Icons.edit,
                            color: Colors.white, size: AppSizes.iconSizeSmall),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppSizes.p16),
            FormTextField(
              controller: _nameController,
              label: 'Full Name',
              iconData: Icons.badge_outlined,
              focusNode: _nameFocus,
              onChanged: (value) => ref
                  .read(cvFormProvider.notifier)
                  .updatePersonalInfo(name: value),
            ),
            FormTextField(
              controller: _jobTitleController,
              label: 'Job Title',
              iconData: Icons.work_outline,
              focusNode: _jobTitleFocus,
              onChanged: (value) => ref
                  .read(cvFormProvider.notifier)
                  .updatePersonalInfo(jobTitle: value),
            ),
            FormDatePickerField(
              controller: _birthDateController,
              label: 'Date of Birth',
              icon: Icons.cake_outlined,
              onTap: _selectBirthDate,
            ),
            FormTextField(
              controller: _emailController,
              label: 'Email Address',
              iconData: Icons.email_outlined,
              focusNode: _emailFocus,
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) => ref
                  .read(cvFormProvider.notifier)
                  .updatePersonalInfo(email: value),
            ),
            FormTextField(
              controller: _phoneController,
              label: 'Phone Number',
              iconData: Icons.phone_outlined,
              focusNode: _phoneFocus,
              keyboardType: TextInputType.phone,
              onChanged: (value) => ref
                  .read(cvFormProvider.notifier)
                  .updatePersonalInfo(phone: value),
            ),
            FormTextField(
              controller: _addressController,
              label: 'Address',
              iconData: Icons.location_on_outlined,
              focusNode: _addressFocus,
              onChanged: (value) => ref
                  .read(cvFormProvider.notifier)
                  .updatePersonalInfo(address: value),
            ),
            FormDropdownField(
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
            FormDropdownField(
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
            FormTextField(
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
}
