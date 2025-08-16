// lib/features/settings/ui/widgets/user_profile_section.dart
import 'dart:io';
import 'package:cv_pro/core/constants/app_sizes.dart';
import 'package:cv_pro/core/theme/app_colors.dart';
import 'package:cv_pro/core/widgets/english_only_text_field.dart';
import 'package:cv_pro/features/cv_form/data/providers/cv_form_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserProfileSection extends ConsumerWidget {
  const UserProfileSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final personalInfo =
        ref.watch(cvFormProvider.select((s) => s.personalInfo));
    final notifier = ref.read(cvFormProvider.notifier);
    final theme = Theme.of(context);
    final hasImage = personalInfo.profileImagePath != null &&
        personalInfo.profileImagePath!.isNotEmpty;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.p20),
        child: Column(
          children: [
            Text(
              'Save your basic info here to auto-fill future CVs.',
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
                TextButton(
                  child: const Text('Change'),
                  onPressed: () {
                    notifier.pickProfileImage(
                      toolbarColor: theme.appBarTheme.backgroundColor!,
                      toolbarWidgetColor: theme.appBarTheme.foregroundColor!,
                      backgroundColor: theme.scaffoldBackgroundColor,
                      activeControlsWidgetColor: AppColors.accent,
                    );
                  },
                ),
                TextButton(
                  onPressed: hasImage ? notifier.removeProfileImage : null,
                  child: Text('Remove',
                      style: TextStyle(color: theme.colorScheme.error)),
                ),
              ],
            ),
            const Divider(height: AppSizes.p24),
            EnglishOnlyTextField(
              controller: TextEditingController(text: personalInfo.name),
              labelText: 'Full Name',
              onChanged: (value) => notifier.updatePersonalInfo(name: value),
            ),
            const SizedBox(height: AppSizes.p12),
            EnglishOnlyTextField(
              controller: TextEditingController(text: personalInfo.email),
              labelText: 'Email Address',
              onChanged: (value) => notifier.updatePersonalInfo(email: value),
            ),
            const SizedBox(height: AppSizes.p12),
            EnglishOnlyTextField(
              controller: TextEditingController(text: personalInfo.phone),
              labelText: 'Phone Number',
              onChanged: (value) => notifier.updatePersonalInfo(phone: value),
            ),
          ],
        ),
      ),
    );
  }
}
