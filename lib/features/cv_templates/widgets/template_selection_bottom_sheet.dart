// lib/features/cv_templates/widgets/template_selection_bottom_sheet.dart
import 'package:cv_pro/core/constants/app_sizes.dart';
import 'package:cv_pro/features/cv_templates/providers/template_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void showTemplateSelectionBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    // يضمن أن الـ BottomSheet لا يغطي الشاشة بأكملها على الأجهزة الكبيرة
    isScrollControlled: true,
    builder: (context) {
      return DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.6, // يبدأ بـ 60% من ارتفاع الشاشة
        maxChildSize: 0.9, // يمكن أن يمتد حتى 90%
        minChildSize: 0.3, // يمكن أن يتقلص حتى 30%
        builder: (context, scrollController) {
          return TemplateSelectionBottomSheet(
              scrollController: scrollController);
        },
      );
    },
  );
}

class TemplateSelectionBottomSheet extends ConsumerWidget {
  final ScrollController scrollController;
  const TemplateSelectionBottomSheet(
      {super.key, required this.scrollController});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final templates = ref.watch(allTemplatesProvider);
    final selectedTemplate = ref.watch(selectedTemplateProvider);
    final theme = Theme.of(context);

    // استخدام SafeArea يضمن عدم تداخل المحتوى مع حواف الشاشة
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.p8),
        // تم تعديل هذا الـ Column بالكامل لحل مشكلة التجاوز
        child: Column(
          // 1. إزالة mainAxisSize: MainAxisSize.min لجعل العمود يملأ المساحة
          children: [
            Padding(
              padding: const EdgeInsets.all(AppSizes.p12),
              child: Text(
                'Choose a CV Template',
                style: theme.textTheme.titleLarge,
              ),
            ),
            const Divider(),
            // 2. استخدام Expanded لإعطاء المساحة المتبقية للـ ListView
            Expanded(
              child: ListView.builder(
                // استخدام الـ controller من DraggableScrollableSheet
                controller: scrollController,
                // 3. إزالة shrinkWrap: true لأن Expanded يوفر حدودًا للارتفاع
                itemCount: templates.length,
                itemBuilder: (context, index) {
                  final template = templates[index];
                  final isSelected = template.id == selectedTemplate.id;

                  return ListTile(
                    leading: Icon(
                      isSelected ? Icons.check_circle : Icons.circle_outlined,
                      color: template.isEnabled
                          ? theme.colorScheme.primary
                          : theme.disabledColor,
                    ),
                    title: Text(template.name),
                    subtitle:
                        !template.isEnabled ? const Text('Coming soon') : null,
                    enabled: template.isEnabled,
                    onTap: () {
                      if (template.isEnabled) {
                        ref.read(selectedTemplateProvider.notifier).state =
                            template;
                        Navigator.pop(context);
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
