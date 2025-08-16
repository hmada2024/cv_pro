// lib/features/settings/widgets/user_profile_section.dart
import 'dart:io';
import 'package:cv_pro/core/constants/app_sizes.dart';
import 'package:cv_pro/core/theme/app_colors.dart';
import 'package:cv_pro/core/widgets/english_only_text_field.dart';
import 'package:cv_pro/features/cv_form/data/models/cv_data.dart';
import 'package:cv_pro/features/cv_form/data/providers/cv_form_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserProfileSection extends ConsumerStatefulWidget {
  const UserProfileSection({super.key});

  @override
  ConsumerState<UserProfileSection> createState() => _UserProfileSectionState();
}

class _UserProfileSectionState extends ConsumerState<UserProfileSection> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final activeCv = ref.read(activeCvProvider);
    if (activeCv != null) {
      _syncControllers(activeCv.personalInfo);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _syncControllers(PersonalInfo info) {
    if (_nameController.text != info.name) _nameController.text = info.name;
    if (_emailController.text != info.email) _emailController.text = info.email;
    if (_phoneController.text != (info.phone ?? '')) {
      _phoneController.text = info.phone ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final activeCv = ref.watch(activeCvProvider);
    final notifier = ref.read(activeCvProvider.notifier);
    final theme = Theme.of(context);

    // Listen for changes in the active CV to keep controllers in sync
    ref.listen<CVData?>(activeCvProvider, (previous, next) {
      if (next != null && (previous?.personalInfo != next.personalInfo)) {
        _syncControllers(next.personalInfo);
      }
    });

    if (activeCv == null) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.p20),
          child: Text(
            'No active CV project loaded. Please create or load a project from the home screen.',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium,
          ),
        ),
      );
    }

    final personalInfo = activeCv.personalInfo;
    final hasImage = personalInfo.profileImagePath != null &&
        personalInfo.profileImagePath!.isNotEmpty;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.p20),
        child: Column(
          children: [
            Text(
              'Editing basic info for "${activeCv.projectName}"',
              style: theme.textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSizes.p16),
            CircleAvatar(
              radius: AppSizes.avatarRadius,
              backgroundColor: theme.dividerColor,
              backgroundImage: hasImage
                  ? FileImage(File(personalInfo.profileImagePath!))
                  : null,
              child: !hasImage
                  ? Icon(Icons.person_outline,
                      size: AppSizes.iconSizeLarge,
                      color: theme.colorScheme.secondary)
                  : null,
            ),
            const SizedBox(height: AppSizes.p8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.edit_outlined),
                    label: const Text('Change'),
                    onPressed: () {
                      notifier.pickProfileImage(
                        toolbarColor: theme.appBarTheme.backgroundColor!,
                        toolbarWidgetColor: theme.appBarTheme.foregroundColor!,
                        backgroundColor: theme.scaffoldBackgroundColor,
                        activeControlsWidgetColor: AppColors.accent,
                      );
                    },
                  ),
                ),
                const SizedBox(width: AppSizes.p8),
                Expanded(
                  child: FilledButton.tonalIcon(
                    icon: const Icon(Icons.delete_outline),
                    label: const Text('Remove'),
                    style: FilledButton.styleFrom(
                      backgroundColor: theme.colorScheme.errorContainer,
                      foregroundColor: theme.colorScheme.onErrorContainer,
                    ),
                    onPressed: hasImage ? notifier.removeProfileImage : null,
                  ),
                ),
              ],
            ),
            const Divider(height: AppSizes.p24),
            EnglishOnlyTextField(
              controller: _nameController,
              labelText: 'Full Name',
              onChanged: (value) => notifier.updatePersonalInfo(name: value),
            ),
            const SizedBox(height: AppSizes.p12),
            EnglishOnlyTextField(
              controller: _emailController,
              labelText: 'Email Address',
              onChanged: (value) => notifier.updatePersonalInfo(email: value),
            ),
            const SizedBox(height: AppSizes.p12),
            EnglishOnlyTextField(
              controller: _phoneController,
              labelText: 'Phone Number',
              onChanged: (value) => notifier.updatePersonalInfo(phone: value),
            ),
          ],
        ),
      ),
    );
  }
}
