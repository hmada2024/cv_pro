// lib/features/cv_templates/providers/template_provider.dart
import 'package:cv_pro/features/3_cv_presentation/design_selection/models/template_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// قائمة بجميع القوالب المتاحة في التطبيق
final allTemplatesProvider = Provider<List<TemplateModel>>((ref) {
  // --- التغيير: تعريف القوالب المتاحة بشكل صريح ---
  return const [
    TemplateModel(
      id: 'template_1',
      name: 'Classic Two Column',
      isEnabled: true,
    ),
    TemplateModel(
      id: 'template_2',
      name: 'Modern Top Header',
      isEnabled: true, // تفعيل القالب الجديد
    ),
    TemplateModel(
      id: 'template_3',
      name: 'yellow design',
      isEnabled: false, // مثال لقالب مستقبلي
    ),
  ];
});

final selectedTemplateProvider = StateProvider<TemplateModel>((ref) {
  return ref.watch(allTemplatesProvider).first;
});
