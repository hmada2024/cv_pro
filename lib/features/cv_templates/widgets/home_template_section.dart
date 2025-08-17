// lib/features/home/widgets/home_template_section.dart
import 'package:cv_pro/core/constants/app_sizes.dart';
import 'package:cv_pro/features/cv_form/ui/screens/pdf_preview_screen.dart';
import 'package:cv_pro/features/cv_templates/providers/template_provider.dart';
import 'package:cv_pro/features/cv_templates/widgets/template_selection_bottom_sheet.dart';
import 'package:cv_pro/features/pdf_export/data/providers/pdf_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeTemplateSection extends ConsumerWidget {
  const HomeTemplateSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTemplate = ref.watch(selectedTemplateProvider);
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.p16),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.p16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Selected Template:',
                style: theme.textTheme.titleMedium,
              ),
              const SizedBox(height: AppSizes.p8),
              // عرض اسم القالب المختار
              Container(
                padding: const EdgeInsets.all(AppSizes.p12),
                decoration: BoxDecoration(
                  color: theme.scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(AppSizes.buttonRadius),
                  border: Border.all(color: theme.dividerColor),
                ),
                child: Text(
                  selectedTemplate.name,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: AppSizes.p16),
              Row(
                children: [
                  // زر اختيار القالب
                  Expanded(
                    child: OutlinedButton.icon(
                      icon: const Icon(Icons.style_outlined),
                      label: const Text('Choose'),
                      onPressed: () {
                        showTemplateSelectionBottomSheet(context);
                      },
                    ),
                  ),
                  const SizedBox(width: AppSizes.p12),
                  // زر معاينة القالب بالبيانات الوهمية
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.visibility_outlined),
                      label: const Text('Preview'),
                      onPressed: () {
                        // استخدام dummyPdfBytesProvider لعرض القالب ببيانات وهمية
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => PdfPreviewScreen(
                              pdfProvider: dummyPdfBytesProvider,
                              projectName: 'Template Preview',
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
