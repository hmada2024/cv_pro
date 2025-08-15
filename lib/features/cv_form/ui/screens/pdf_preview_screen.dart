// lib/features/cv_form/ui/screens/pdf_preview_screen.dart
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:printing/printing.dart';

class PdfPreviewScreen extends ConsumerWidget {
  final AutoDisposeFutureProvider<Uint8List> pdfProvider;

  const PdfPreviewScreen({
    super.key,
    required this.pdfProvider,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pdfBytesAsync = ref.watch(pdfProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('CV Preview'),
      ),
      body: pdfBytesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Error generating PDF: $err\n\n$stack',
              textAlign: TextAlign.center,
            ),
          ),
        ),
        data: (pdfBytes) => PdfPreview(
          build: (format) => pdfBytes,
          useActions: true,
          canChangeOrientation: false,
          canChangePageFormat: false,
          canDebug: false,
        ),
      ),
    );
  }
}
