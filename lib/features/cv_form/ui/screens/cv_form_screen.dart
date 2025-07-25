import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cv_pro/core/di/injector.dart';
import 'package:cv_pro/features/cv_form/data/providers/cv_form_provider.dart';
import 'package:cv_pro/features/cv_form/ui/widgets/experience_section.dart';
import 'package:cv_pro/features/cv_form/ui/widgets/language_section.dart';
import 'package:cv_pro/features/cv_form/ui/widgets/personal_info_section.dart';
import 'package:cv_pro/features/cv_form/ui/widgets/skill_section.dart';
import 'package:printing/printing.dart';

class CvFormScreen extends ConsumerWidget {
  const CvFormScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CV Pro Editor'),
        actions: [
          // ✅✅ الزر الجديد في الـ AppBar ✅✅
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: TextButton.icon(
              onPressed: () async {
                final pdfService = ref.read(pdfServiceProvider);
                final cvData = ref.read(cvFormProvider);
                final pdfBytes = await pdfService.generateCv(cvData);
                await Printing.layoutPdf(onLayout: (format) => pdfBytes);
              },
              icon: const Icon(Icons.picture_as_pdf_outlined,
                  color: Colors.white),
              label: const Text(
                'Generate PDF',
                style: TextStyle(color: Colors.white),
              ),
              style: TextButton.styleFrom(
                splashFactory: NoSplash.splashFactory,
              ),
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
            SkillSection(),
            SizedBox(height: 16),
            LanguageSection(),
            // مسافة في الأسفل لراحة العين
            SizedBox(height: 20),
          ],
        ),
      ),
      // تم حذف الـ FloatingActionButton من هنا بالكامل
    );
  }
}
