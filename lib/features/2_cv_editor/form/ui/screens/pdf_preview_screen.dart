// lib/features/2_cv_editor/form/ui/screens/pdf_preview_screen.dart
import 'package:cv_pro/core/constants/app_sizes.dart';
import 'package:cv_pro/features/3_cv_presentation/design_selection/models/template_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:printing/printing.dart';

class PdfPreviewScreen extends ConsumerStatefulWidget {
  final AutoDisposeFutureProvider<Uint8List> pdfProvider;
  final String projectName;
  final TemplateModel templateModel;
  final bool isDummyPreview;

  const PdfPreviewScreen({
    super.key,
    required this.pdfProvider,
    required this.projectName,
    required this.templateModel,
    this.isDummyPreview = false,
  });

  @override
  ConsumerState<PdfPreviewScreen> createState() => _PdfPreviewScreenState();
}

class _PdfPreviewScreenState extends ConsumerState<PdfPreviewScreen> {
  late Future<Uint8List> _pdfFuture;

  @override
  void initState() {
    super.initState();
    _pdfFuture = ref.read(widget.pdfProvider.future);
  }

  String _generateExportFilename() {
    final name = widget.templateModel.name.replaceAll(' ', '_').toLowerCase();
    return 'gallery_preview_${widget.templateModel.id}_$name.pdf';
  }

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
                final messenger = ScaffoldMessenger.of(context);
                try {
                  final defaultName = '${widget.projectName}.pdf';
                  await Printing.sharePdf(
                    bytes: pdfBytes,
                    filename: defaultName,
                  );
                } catch (e) {
                  if (!mounted) return;
                  messenger.showSnackBar(
                    SnackBar(content: Text('An error occurred: $e')),
                  );
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
      floatingActionButton: kDebugMode
          ? FutureBuilder<Uint8List>(
              future: _pdfFuture,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return FloatingActionButton.extended(
                    onPressed: () async {
                      final messenger = ScaffoldMessenger.of(context);
                      try {
                        await Printing.sharePdf(
                          bytes: snapshot.data!,
                          filename: _generateExportFilename(),
                        );
                        if (!mounted) return;
                        // استخدام المتغير المحلي
                        messenger.showSnackBar(
                          const SnackBar(
                            content: Text('PDF ready to be saved to files.'),
                            backgroundColor: Colors.green,
                          ),
                        );
                      } catch (e) {
                        if (!mounted) return;
                        messenger.showSnackBar(
                          SnackBar(content: Text('Export error: $e')),
                        );
                      }
                    },
                    label: const Text('Export for Gallery'),
                    icon: const Icon(Icons.developer_mode),
                  );
                }
                return const SizedBox.shrink();
              },
            )
          : null,
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
                  Text("Preparing your professional CV...",
                      style: theme.textTheme.bodyLarge),
                  const SizedBox(height: AppSizes.p4),
                  Text("This may take a moment.",
                      style: theme.textTheme.bodySmall),
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
          return const Center(child: Text('An unexpected error occurred.'));
        },
      ),
    );
  }
}
