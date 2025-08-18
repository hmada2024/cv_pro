// lib/features/3_cv_presentation/design_selection/providers/template_provider.dart
import 'package:cv_pro/features/3_cv_presentation/design_selection/models/template_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// قائمة بجميع القوالب المتاحة في التطبيق
final allTemplatesProvider = Provider<List<TemplateModel>>((ref) {
  return const [
    TemplateModel(
      id: 'template_1',
      name: 'Two Vertical Columns',
      isEnabled: true,
    ),
    TemplateModel(
      id: 'template_2',
      name: 'Blue Top Design',
      isEnabled: true,
    ),
    TemplateModel(
      id: 'template_3',
      name: 'Yellow Intersection Design',
      isEnabled: true,
    ),
  ];
});

final selectedTemplateProvider = StateProvider<TemplateModel>((ref) {
  // Ensure the default selection is an enabled template
  return ref.watch(allTemplatesProvider).firstWhere((t) => t.isEnabled);
});
