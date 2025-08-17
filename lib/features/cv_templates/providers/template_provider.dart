// lib/features/cv_templates/providers/template_provider.dart
import 'package:cv_pro/features/cv_templates/models/template_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// قائمة بجميع القوالب المتاحة في التطبيق
// حاليًا، فقط القالب الأول مفعل
final allTemplatesProvider = Provider<List<TemplateModel>>((ref) {
  return List.generate(10, (index) {
    final templateNumber = index + 1;
    return TemplateModel(
      id: 'template_$templateNumber',
      name: 'CV Template #$templateNumber',
      // فقط العنصر الأول سيكون مفعلًا
      isEnabled: index == 0,
    );
  });
});

// Provider لإدارة حالة القالب الذي تم اختياره حاليًا
// القيمة الافتراضية هي أول قالب في القائمة
final selectedTemplateProvider = StateProvider<TemplateModel>((ref) {
  return ref.watch(allTemplatesProvider).first;
});
