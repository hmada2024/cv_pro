// lib/features/cv_form/ui/screens/pdf_preview_screen.dart
import 'dart:typed_data';
import 'package:cv_pro/core/constants/app_sizes.dart';
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
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('CV Preview'),
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: Colors.white,
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
