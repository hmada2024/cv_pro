// features/cv_form/ui/screens/cv_form_screen.dart
import 'package:cv_pro/features/cv_form/data/models/cv_data.dart';
import 'package:cv_pro/features/cv_form/ui/screens/pdf_preview_screen.dart';
import 'package:cv_pro/features/cv_form/ui/screens/settings_screen.dart';
import 'package:cv_pro/features/cv_form/ui/widgets/cv_completion_progress.dart';
import 'package:cv_pro/features/pdf_export/data/providers/pdf_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cv_pro/features/cv_form/data/providers/cv_form_provider.dart';
import 'package:cv_pro/features/cv_form/ui/widgets/education_section.dart';
import 'package:cv_pro/features/cv_form/ui/widgets/experience_section.dart';
import 'package:cv_pro/features/cv_form/ui/widgets/language_section.dart';
import 'package:cv_pro/features/cv_form/ui/widgets/personal_info_section.dart';
import 'package:cv_pro/features/cv_form/ui/widgets/references_section.dart';
import 'package:cv_pro/features/cv_form/ui/widgets/skill_section.dart';
import '../widgets/driving_license_section.dart';

class CvFormScreen extends ConsumerWidget {
  const CvFormScreen({super.key});

  void _showAchievementSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Logic for showing motivational snackbars upon adding the first item to a section.
    ref.listen<List<Education>>(cvFormProvider.select((cv) => cv.education),
        (prev, next) {
      if ((prev?.isEmpty ?? true) && next.isNotEmpty) {
        _showAchievementSnackBar(
            context, 'Great! Your academic background is taking shape.');
      }
    });

    ref.listen<List<Experience>>(cvFormProvider.select((cv) => cv.experiences),
        (prev, next) {
      if ((prev?.isEmpty ?? true) && next.isNotEmpty) {
        _showAchievementSnackBar(context,
            'Excellent start! Experience is what employers look for first.');
      }
    });

    ref.listen<List<Skill>>(cvFormProvider.select((cv) => cv.skills),
        (prev, next) {
      if ((prev?.isEmpty ?? true) && next.isNotEmpty) {
        _showAchievementSnackBar(
            context, 'Nice one! Skills make your profile stand out.');
      }
    });

    ref.listen<List<Language>>(cvFormProvider.select((cv) => cv.languages),
        (prev, next) {
      if ((prev?.isEmpty ?? true) && next.isNotEmpty) {
        _showAchievementSnackBar(
            context, 'Perfect. Language skills open up more opportunities.');
      }
    });

    ref.listen<List<Reference>>(cvFormProvider.select((cv) => cv.references),
        (prev, next) {
      if ((prev?.isEmpty ?? true) && next.isNotEmpty) {
        _showAchievementSnackBar(
            context, 'Good choice. Strong references build trust.');
      }
    });

    final canCreate = ref
        .watch(cvFormProvider.select((cv) => cv.personalInfo.name.isNotEmpty));

    return Scaffold(
      appBar: AppBar(
        title: const Text('CV Pro Editor'),
        leading: IconButton(
          icon: const Icon(Icons.settings_outlined),
          tooltip: 'Settings',
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const SettingsScreen()),
            );
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.checklist_rtl,
              color: canCreate
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).disabledColor,
            ),
            iconSize: 28,
            tooltip: 'Create Final CV',
            onPressed: canCreate
                ? () {
                    ref.invalidate(pdfBytesProvider);
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => PdfPreviewScreen(
                          pdfProvider: pdfBytesProvider,
                        ),
                      ),
                    );
                  }
                : null,
          ),
          const SizedBox(width: 16),
        ],
        bottom: const CvCompletionProgress(),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            PersonalInfoSection(),
            SizedBox(height: 16),
            EducationSection(),
            SizedBox(height: 16),
            ExperienceSection(),
            SizedBox(height: 16),
            SkillSection(),
            SizedBox(height: 16),
            LanguageSection(),
            SizedBox(height: 16),
            DrivingLicenseSection(),
            SizedBox(height: 16),
            ReferencesSection(),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
