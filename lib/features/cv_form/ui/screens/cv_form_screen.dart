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
        title: const Text('CV Pro'),
        centerTitle: true,
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            PersonalInfoSection(),
            Divider(height: 40),
            ExperienceSection(),
            Divider(height: 40),
            SkillSection(),
            Divider(height: 40),
            LanguageSection(),
            SizedBox(height: 80),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          // 1. اقرأ الخدمة
          final pdfService = ref.read(pdfServiceProvider);
          // 2. اقرأ البيانات
          final cvData = ref.read(cvFormProvider);

          // 3. استدعِ الخدمة (تم حذف متغير اللغة من هنا)
          final pdfBytes = await pdfService.generateCv(cvData);

          // 4. اعرض النتيجة
          await Printing.layoutPdf(onLayout: (format) => pdfBytes);
        },
        label: const Text('Create & Preview PDF'),
        icon: const Icon(Icons.picture_as_pdf),
      ),
    );
  }
}
