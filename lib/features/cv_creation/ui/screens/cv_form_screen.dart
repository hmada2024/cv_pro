import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cv_pro/features/cv_creation/providers/cv_data_provider.dart';
import 'package:cv_pro/features/pdf_generation/pdf_generator.dart';
import 'package:printing/printing.dart';
import 'package:cv_pro/features/cv_creation/models/cv_data.dart'; // استيراد النموذج

class CvFormScreen extends ConsumerWidget {
  CvFormScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  final _companyController = TextEditingController();
  final _positionController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // مراقبة التغييرات في بيانات الـ CV
    final cvData = ref.watch(cvDataProvider);

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
              // قسم المعلومات الشخصية
              Text('المعلومات الشخصية',
                  style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 10),
              TextFormField(
                decoration: const InputDecoration(
                    labelText: 'الاسم الكامل', border: OutlineInputBorder()),
                onChanged: (value) => ref
                    .read(cvDataProvider.notifier)
                    .updatePersonalInfo(name: value),
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: const InputDecoration(
                    labelText: 'المسمى الوظيفي', border: OutlineInputBorder()),
                onChanged: (value) => ref
                    .read(cvDataProvider.notifier)
                    .updatePersonalInfo(jobTitle: value),
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: const InputDecoration(
                    labelText: 'البريد الإلكتروني',
                    border: OutlineInputBorder()),
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) => ref
                    .read(cvDataProvider.notifier)
                    .updatePersonalInfo(email: value),
              ),
              const Divider(height: 40),

              // قسم إضافة خبرة
              Text('إضافة خبرة عملية',
                  style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 10),
              TextFormField(
                controller: _companyController,
                decoration: const InputDecoration(
                    labelText: 'اسم الشركة', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _positionController,
                decoration: const InputDecoration(
                    labelText: 'المنصب', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                    labelText: 'الوصف', border: OutlineInputBorder()),
                maxLines: 3,
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  // إضافة الخبرة إلى الحالة
                  final newExperience = Experience(
                    companyName: _companyController.text,
                    position: _positionController.text,
                    description: _descriptionController.text,
                    startDate: DateTime.now()
                        .subtract(const Duration(days: 365)), // تاريخ افتراضي
                    endDate: DateTime.now(), // تاريخ افتراضي
                  );
                  ref
                      .read(cvDataProvider.notifier)
                      .addExperience(newExperience);

                  // مسح الحقول
                  _companyController.clear();
                  _positionController.clear();
                  _descriptionController.clear();
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('تمت إضافة الخبرة بنجاح!')));
                },
                child: const Text('إضافة خبرة'),
              ),
              const Divider(height: 40),

              // عرض الخبرات المضافة
              Text('الخبرات المضافة (${cvData.experiences.length})',
                  style: Theme.of(context).textTheme.titleMedium),
              ...cvData.experiences.map((exp) => ListTile(
                    title: Text(exp.position),
                    subtitle: Text(exp.companyName),
                  )),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          // استدعاء دالة توليد الـ PDF
          final pdfBytes = await generatePdf(cvData);
          // عرض شاشة المعاينة
          await Printing.layoutPdf(onLayout: (format) => pdfBytes);
        },
        label: const Text('إنشاء و معاينة PDF'),
        icon: const Icon(Icons.picture_as_pdf),
      ),
    );
  }
}
