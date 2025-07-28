import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cv_pro/features/pdf_export/data/services/pdf_service_impl.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTemplate = ref.watch(selectedTemplateProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Text(
            'CV Template',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          const Text(
            'Choose the template that will be used for PDF generation.',
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 16),
          _buildTemplateSelector(
            context: context,
            title: 'Modern',
            subtitle: 'A creative two-column layout.',
            value: CvTemplate.modern,
            groupValue: selectedTemplate,
            onChanged: (value) {
              if (value != null) {
                ref.read(selectedTemplateProvider.notifier).state = value;
              }
            },
          ),
          const SizedBox(height: 12),
          _buildTemplateSelector(
            context: context,
            title: 'Corporate Blue',
            subtitle: 'A professional design with a blue header.',
            value: CvTemplate.corporateBlue,
            groupValue: selectedTemplate,
            onChanged: (value) {
              if (value != null) {
                ref.read(selectedTemplateProvider.notifier).state = value;
              }
            },
          ),
          const SizedBox(height: 12),
          _buildTemplateSelector(
            context: context,
            title: 'Timeline Professional',
            subtitle: 'A stylish timeline design with a 3D-like effect.',
            value: CvTemplate.timelineProfessional,
            groupValue: selectedTemplate,
            onChanged: (value) {
              if (value != null) {
                ref.read(selectedTemplateProvider.notifier).state = value;
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTemplateSelector({
    required BuildContext context,
    required String title,
    required String subtitle,
    required CvTemplate value,
    required CvTemplate groupValue,
    required void Function(CvTemplate?) onChanged,
  }) {
    return Card(
      child: RadioListTile<CvTemplate>(
        title: Text(title),
        subtitle: Text(subtitle),
        value: value,
        groupValue: groupValue,
        onChanged: onChanged,
        activeColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
