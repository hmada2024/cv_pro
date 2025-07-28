import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cv_pro/features/cv_form/data/providers/cv_form_provider.dart';
import 'package:cv_pro/features/pdf_export/data/services/pdf_service_impl.dart';
import 'package:printing/printing.dart';

class PdfPreviewScreen extends ConsumerWidget {
  final CvTemplate template;

  const PdfPreviewScreen({
    super.key,
    required this.template,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the future provider with the selected template
    final pdfBytesAsync = ref.watch(pdfBytesProvider(template));

    return Scaffold(
      appBar: AppBar(
        title: const Text('CV Preview'),
      ),
      // Use AsyncValue.when to handle loading/error/data states
      body: pdfBytesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(
          child: Text('Error generating PDF: $err'),
        ),
        data: (pdfBytes) => PdfPreview(
          build: (format) => pdfBytes,
          canChangeOrientation: false,
          canChangePageFormat: false,
          canDebug: false,
        ),
      ),
    );
  }
}
