import 'package:cv_pro/features/cv_form/ui/screens/pdf_preview_screen.dart';
import 'package:cv_pro/features/cv_form/ui/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cv_pro/features/cv_form/data/providers/cv_form_provider.dart';
import 'package:cv_pro/features/cv_form/ui/widgets/education_section.dart';
import 'package:cv_pro/features/cv_form/ui/widgets/experience_section.dart';
import 'package:cv_pro/features/cv_form/ui/widgets/language_section.dart';
import 'package:cv_pro/features/cv_form/ui/widgets/personal_info_section.dart';
import 'package:cv_pro/features/cv_form/ui/widgets/skill_section.dart';
import 'package:cv_pro/features/pdf_export/data/services/pdf_service_impl.dart';


class CvFormScreen extends ConsumerWidget {
  const CvFormScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cvData = ref.watch(cvFormProvider);
    final canCreate = cvData.personalInfo.name.isNotEmpty;

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
          // ✅ UPDATED: Create button with a new icon
          IconButton(
            icon: Icon(
              Icons.checklist_rtl,
              color: canCreate
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).disabledColor,
            ),
            iconSize: 28, // Make it slightly larger
            tooltip: 'Create Final CV',
            onPressed: canCreate
                ? () {
                    final selectedTemplate = ref.read(selectedTemplateProvider);
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => PdfPreviewScreen(
                          pdfProvider: pdfBytesProvider(selectedTemplate),
                        ),
                      ),
                    );
                  }
                : null,
          ),
          const SizedBox(width: 16),
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
