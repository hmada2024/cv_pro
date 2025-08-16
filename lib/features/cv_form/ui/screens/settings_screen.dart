// features/cv_form/ui/screens/settings_screen.dart
import 'dart:io';
import 'package:cv_pro/core/constants/app_sizes.dart';
import 'package:cv_pro/core/theme/app_colors.dart';
import 'package:cv_pro/core/widgets/english_only_text_field.dart';
import 'package:cv_pro/features/cv_form/data/providers/cv_form_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cv_pro/core/theme/app_theme.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(AppSizes.p16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _SectionTitle(title: 'Appearance'),
            SizedBox(height: AppSizes.p8),
            _AppearanceSection(),
            SizedBox(height: AppSizes.p24),
            _SectionTitle(title: 'User Profile'),
            SizedBox(height: AppSizes.p8),
            _UserProfileSection(),
            SizedBox(height: AppSizes.p24),
            _SectionTitle(title: 'About'),
            SizedBox(height: AppSizes.p8),
            _AboutSection(),
            SizedBox(height: AppSizes.p24),
            _SectionTitle(title: 'Data Management'),
            SizedBox(height: AppSizes.p8),
            _DataManagementSection(),
          ],
        ),
      ),
    );
  }
}

// --- Internal Widgets for better code organization ---

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(title, style: Theme.of(context).textTheme.titleLarge);
  }
}

class _AppearanceSection extends ConsumerWidget {
  const _AppearanceSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentThemeMode = ref.watch(themeModeProvider);
    final theme = Theme.of(context);

    return Card(
      child: Column(
        children: [
          RadioListTile<ThemeMode>(
            title: const Text('Light'),
            subtitle: Text('Classic, bright interface.',
                style: theme.textTheme.bodySmall),
            value: ThemeMode.light,
            groupValue: currentThemeMode,
            onChanged: (value) =>
                ref.read(themeModeProvider.notifier).state = value!,
          ),
          RadioListTile<ThemeMode>(
            title: const Text('Dark'),
            subtitle: Text('Easy on the eyes in low light.',
                style: theme.textTheme.bodySmall),
            value: ThemeMode.dark,
            groupValue: currentThemeMode,
            onChanged: (value) =>
                ref.read(themeModeProvider.notifier).state = value!,
          ),
          RadioListTile<ThemeMode>(
            title: const Text('System Default'),
            subtitle: Text('Matches your device settings.',
                style: theme.textTheme.bodySmall),
            value: ThemeMode.system,
            groupValue: currentThemeMode,
            onChanged: (value) =>
                ref.read(themeModeProvider.notifier).state = value!,
          ),
        ],
      ),
    );
  }
}

class _UserProfileSection extends ConsumerWidget {
  const _UserProfileSection();

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

class _AboutSection extends StatelessWidget {
  const _AboutSection();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('App Version'),
            subtitle: const Text('1.0.0'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.privacy_tip_outlined),
            title: const Text('Privacy Policy'),
            onTap: () {
              // TODO: Implement URL launcher for privacy policy link
            },
          ),
        ],
      ),
    );
  }
}

class _DataManagementSection extends ConsumerWidget {
  const _DataManagementSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return Card(
      child: ListTile(
        leading:
            Icon(Icons.delete_forever_outlined, color: theme.colorScheme.error),
        title: Text('Clear All Data',
            style: TextStyle(color: theme.colorScheme.error)),
        onTap: () async {
          final confirm = await showDialog<bool>(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Are you sure?'),
              content: const Text(
                  'This will permanently delete all your CV and user profile data. This action cannot be undone.'),
              actions: [
                TextButton(
                  child: const Text('Cancel'),
                  onPressed: () => Navigator.of(context).pop(false),
                ),
                FilledButton(
                  style: FilledButton.styleFrom(
                      backgroundColor: theme.colorScheme.error),
                  child: const Text('Delete'),
                  onPressed: () => Navigator.of(context).pop(true),
                ),
              ],
            ),
          );

          if (confirm ?? false) {
            await ref.read(cvFormProvider.notifier).clearAllData();
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('All data has been cleared.')),
              );
            }
          }
        },
      ),
    );
  }
}
