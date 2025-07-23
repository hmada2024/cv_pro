import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cv_pro/features/cv_creation/providers/cv_data_provider.dart';
import 'package:cv_pro/features/pdf_generation/pdf_generator.dart';
import 'package:printing/printing.dart';
import 'package:cv_pro/features/cv_creation/models/cv_data.dart';

class CvFormScreen extends ConsumerStatefulWidget {
  const CvFormScreen({super.key});

  @override
  ConsumerState<CvFormScreen> createState() => _CvFormScreenState();
}

class _CvFormScreenState extends ConsumerState<CvFormScreen> {
  // تعريف كل المتحكمات هنا
  final _nameController = TextEditingController();
  final _jobTitleController = TextEditingController();
  final _emailController = TextEditingController();

  final _companyController = TextEditingController();
  final _positionController = TextEditingController();
  final _descriptionController = TextEditingController();

  final _skillController = TextEditingController();

  final _languageController = TextEditingController();
  final _proficiencyController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // قراءة الحالة الأولية ووضعها في المتحكمات عند بدء الشاشة
    final cvData = ref.read(cvDataProvider);
    _nameController.text = cvData.personalInfo.name;
    _jobTitleController.text = cvData.personalInfo.jobTitle;
    _emailController.text = cvData.personalInfo.email;

    // إضافة مستمعين لتحديث الحالة تلقائياً عند الكتابة
    _nameController.addListener(() {
      ref
          .read(cvDataProvider.notifier)
          .updatePersonalInfo(name: _nameController.text);
    });
    _jobTitleController.addListener(() {
      ref
          .read(cvDataProvider.notifier)
          .updatePersonalInfo(jobTitle: _jobTitleController.text);
    });
    _emailController.addListener(() {
      ref
          .read(cvDataProvider.notifier)
          .updatePersonalInfo(email: _emailController.text);
    });
  }

  @override
  void dispose() {
    // التخلص من المتحكمات لمنع تسرب الذاكرة
    _nameController.dispose();
    _jobTitleController.dispose();
    _emailController.dispose();
    _companyController.dispose();
    _positionController.dispose();
    _descriptionController.dispose();
    _skillController.dispose();
    _languageController.dispose();
    _proficiencyController.dispose();
    super.dispose();
  }

  void showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final cvData = ref.watch(cvDataProvider);
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
            // ... (قسم اللغة لا تغيير فيه)
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
                ref.read(languageProvider.notifier).state = newSelection.first;
              },
            ),
            const Divider(height: 40),

            // قسم المعلومات الشخصية (معدل لاستخدام المتحكمات فقط)
            Text('المعلومات الشخصية',
                style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 10),
            TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                    labelText: 'الاسم الكامل', border: OutlineInputBorder())),
            const SizedBox(height: 10),
            TextFormField(
                controller: _jobTitleController,
                decoration: const InputDecoration(
                    labelText: 'المسمى الوظيفي', border: OutlineInputBorder())),
            const SizedBox(height: 10),
            TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                    labelText: 'البريد الإلكتروني',
                    border: OutlineInputBorder()),
                keyboardType: TextInputType.emailAddress),

            const Divider(height: 40),

            // باقي الأقسام
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
                if (_companyController.text.isNotEmpty &&
                    _positionController.text.isNotEmpty) {
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
                  showSuccessSnackBar('تمت إضافة الخبرة بنجاح!');
                }
              },
              child: const Text('إضافة خبرة'),
            ),
            const SizedBox(height: 10),
            ...cvData.experiences.map((exp) => Card(
                margin: const EdgeInsets.only(top: 8),
                child: ListTile(
                    title: Text(exp.position),
                    subtitle: Text(exp.companyName)))),

            const Divider(height: 40),
            Text('إضافة مهارة',
                style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 10),
            TextFormField(
              controller: _skillController,
              decoration: const InputDecoration(
                  labelText: 'اسم المهارة (مثل: Flutter)',
                  border: OutlineInputBorder()),
              onFieldSubmitted: (value) {
                if (value.isNotEmpty) {
                  ref
                      .read(cvDataProvider.notifier)
                      .addSkill(Skill(name: value));
                  _skillController.clear();
                  showSuccessSnackBar('تمت إضافة المهارة: $value');
                }
              },
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
              children: cvData.skills
                  .map((skill) => Chip(label: Text(skill.name)))
                  .toList(),
            ),

            const Divider(height: 40),
            Text('إضافة لغة', style: Theme.of(context).textTheme.headlineSmall),
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
                  showSuccessSnackBar('تمت إضافة اللغة بنجاح!');
                }
              },
              child: const Text('إضافة لغة'),
            ),
            const SizedBox(height: 10),
            ...cvData.languages.map((lang) => Card(
                margin: const EdgeInsets.only(top: 8),
                child: ListTile(
                    title: Text(lang.name), subtitle: Text(lang.proficiency)))),

            const SizedBox(height: 80),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final lang = ref.read(languageProvider);
          // سنقرأ الحالة مباشرة من الـ ref هنا لضمان الحصول على آخر نسخة محدثة
          // هذا هو الأسلوب الأكثر أماناً داخل Callbacks مثل onPressed
          final currentCvData = ref.read(cvDataProvider);
          final pdfBytes = await generatePdf(currentCvData, lang);
          await Printing.layoutPdf(onLayout: (format) => pdfBytes);
        },
        label: const Text('إنشاء و معاينة PDF'),
        icon: const Icon(Icons.picture_as_pdf),
      ),
    );
  }
}
