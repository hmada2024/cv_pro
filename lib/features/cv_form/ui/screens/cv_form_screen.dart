import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cv_pro/core/theme/app_theme.dart';
import 'package:cv_pro/features/cv_form/data/providers/cv_form_provider.dart';
import 'package:cv_pro/features/cv_form/ui/widgets/education_section.dart';
import 'package:cv_pro/features/cv_form/ui/widgets/experience_section.dart';
import 'package:cv_pro/features/cv_form/ui/widgets/language_section.dart';
import 'package:cv_pro/features/cv_form/ui/widgets/personal_info_section.dart';
import 'package:cv_pro/features/cv_form/ui/widgets/skill_section.dart';
import 'package:cv_pro/features/pdf_export/data/services/pdf_service_impl.dart';

class CvFormScreen extends ConsumerWidget {
  const CvFormScreen({super.key});

  void _showTemplatePicker(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Choose a Template'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.dashboard_customize_outlined),
                title: const Text('Modern'),
                onTap: () {
                  Navigator.of(context).pop();
                  ref
                      .read(cvFormProvider.notifier)
                      .generateAndPreviewPdf(CvTemplate.modern);
                },
              ),
              ListTile(
                leading: const Icon(Icons.business_center_outlined),
                title: const Text('Corporate Blue'),
                onTap: () {
                  Navigator.of(context).pop();
                  ref
                      .read(cvFormProvider.notifier)
                      .generateAndPreviewPdf(CvTemplate.corporateBlue);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('CV Pro Editor'),
        actions: [
          IconButton(
            icon: Icon(
              isDarkMode ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
            ),
            onPressed: () {
              final currentMode = ref.read(themeModeProvider);
              // Simple toggle logic: if it's dark, switch to light, otherwise switch to dark.
              // We ignore 'system' for manual toggle and just switch between light/dark.
              if (currentMode == ThemeMode.dark) {
                ref.read(themeModeProvider.notifier).state = ThemeMode.light;
              } else {
                ref.read(themeModeProvider.notifier).state = ThemeMode.dark;
              }
            },
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: TextButton.icon(
              onPressed: () => _showTemplatePicker(context, ref),
              icon: const Icon(Icons.picture_as_pdf_outlined),
              label: const Text('Generate PDF'),
              style:
                  TextButton.styleFrom(splashFactory: NoSplash.splashFactory),
            ),
          ),
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
