import 'package:cv_pro/features/cv_form/ui/screens/pdf_preview_screen.dart';
import 'package:cv_pro/features/cv_form/ui/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cv_pro/core/theme/app_theme.dart';
import 'package:cv_pro/features/cv_form/ui/widgets/education_section.dart';
import 'package:cv_pro/features/cv_form/ui/widgets/experience_section.dart';
import 'package:cv_pro/features/cv_form/ui/widgets/language_section.dart';
import 'package:cv_pro/features/cv_form/ui/widgets/personal_info_section.dart';
import 'package:cv_pro/features/cv_form/ui/widgets/skill_section.dart';
import 'package:cv_pro/features/pdf_export/data/services/pdf_service_impl.dart';

class CvFormScreen extends ConsumerWidget {
  const CvFormScreen({super.key});

  // ✅ DELETED: The _showTemplatePicker dialog is no longer needed.

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('CV Pro Editor'),
        actions: [
          // ✅ NEW: Settings Button
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            tooltip: 'Settings',
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              );
            },
          ),
          IconButton(
            icon: Icon(
              isDarkMode ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
            ),
            tooltip: 'Toggle Theme',
            onPressed: () {
              final currentMode = ref.read(themeModeProvider);
              if (currentMode == ThemeMode.dark) {
                ref.read(themeModeProvider.notifier).state = ThemeMode.light;
              } else {
                ref.read(themeModeProvider.notifier).state = ThemeMode.dark;
              }
            },
          ),
          // ✅ UPDATED: This button now navigates to the new preview screen
          IconButton(
            icon: const Icon(Icons.preview_outlined), // Changed icon
            tooltip: 'Preview CV',
            onPressed: () {
              // Read the currently selected template from settings
              final selectedTemplate = ref.read(selectedTemplateProvider);
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) =>
                      PdfPreviewScreen(template: selectedTemplate),
                ),
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            PersonalInfoSection(),
            SizedBox(height: 16),
            ExperienceSection(),
            SizedBox(height: 16),
            EducationSection(),
            SizedBox(height: 16),
            SkillSection(),
            SizedBox(height: 16),
            LanguageSection(),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
