// lib/features/settings/ui/screens/settings_screen.dart
import 'package:cv_pro/core/constants/app_sizes.dart';
import 'package:cv_pro/features/1_main_screens/settings/widgets/about_section.dart';
import 'package:cv_pro/features/1_main_screens/settings/widgets/appearance_section.dart';
import 'package:cv_pro/features/1_main_screens/settings/widgets/data_management_section.dart';
import 'package:cv_pro/features/1_main_screens/settings/widgets/section_title.dart';
import 'package:cv_pro/features/1_main_screens/settings/widgets/user_profile_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
            SectionTitle(title: 'Appearance'),
            SizedBox(height: AppSizes.p8),
            AppearanceSection(),
            SizedBox(height: AppSizes.p24),
            SectionTitle(title: 'User Profile'),
            SizedBox(height: AppSizes.p8),
            UserProfileSection(),
            SizedBox(height: AppSizes.p24),
            SectionTitle(title: 'About'),
            SizedBox(height: AppSizes.p8),
            AboutSection(),
            SizedBox(height: AppSizes.p24),
            SectionTitle(title: 'Data Management'),
            SizedBox(height: AppSizes.p8),
            DataManagementSection(),
          ],
        ),
      ),
    );
  }
}
