// lib/features/history/ui/widgets/history_card.dart
import 'package:cv_pro/core/constants/app_sizes.dart';
import 'package:cv_pro/features/cv_form/ui/screens/pdf_preview_screen.dart';
import 'package:cv_pro/features/history/data/models/cv_history.dart';
import 'package:cv_pro/features/history/data/providers/cv_history_provider.dart';
import 'package:cv_pro/features/pdf_export/data/providers/pdf_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class HistoryCard extends ConsumerWidget {
  final CVHistory history;

  const HistoryCard({super.key, required this.history});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final formattedDate =
        DateFormat('d MMM yyyy, hh:mm a').format(history.createdAt);

    return Card(
      margin: const EdgeInsets.only(bottom: AppSizes.p12),
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.p12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              history.displayName,
              style: theme.textTheme.titleMedium,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: AppSizes.p4),
            Text(
              'Saved on: $formattedDate',
              style: theme.textTheme.bodySmall,
            ),
            const SizedBox(height: AppSizes.p12),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.download_for_offline_outlined,
                        size: AppSizes.iconSizeSmall),
                    label: const Text('Load'),
                    onPressed: () async {
                      final confirm = await showDialog<bool>(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Load this version?'),
                          content: const Text(
                              'This will replace your current CV data. Your current work will be overwritten.'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(false),
                              child: const Text('Cancel'),
                            ),
                            FilledButton(
                              onPressed: () => Navigator.of(context).pop(true),
                              child: const Text('Load'),
                            ),
                          ],
                        ),
                      );

                      if (confirm ?? false) {
                        await ref
                            .read(cvHistoryProvider.notifier)
                            .loadHistoryEntry(history.id);
                        if (context.mounted) {
                          Navigator.of(context).pop(); // Close history screen
                        }
                      }
                    },
                  ),
                ),
                const SizedBox(width: AppSizes.p8),
                Expanded(
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.visibility_outlined,
                        size: AppSizes.iconSizeSmall),
                    label: const Text('Preview'),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => PdfPreviewScreen(
                            pdfProvider: historyPdfBytesProvider(history.id),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.delete_outline,
                      color: theme.colorScheme.error),
                  onPressed: () async {
                    final confirm = await showDialog<bool>(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Delete this version?'),
                        content: const Text(
                            'This action is permanent and cannot be undone.'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(false),
                            child: const Text('Cancel'),
                          ),
                          FilledButton(
                            style: FilledButton.styleFrom(
                                backgroundColor: theme.colorScheme.error),
                            onPressed: () => Navigator.of(context).pop(true),
                            child: const Text('Delete'),
                          ),
                        ],
                      ),
                    );

                    if (confirm ?? false) {
                      await ref
                          .read(cvHistoryProvider.notifier)
                          .deleteHistoryEntry(history.id);
                    }
                  },
                  tooltip: 'Delete',
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
