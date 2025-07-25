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
        title: const Text('محرر السيرة الذاتية'),
      ),
      body: const SingleChildScrollView(
        // استخدام padding لتوفير هوامش حول المحتوى
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            // استخدام SizedBox للتحكم في المسافات بين البطاقات بشكل موحد
            PersonalInfoSection(),
            SizedBox(height: 16),
            ExperienceSection(),
            SizedBox(height: 16),
            SkillSection(),
            SizedBox(height: 16),
            LanguageSection(),
            // مسافة إضافية في الأسفل لتجنب تغطية الزر العائم للمحتوى
            SizedBox(height: 80),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final pdfService = ref.read(pdfServiceProvider);
          final cvData = ref.read(cvFormProvider);
          final pdfBytes = await pdfService.generateCv(cvData);
          await Printing.layoutPdf(onLayout: (format) => pdfBytes);
        },
        label: const Text('معاينة PDF'),
        icon: const Icon(Icons.picture_as_pdf),
      ),
    );
  }
}
