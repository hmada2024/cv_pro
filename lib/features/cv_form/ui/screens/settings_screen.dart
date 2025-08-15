// features/cv_form/ui/screens/settings_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cv_pro/core/theme/app_theme.dart';
import 'package:cv_pro/features/pdf_export/data/providers/pdf_providers.dart';
import 'package:cv_pro/features/cv_form/ui/screens/pdf_preview_screen.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ❌ REMOVED: selectedTemplate is no longer needed.
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

          // ✅ SECTION UPDATED: تم التبسيط لعرض القالب الوحيد المتاح.
          Text(
            'CV Template',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Card(
            child: ListTile(
              title: const Text('Official Template'),
              subtitle: const Text(
                  'A dynamic, asymmetrical layout that separates key info from the main content.'),
              leading: Icon(
                Icons.article_outlined,
                color: Theme.of(context).colorScheme.primary,
              ),
              trailing: IconButton(
                icon: const Icon(Icons.visibility_outlined),
                tooltip: 'Preview with dummy data',
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => PdfPreviewScreen(
                        // ✅ UPDATED: استدعاء الـ provider الوهمي المبسط.
                        pdfProvider: dummyPdfBytesProvider,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
