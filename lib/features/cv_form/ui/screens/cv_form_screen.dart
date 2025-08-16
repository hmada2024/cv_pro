// lib/features/cv_form/ui/screens/cv_form_screen.dart
import 'package:cv_pro/core/constants/app_sizes.dart';
import 'package:cv_pro/features/cv_form/data/models/cv_data.dart';
import 'package:cv_pro/features/cv_form/ui/screens/pdf_preview_screen.dart';
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
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.buttonRadius)),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

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

    return Scaffold(
      appBar: AppBar(
        title: const Text('CV Editor'),
        actions: [
          TextButton.icon(
            icon: Icon(
              Icons.preview_outlined,
              color: ref.watch(cvFormProvider
                      .select((cv) => cv.personalInfo.name.isNotEmpty))
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).disabledColor,
            ),
            label: Text(
              'Preview',
              style: TextStyle(
                color: ref.watch(cvFormProvider
                        .select((cv) => cv.personalInfo.name.isNotEmpty))
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).disabledColor,
              ),
            ),
            onPressed: ref.watch(cvFormProvider
                    .select((cv) => cv.personalInfo.name.isNotEmpty))
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
          const SizedBox(width: AppSizes.p8),
        ],
        bottom: const CvCompletionProgress(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSizes.p16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const PersonalInfoSection(),
            const SizedBox(height: AppSizes.p16),
            Padding(
              padding: const EdgeInsets.only(
                  left: AppSizes.p8, bottom: AppSizes.p12),
              child: Text(
                'CAREER & HISTORY',
                style: theme.textTheme.titleSmall?.copyWith(
                    color: theme.colorScheme.secondary,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const EducationSection(),
            const SizedBox(height: AppSizes.p16),
            const ExperienceSection(),
            const SizedBox(height: AppSizes.p16),
            Padding(
              padding: const EdgeInsets.only(
                  left: AppSizes.p8, bottom: AppSizes.p12),
              child: Text(
                'ABILITIES & COMPETENCIES',
                style: theme.textTheme.titleSmall?.copyWith(
                    color: theme.colorScheme.secondary,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SkillSection(),
            const SizedBox(height: AppSizes.p16),
            const LanguageSection(),
            const SizedBox(height: AppSizes.p16),
            const DrivingLicenseSection(),
            const SizedBox(height: AppSizes.p16),
            const ReferencesSection(),
            const SizedBox(height: AppSizes.p24),
          ],
        ),
      ),
    );
  }
}
