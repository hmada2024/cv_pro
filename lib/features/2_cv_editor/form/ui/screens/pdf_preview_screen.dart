// lib/features/2_cv_editor/form/ui/screens/pdf_preview_screen.dart
import 'dart:typed_data';
import 'package:cv_pro/core/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:printing/printing.dart';

class PdfPreviewScreen extends ConsumerStatefulWidget {
  final AutoDisposeFutureProvider<Uint8List> pdfProvider;
  final String projectName;
  final bool isDummyPreview;

  const PdfPreviewScreen({
    super.key,
    required this.pdfProvider,
    required this.projectName,
    this.isDummyPreview = false,
  });

  @override
  ConsumerState<PdfPreviewScreen> createState() => _PdfPreviewScreenState();
}

class _PdfPreviewScreenState extends ConsumerState<PdfPreviewScreen> {
  // We store the future in the state to prevent it from being re-fetched.
  late Future<Uint8List> _pdfFuture;

  @override
  void initState() {
    super.initState();
    // Fetch the PDF data once and store the future.
    _pdfFuture = ref.read(widget.pdfProvider.future);
  }

  // Moved the action buttons widget inside the state class.
  // It now accepts the generated pdfBytes directly to avoid re-fetching.
  Widget _buildActionButtons(
      BuildContext context, ThemeData theme, Uint8List pdfBytes) {
    return Padding(
      padding: const EdgeInsets.all(AppSizes.p16),
      child: Row(
        children: [
          if (!widget.isDummyPreview) ...[
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
                  final defaultName = '${widget.projectName}.pdf';
                  await Printing.sharePdf(
                    bytes: pdfBytes, // Use the bytes passed to the function
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
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('CV Preview'),
      ),
      // Use FutureBuilder to handle the lifecycle of our single data fetch.
      body: FutureBuilder<Uint8List>(
        future: _pdfFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
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
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Error generating PDF: ${snapshot.error}',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: theme.colorScheme.error),
                ),
              ),
            );
          }
          if (snapshot.hasData) {
            final pdfBytes = snapshot.data!;
            return Column(
              children: [
                Expanded(
                  // Your InteractiveViewer is preserved here.
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
                ),
                _buildActionButtons(context, theme, pdfBytes),
              ],
            );
          }
          // Fallback case, should not be reached in normal operation.
          return const Center(child: Text('An unexpected error occurred.'));
        },
      ),
    );
  }
}
