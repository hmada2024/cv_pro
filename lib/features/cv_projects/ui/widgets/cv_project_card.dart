// lib/features/cv_projects/ui/widgets/cv_project_card.dart
import 'package:cv_pro/core/constants/app_sizes.dart';
import 'package:cv_pro/features/cv_form/data/models/cv_data.dart';
import 'package:cv_pro/features/cv_form/data/providers/cv_form_provider.dart';
import 'package:cv_pro/features/cv_form/ui/screens/cv_form_screen.dart';
// Corrected import path for the provider
import 'package:cv_pro/features/cv_projects/providers/cv_projects_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class CvProjectCard extends ConsumerWidget {
  final CVData cvData;

  const CvProjectCard({super.key, required this.cvData});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final formattedDate =
        DateFormat.yMMMd().add_jm().format(cvData.lastModified);

    return Card(
      margin: const EdgeInsets.only(bottom: AppSizes.p12),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppSizes.cardRadius),
        onTap: () {
          ref.read(activeCvProvider.notifier).loadCvProject(cvData);
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => const CvFormScreen()));
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.p16, vertical: AppSizes.p12),
          child: Row(
            children: [
              Icon(Icons.article_outlined,
                  color: theme.colorScheme.primary, size: 32),
              const SizedBox(width: AppSizes.p16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cvData.projectName,
                      style: theme.textTheme.titleMedium,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: AppSizes.p4),
                    Text(
                      'Last modified: $formattedDate',
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              IconButton(
                icon:
                    Icon(Icons.delete_outline, color: theme.colorScheme.error),
                onPressed: () async {
                  final confirm = await showDialog<bool>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Delete Project?'),
                      content: Text(
                          'Are you sure you want to delete "${cvData.projectName}"? This action cannot be undone.'),
                      actions: [
                        TextButton(
                            onPressed: () => Navigator.of(context).pop(false),
                            child: const Text('Cancel')),
                        FilledButton(
                          onPressed: () => Navigator.of(context).pop(true),
                          style: FilledButton.styleFrom(
                              backgroundColor: theme.colorScheme.error),
                          child: const Text('Delete'),
                        ),
                      ],
                    ),
                  );
                  if (confirm ?? false) {
                    // Corrected provider name
                    await ref
                        .read(cvProjectsProvider.notifier)
                        .deleteProject(cvData.id);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
