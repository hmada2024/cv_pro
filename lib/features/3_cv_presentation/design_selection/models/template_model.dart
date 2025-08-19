// lib/features/3_cv_presentation/design_selection/models/template_model.dart
class TemplateModel {
  final String id;
  final String name;
  final String previewImagePath;
  final bool isEnabled;

  const TemplateModel({
    required this.id,
    required this.name,
    required this.previewImagePath,
    this.isEnabled = false,
  });
}
