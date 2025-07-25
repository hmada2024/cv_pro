import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cv_pro/core/di/injector.dart';
import 'package:cv_pro/features/cv_form/data/providers/cv_form_provider.dart';
import 'package:cv_pro/features/cv_form/ui/widgets/education_section.dart';
import 'package:cv_pro/features/cv_form/ui/widgets/experience_section.dart';
import 'package:cv_pro/features/cv_form/ui/widgets/language_section.dart';
import 'package:cv_pro/features/cv_form/ui/widgets/personal_info_section.dart';
import 'package:cv_pro/features/cv_form/ui/widgets/skill_section.dart';
import 'package:cv_pro/features/pdf_export/data/services/pdf_service_impl.dart';
import 'package:printing/printing.dart';

class CvFormScreen extends ConsumerWidget {
  const CvFormScreen({super.key});

  // دالة لفتح نافذة اختيار القالب
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
                leading: const Icon(Icons.article),
                title: const Text('Classic'),
                onTap: () {
                  Navigator.of(context).pop();
                  _generatePdf(ref, CvTemplate.classic);
                },
              ),
              ListTile(
                leading: const Icon(Icons.dashboard),
                title: const Text('Modern'),
                onTap: () {
                  Navigator.of(context).pop();
                  _generatePdf(ref, CvTemplate.modern);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // دالة لتوليد الـ PDF
  Future<void> _generatePdf(WidgetRef ref, CvTemplate template) async {
    final pdfService = ref.read(pdfServiceProvider);
    final cvData = ref.read(cvFormProvider);

    final pdfBytes = await pdfService.generateCv(cvData, template);
    await Printing.layoutPdf(onLayout: (format) => pdfBytes);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CV Pro Editor'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: TextButton.icon(
              onPressed: () => _showTemplatePicker(context, ref),
              icon: const Icon(Icons.picture_as_pdf_outlined,
                  color: Colors.white),
              label: const Text('Generate PDF',
                  style: TextStyle(color: Colors.white)),
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
