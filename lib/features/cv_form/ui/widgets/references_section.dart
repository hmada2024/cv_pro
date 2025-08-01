// features/cv_form/ui/widgets/references_section.dart
import 'package:cv_pro/core/widgets/english_only_text_field.dart';
import 'package:cv_pro/features/cv_form/data/models/cv_data.dart';
import 'package:cv_pro/features/pdf_export/data/services/pdf_service_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cv_pro/features/cv_form/data/providers/cv_form_provider.dart';

class ReferencesSection extends ConsumerWidget {
  const ReferencesSection({super.key});

  void _showReferenceDialog(BuildContext context, WidgetRef ref,
      {Reference? existingReference, int? index}) {
    final isEditing = existingReference != null;

    final nameController =
        TextEditingController(text: isEditing ? existingReference.name : '');
    final companyController =
        TextEditingController(text: isEditing ? existingReference.company : '');
    final positionController = TextEditingController(
        text: isEditing ? existingReference.position : '');
    final emailController =
        TextEditingController(text: isEditing ? existingReference.email : '');
    final phoneController =
        TextEditingController(text: isEditing ? existingReference.phone : '');

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(isEditing ? 'Edit Reference' : 'Add Reference'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                EnglishOnlyTextField(
                    controller: nameController, labelText: 'Full Name'),
                const SizedBox(height: 12),
                EnglishOnlyTextField(
                    controller: companyController, labelText: 'Company'),
                const SizedBox(height: 12),
                EnglishOnlyTextField(
                    controller: positionController, labelText: 'Position'),
                const SizedBox(height: 12),
                EnglishOnlyTextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    labelText: 'Email Address'),
                const SizedBox(height: 12),
                EnglishOnlyTextField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    labelText: 'Phone (Optional)'),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final notifier = ref.read(cvFormProvider.notifier);
                if (isEditing) {
                  final updatedReference = Reference.create(
                    name: nameController.text,
                    company: companyController.text,
                    position: positionController.text,
                    email: emailController.text,
                    phone: phoneController.text,
                  );
                  notifier.updateReference(index!, updatedReference);
                } else {
                  notifier.addReference(
                      name: nameController.text,
                      company: companyController.text,
                      position: positionController.text,
                      email: emailController.text,
                      phone: phoneController.text);
                }
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final references = ref.watch(cvFormProvider).references;
    final showNote = ref.watch(showReferencesNoteProvider);
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                const Icon(Icons.group, color: Colors.blueGrey),
                const SizedBox(width: 8),
                Text(
                  'References',
                  style: theme.textTheme.titleLarge,
                ),
              ],
            ),
            const SizedBox(height: 8),
            SwitchListTile(
              title: const Text('Available upon request'),
              subtitle: Text(
                'Hides reference details and shows a note instead.',
                style: theme.textTheme.bodyMedium?.copyWith(fontSize: 12),
              ),
              value: showNote,
              onChanged: (bool value) {
                ref.read(showReferencesNoteProvider.notifier).state = value;
              },
              activeColor: theme.colorScheme.primary,
              contentPadding: EdgeInsets.zero,
            ),
            const SizedBox(height: 8),
            OutlinedButton.icon(
              icon: const Icon(Icons.add),
              label: const Text('Add Reference'),
              onPressed:
                  showNote ? null : () => _showReferenceDialog(context, ref),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
            if (references.isNotEmpty) const SizedBox(height: 16),
            Opacity(
              opacity: showNote ? 0.5 : 1.0,
              child: IgnorePointer(
                ignoring: showNote,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: references.length,
                  itemBuilder: (context, index) {
                    final refItem = references[index];
                    return Card(
                      elevation: 2,
                      margin: const EdgeInsets.only(bottom: 8.0),
                      child: ListTile(
                        leading: Icon(Icons.person_pin,
                            color: showNote ? Colors.grey : Colors.orange),
                        title: Text(refItem.name,
                            style: theme.textTheme.titleMedium),
                        subtitle: Text(refItem.company),
                        trailing: IconButton(
                          icon: Icon(Icons.delete_outline,
                              color: showNote
                                  ? Colors.grey
                                  : theme.colorScheme.error),
                          onPressed: () => ref
                              .read(cvFormProvider.notifier)
                              .removeReference(index),
                        ),
                        onTap: () => _showReferenceDialog(context, ref,
                            existingReference: refItem, index: index),
                      ),
                    );
                  },
                ),
              ),
            ),
            if (references.isEmpty && !showNote)
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  'No references added yet. Add some, or toggle "Available upon request" on.',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
