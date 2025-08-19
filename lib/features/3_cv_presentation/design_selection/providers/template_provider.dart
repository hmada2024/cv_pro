// lib/features/3_cv_presentation/design_selection/providers/template_provider.dart
import 'package:cv_pro/features/3_cv_presentation/design_selection/models/template_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// قائمة بجميع القوالب المتاحة في التطبيق
final allTemplatesProvider = Provider<List<TemplateModel>>((ref) {
  // ملاحظة: تأكد من أن مسارات الصور هذه تطابق الملفات التي ستضيفها
  const String path = 'assets/images/cv_previews/';

  return const [
    TemplateModel(
      id: 'template_1',
      name: 'Two Vertical Columns',
      previewImagePath: '${path}1.jpg',
      isEnabled: true,
    ),
    TemplateModel(
      id: 'template_2',
      name: 'Blue Top Header',
      previewImagePath: '${path}2.png',
      isEnabled: true,
    ),
    TemplateModel(
      id: 'template_3',
      name: 'Yellow Intersection',
      previewImagePath: '${path}3.png',
      isEnabled: true,
    ),
    TemplateModel(
      id: 'template_4',
      name: 'Asymmetric Black & Blue',
      previewImagePath: '${path}4.png',
      isEnabled: true,
    ),
  ];
});

final selectedTemplateProvider = StateProvider<TemplateModel>((ref) {
  return ref.watch(allTemplatesProvider).firstWhere((t) => t.isEnabled);
});
