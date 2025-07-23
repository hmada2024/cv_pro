import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cv_pro/features/cv_creation/providers/cv_data_provider.dart';
import 'package:cv_pro/features/pdf_generation/pdf_generator.dart';
import 'package:printing/printing.dart';
import 'package:cv_pro/features/cv_creation/models/cv_data.dart';

class CvFormScreen extends ConsumerWidget {
  CvFormScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  // متحكمات الخبرة
  final _companyController = TextEditingController();
  final _positionController = TextEditingController();
  final _descriptionController = TextEditingController();

  // متحكمات المهارات
  final _skillController = TextEditingController();

  // متحكمات اللغات
  final _languageController = TextEditingController();
  final _proficiencyController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cvData = ref.watch(cvDataProvider);
    final selectedLanguage = ref.watch(languageProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('CV Pro - أنشئ سيرتك'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ... قسم اللغة والمعلومات الشخصية (لا تغيير هنا) ...
              Text('لغة السيرة الذاتية',
                  style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              SegmentedButton<AppLanguage>(
                segments: const <ButtonSegment<AppLanguage>>[
                  ButtonSegment<AppLanguage>(
                      value: AppLanguage.arabic,
                      label: Text('العربية'),
                      icon: Icon(Icons.language)),
                  ButtonSegment<AppLanguage>(
                      value: AppLanguage.english,
                      label: Text('English'),
                      icon: Icon(Icons.translate)),
                ],
                selected: {selectedLanguage},
                onSelectionChanged: (Set<AppLanguage> newSelection) {
                  ref.read(languageProvider.notifier).state =
                      newSelection.first;
                },
              ),
              const Divider(height: 40),
              Text('المعلومات الشخصية',
                  style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 10),
              TextFormField(
                  decoration: const InputDecoration(
                      labelText: 'الاسم الكامل', border: OutlineInputBorder()),
                  onChanged: (value) => ref
                      .read(cvDataProvider.notifier)
                      .updatePersonalInfo(name: value)),
              const SizedBox(height: 10),
              TextFormField(
                  decoration: const InputDecoration(
                      labelText: 'المسمى الوظيفي',
                      border: OutlineInputBorder()),
                  onChanged: (value) => ref
                      .read(cvDataProvider.notifier)
                      .updatePersonalInfo(jobTitle: value)),
              const SizedBox(height: 10),
              TextFormField(
                  decoration: const InputDecoration(
                      labelText: 'البريد الإلكتروني',
                      border: OutlineInputBorder()),
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) => ref
                      .read(cvDataProvider.notifier)
                      .updatePersonalInfo(email: value)),

              // ... قسم الخبرة (لا تغيير هنا) ...
              const Divider(height: 40),
              Text('إضافة خبرة عملية',
                  style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 10),
              TextFormField(
                  controller: _companyController,
                  decoration: const InputDecoration(
                      labelText: 'اسم الشركة', border: OutlineInputBorder())),
              const SizedBox(height: 10),
              TextFormField(
                  controller: _positionController,
                  decoration: const InputDecoration(
                      labelText: 'المنصب', border: OutlineInputBorder())),
              const SizedBox(height: 10),
              TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                      labelText: 'الوصف', border: OutlineInputBorder()),
                  maxLines: 3),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  final newExperience = Experience(
                      companyName: _companyController.text,
                      position: _positionController.text,
                      description: _descriptionController.text,
                      startDate:
                          DateTime.now().subtract(const Duration(days: 365)),
                      endDate: DateTime.now());
                  ref
                      .read(cvDataProvider.notifier)
                      .addExperience(newExperience);
                  _companyController.clear();
                  _positionController.clear();
                  _descriptionController.clear();
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('تمت إضافة الخبرة بنجاح!')));
                },
                child: const Text('إضافة خبرة'),
              ),

              // =================== قسم المهارات الجديد ===================
              const Divider(height: 40),
              Text('إضافة مهارة',
                  style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                      child: TextFormField(
                          controller: _skillController,
                          decoration: const InputDecoration(
                              labelText: 'اسم المهارة (مثل: Flutter)',
                              border: OutlineInputBorder()))),
                  const SizedBox(width: 8),
                  IconButton.filled(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      if (_skillController.text.isNotEmpty) {
                        ref
                            .read(cvDataProvider.notifier)
                            .addSkill(Skill(name: _skillController.text));
                        _skillController.clear();
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 10),
              // عرض المهارات المضافة
              Wrap(
                spacing: 8.0,
                runSpacing: 4.0,
                children: cvData.skills
                    .map((skill) => Chip(label: Text(skill.name)))
                    .toList(),
              ),

              // =================== قسم اللغات الجديد ===================
              const Divider(height: 40),
              Text('إضافة لغة',
                  style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 10),
              TextFormField(
                  controller: _languageController,
                  decoration: const InputDecoration(
                      labelText: 'اللغة (مثل: الإنجليزية)',
                      border: OutlineInputBorder())),
              const SizedBox(height: 10),
              TextFormField(
                  controller: _proficiencyController,
                  decoration: const InputDecoration(
                      labelText: 'مستوى الإتقان (مثل: لغة أم، متقدم)',
                      border: OutlineInputBorder())),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  if (_languageController.text.isNotEmpty &&
                      _proficiencyController.text.isNotEmpty) {
                    ref.read(cvDataProvider.notifier).addLanguage(Language(
                        name: _languageController.text,
                        proficiency: _proficiencyController.text));
                    _languageController.clear();
                    _proficiencyController.clear();
                  }
                },
                child: const Text('إضافة لغة'),
              ),
              const SizedBox(height: 10),
              // عرض اللغات المضافة
              ...cvData.languages.map((lang) => ListTile(
                  title: Text(lang.name), subtitle: Text(lang.proficiency))),

              const SizedBox(height: 80), // مسافة قبل الزر العائم
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final lang = ref.read(languageProvider);
          final pdfBytes = await generatePdf(cvData, lang);
          await Printing.layoutPdf(onLayout: (format) => pdfBytes);
        },
        label: const Text('إنشاء و معاينة PDF'),
        icon: const Icon(Icons.picture_as_pdf),
      ),
    );
  }
}
