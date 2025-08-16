// lib/features/settings/ui/widgets/appearance_section.dart
import 'package:cv_pro/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppearanceSection extends ConsumerWidget {
  const AppearanceSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentThemeMode = ref.watch(themeModeProvider);
    final theme = Theme.of(context);

    return Card(
      child: Column(
        children: [
          RadioListTile<ThemeMode>(
            title: const Text('Light'),
            subtitle: Text('Classic, bright interface.',
                style: theme.textTheme.bodySmall),
            value: ThemeMode.light,
            groupValue: currentThemeMode,
            onChanged: (value) =>
                ref.read(themeModeProvider.notifier).state = value!,
          ),
          RadioListTile<ThemeMode>(
            title: const Text('Dark'),
            subtitle: Text('Easy on the eyes in low light.',
                style: theme.textTheme.bodySmall),
            value: ThemeMode.dark,
            groupValue: currentThemeMode,
            onChanged: (value) =>
                ref.read(themeModeProvider.notifier).state = value!,
          ),
          RadioListTile<ThemeMode>(
            title: const Text('System Default'),
            subtitle: Text('Matches your device settings.',
                style: theme.textTheme.bodySmall),
            value: ThemeMode.system,
            groupValue: currentThemeMode,
            onChanged: (value) =>
                ref.read(themeModeProvider.notifier).state = value!,
          ),
        ],
      ),
    );
  }
}
