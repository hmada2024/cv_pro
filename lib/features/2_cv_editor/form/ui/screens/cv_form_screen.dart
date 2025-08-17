// lib/features/2_cv_editor/form/ui/screens/cv_form_screen.dart
import 'package:cv_pro/core/constants/app_sizes.dart';
import 'package:cv_pro/features/2_cv_editor/form/ui/screens/pdf_preview_screen.dart';
import 'package:cv_pro/features/2_cv_editor/form/ui/widgets/project_status_header.dart';
import 'package:cv_pro/features/3_cv_presentation/pdf_generation/data/providers/pdf_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cv_pro/features/2_cv_editor/form/data/providers/cv_form_provider.dart';
import 'package:cv_pro/features/2_cv_editor/form/ui/widgets/education_section.dart';
import 'package:cv_pro/features/2_cv_editor/form/ui/widgets/experience_section.dart';
import 'package:cv_pro/features/2_cv_editor/form/ui/widgets/language_section.dart';
import 'package:cv_pro/features/2_cv_editor/form/ui/widgets/personal_info_section.dart';
import 'package:cv_pro/features/2_cv_editor/form/ui/widgets/references_section.dart';
import 'package:cv_pro/features/2_cv_editor/form/ui/widgets/skill_section.dart';
import '../widgets/driving_license_section.dart';

class CvFormScreen extends ConsumerWidget {
  const CvFormScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeCv = ref.watch(activeCvProvider);

    if (activeCv == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('CV Editor')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48),
              const SizedBox(height: AppSizes.p16),
              const Text('No active CV project is loaded.'),
              const SizedBox(height: AppSizes.p16),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Go Back'),
              )
            ],
          ),
        ),
      );
    }

    final isCvReadyForPreview = activeCv.personalInfo.name.isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        title: const Text('CV Editor'),
        actions: [
          TextButton.icon(
            icon: Icon(
              Icons.visibility_outlined,
              color: isCvReadyForPreview
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).disabledColor,
            ),
            label: Text(
              'Preview',
              style: TextStyle(
                color: isCvReadyForPreview
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).disabledColor,
              ),
            ),
            onPressed: isCvReadyForPreview
                ? () {
                    ref.invalidate(pdfBytesProvider);
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => PdfPreviewScreen(
                          pdfProvider: pdfBytesProvider,
                          projectName: activeCv.projectName,
                          isDummyPreview: false,
                        ),
                      ),
                    );
                  }
                : null,
          ),
          const SizedBox(width: AppSizes.p8),
        ],
        bottom: const ProjectStatusHeader(),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(AppSizes.p16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PersonalInfoSection(),
            SizedBox(height: AppSizes.p16),
            EducationSection(),
            SizedBox(height: AppSizes.p16),
            ExperienceSection(),
            SizedBox(height: AppSizes.p16),
            SkillSection(),
            SizedBox(height: AppSizes.p16),
            LanguageSection(),
            SizedBox(height: AppSizes.p16),
            DrivingLicenseSection(),
            SizedBox(height: AppSizes.p16),
            ReferencesSection(),
            SizedBox(height: AppSizes.p24),
          ],
        ),
      ),
    );
  }
}
