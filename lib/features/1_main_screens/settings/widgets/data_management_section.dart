// lib/features/settings/widgets/data_management_section.dart
import 'package:cv_pro/core/constants/app_sizes.dart';
import 'package:cv_pro/features/form/data/providers/cv_form_provider.dart';
import 'package:cv_pro/features/projects/providers/cv_projects_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DataManagementSection extends ConsumerWidget {
  const DataManagementSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.cardRadius),
        side: BorderSide(color: theme.colorScheme.error.withOpacity(0.5)),
      ),
      child: ListTile(
        leading:
            Icon(Icons.delete_forever_outlined, color: theme.colorScheme.error),
        title: Text('Clear All Data',
            style: TextStyle(color: theme.colorScheme.error)),
        onTap: () async {
          final confirm = await showDialog<bool>(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Are you sure?'),
              content: const Text(
                  'This will permanently delete all your CV projects. This action cannot be undone.'),
              actions: [
                TextButton(
                  child: const Text('Cancel'),
                  onPressed: () => Navigator.of(context).pop(false),
                ),
                FilledButton(
                  style: FilledButton.styleFrom(
                      backgroundColor: theme.colorScheme.error),
                  child: const Text('Delete All'),
                  onPressed: () => Navigator.of(context).pop(true),
                ),
              ],
            ),
          );

          if (confirm ?? false) {
            // Clear the currently active CV first
            ref.read(activeCvProvider.notifier).clearActiveCV();
            // Call the new function to delete all projects from the database
            await ref.read(cvProjectsProvider.notifier).deleteAllProjects();

            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('All data has been cleared.')),
              );
            }
          }
        },
      ),
    );
  }
}
