// lib/features/2_cv_editor/form/ui/screens/pdf_preview_screen.dart
import 'dart:typed_data';
import 'package:cv_pro/core/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:printing/printing.dart';

class PdfPreviewScreen extends ConsumerWidget {
  final AutoDisposeFutureProvider<Uint8List> pdfProvider;
  final String projectName;
  final bool isDummyPreview;

  const PdfPreviewScreen({
    super.key,
    required this.pdfProvider,
    required this.projectName,
    this.isDummyPreview = false,
  });

  Widget _buildActionButtons(
      BuildContext context, WidgetRef ref, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.all(AppSizes.p16),
      child: Row(
        children: [
          if (!isDummyPreview) ...[
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
          ],
          Expanded(
            child: ElevatedButton.icon(
              icon: const Icon(Icons.share_outlined),
              label: const Text('Share / Save'),
              onPressed: () async {
                try {
                  final pdfBytes = await ref.read(pdfProvider.future);
                  final defaultName = '$projectName.pdf';

                  await Printing.sharePdf(
                    bytes: pdfBytes,
                    filename: defaultName,
                  );
                } catch (e) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('An error occurred: $e')),
                    );
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                    vertical: AppSizes.formFieldContentPaddingV),
              ),
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
              // --- BEGIN FIX: Wrap PdfPreview with InteractiveViewer to prevent flicker ---
              child: InteractiveViewer(
                panEnabled: true,
                scaleEnabled: true,
                boundaryMargin: const EdgeInsets.all(20.0),
                minScale: 0.5,
                maxScale: 4.0,
                child: PdfPreview(
                  build: (format) => pdfBytes,
                  useActions: false,
                  canChangeOrientation: false,
                  canChangePageFormat: false,
                  canDebug: false,
                ),
              ),
              // --- END FIX ---
            ),
            _buildActionButtons(context, ref, theme),
          ],
        ),
      ),
    );
  }
}
