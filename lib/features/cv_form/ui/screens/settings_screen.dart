import 'package:cv_pro/features/cv_form/ui/screens/pdf_preview_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cv_pro/core/theme/app_theme.dart';
import 'package:cv_pro/features/cv_form/data/providers/cv_form_provider.dart';
import 'package:cv_pro/features/pdf_export/data/services/pdf_service_impl.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTemplate = ref.watch(selectedTemplateProvider);
    final currentThemeMode = ref.watch(themeModeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Text(
            'Appearance',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          SegmentedButton<ThemeMode>(
            segments: const <ButtonSegment<ThemeMode>>[
              ButtonSegment<ThemeMode>(
                  value: ThemeMode.light,
                  label: Text('Light'),
                  icon: Icon(Icons.light_mode_outlined)),
              ButtonSegment<ThemeMode>(
                  value: ThemeMode.dark,
                  label: Text('Dark'),
                  icon: Icon(Icons.dark_mode_outlined)),
              ButtonSegment<ThemeMode>(
                  value: ThemeMode.system,
                  label: Text('System'),
                  icon: Icon(Icons.settings_system_daydream_outlined)),
            ],
            selected: {currentThemeMode},
            onSelectionChanged: (Set<ThemeMode> newSelection) {
              ref.read(themeModeProvider.notifier).state = newSelection.first;
            },
          ),
          const Divider(height: 40),

          // --- Template Section ---
          Text(
            'CV Template',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          const Text(
            'Choose the template that will be used for the final CV.',
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 16),
          _buildTemplateSelector(
            context: context,
            ref: ref,
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
            ref: ref,
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
        ],
      ),
    );
  }

  Widget _buildTemplateSelector({
    required BuildContext context,
    required WidgetRef ref,
    required String title,
    required String subtitle,
    required CvTemplate value,
    required CvTemplate groupValue,
    required void Function(CvTemplate?) onChanged,
  }) {
    return Card(
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        leading: Radio<CvTemplate>(
          value: value,
          groupValue: groupValue,
          onChanged: onChanged,
          activeColor: Theme.of(context).colorScheme.primary,
        ),
        trailing: IconButton(
          icon: const Icon(Icons.visibility_outlined),
          tooltip: 'Preview with dummy data',
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => PdfPreviewScreen(
                  pdfProvider: dummyPdfBytesProvider(value),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
