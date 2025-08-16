// lib/features/cv_form/ui/screens/pdf_preview_screen.dart
import 'dart:typed_data';
import 'package:cv_pro/core/constants/app_sizes.dart';
import 'package:cv_pro/features/cv_form/data/providers/cv_form_provider.dart';
import 'package:cv_pro/features/history/data/providers/cv_history_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:printing/printing.dart';

class PdfPreviewScreen extends ConsumerWidget {
  final AutoDisposeFutureProvider<Uint8List> pdfProvider;

  const PdfPreviewScreen({
    super.key,
    required this.pdfProvider,
  });

  Widget _buildActionButtons(
      BuildContext context, WidgetRef ref, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.all(AppSizes.p16),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton.icon(
              icon: const Icon(Icons.edit_outlined),
              label: const Text('Edit'),
              onPressed: () => Navigator.of(context).pop(),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                    vertical: AppSizes.formFieldContentPaddingV),
              ),
            ),
          ),
          const SizedBox(width: AppSizes.p12),
          Expanded(
            child: ElevatedButton.icon(
              icon: const Icon(Icons.save_alt_outlined),
              label: const Text('Save & Finish'),
              onPressed: () async {
                try {
                  final pdfBytes = await ref.read(pdfProvider.future);
                  final historyList = await ref.read(cvHistoryProvider.future);
                  final defaultName = '${historyList.first.displayName}.pdf';

                  final bool success = await Printing.sharePdf(
                    bytes: pdfBytes,
                    filename: defaultName,
                  );

                  if (success) {
                    await ref.read(cvFormProvider.notifier).clearAllData();

                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('CV process completed!')),
                      );
                      Navigator.of(context).popUntil((route) => route.isFirst);
                    }
                  }
                } catch (e) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('An error occurred: $e')),
                    );
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pdfBytesAsync = ref.watch(pdfProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('CV Preview'),
      ),
      body: pdfBytesAsync.when(
        loading: () => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: AppSizes.p16),
              Text(
                "Preparing your professional CV...",
                style: theme.textTheme.bodyLarge,
              ),
              const SizedBox(height: AppSizes.p4),
              Text(
                "This may take a moment.",
                style: theme.textTheme.bodySmall,
              ),
            ],
          ),
        ),
        error: (err, stack) => Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Error generating PDF: $err',
              textAlign: TextAlign.center,
            ),
          ),
        ),
        data: (pdfBytes) => Column(
          children: [
            Expanded(
              child: PdfPreview(
                build: (format) => pdfBytes,
                useActions: false, // This hides the default buttons
                canChangeOrientation: false,
                canChangePageFormat: false,
                canDebug: false,
              ),
            ),
            _buildActionButtons(context, ref, theme),
          ],
        ),
      ),
    );
  }
}
