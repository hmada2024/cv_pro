// lib/features/templates/data/models/template_model.dart

// نموذج بسيط لتمثيل كل قالب في التطبيق
class TemplateModel {
  final String id;
  final String name;
  final bool isEnabled;

  const TemplateModel({
    required this.id,
    required this.name,
    this.isEnabled = false,
  });
}
