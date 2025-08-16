// lib/features/cv_projects/ui/widgets/create_cv_dialog.dart
import 'package:cv_pro/core/constants/app_sizes.dart';
import 'package:cv_pro/core/widgets/english_only_text_field.dart';
// Corrected import path for the provider
import 'package:cv_pro/features/cv_projects/providers/cv_projects_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<int?> showCreateCvDialog(BuildContext context, WidgetRef ref) async {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();

  return await showDialog<int?>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Create New CV Project'),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                  'Give your new CV a unique name to identify it later.'),
              const SizedBox(height: AppSizes.p16),
              EnglishOnlyTextField(
                controller: nameController,
                labelText: 'Project Name',
                hintText: 'e.g., Senior Flutter Developer CV',
                autofocus: true,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Project name cannot be empty.';
                  }
                  return null;
                },
              ),
              ValueListenableBuilder(
                valueListenable: nameController,
                builder: (context, value, child) {
                  final filename = value.text.trim().isNotEmpty
                      ? '${value.text.trim()}.pdf'
                      : 'filename.pdf';
                  return Padding(
                    padding: const EdgeInsets.only(top: AppSizes.p8),
                    child: Text(
                      'Filename will be: $filename',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(null),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () async {
              if (formKey.currentState!.validate()) {
                // Corrected provider name
                final notifier = ref.read(cvProjectsProvider.notifier);
                final isTaken = await notifier
                    .isProjectNameTaken(nameController.text.trim());
                if (context.mounted) {
                  if (isTaken) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('This project name already exists.')));
                  } else {
                    final newId = await notifier
                        .createNewProject(nameController.text.trim());
                    if (context.mounted) Navigator.of(context).pop(newId);
                  }
                }
              }
            },
            child: const Text('Create'),
          ),
        ],
      );
    },
  );
}
