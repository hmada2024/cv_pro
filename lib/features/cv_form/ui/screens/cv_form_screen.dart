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
    final selectedLanguage = ref.watch(languageProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('CV Pro - أنشئ سيرتك'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // --- Language Selection ---
            Text('لغة السيرة الذاتية',
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            SegmentedButton<AppLanguage>(
              segments: const [
                ButtonSegment<AppLanguage>(
                    value: AppLanguage.arabic, label: Text('العربية')),
                ButtonSegment<AppLanguage>(
                    value: AppLanguage.english, label: Text('English')),
              ],
              selected: {selectedLanguage},
              onSelectionChanged: (newSelection) {
                ref.read(languageProvider.notifier).state = newSelection.first;
              },
            ),
            const Divider(height: 40),

            // --- Form Sections (Now in separate widgets) ---
            const PersonalInfoSection(),
            const Divider(height: 40),
            const ExperienceSection(),
            const Divider(height: 40),
            const SkillSection(),
            const Divider(height: 40),
            const LanguageSection(),
            const SizedBox(height: 80),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          // 1. اقرأ الخدمة من الـ injector
          final pdfService = ref.read(pdfServiceProvider);

          // 2. اقرأ البيانات الحالية
          final cvData = ref.read(cvFormProvider);
          final lang = ref.read(languageProvider);

          // 3. استدعِ الخدمة (الواجهة لا تعرف كيف يتم توليد الـ PDF)
          final pdfBytes = await pdfService.generateCv(cvData, lang);

          // 4. اعرض النتيجة
          await Printing.layoutPdf(onLayout: (format) => pdfBytes);
        },
        label: const Text('إنشاء و معاينة PDF'),
        icon: const Icon(Icons.picture_as_pdf),
      ),
    );
  }
}
