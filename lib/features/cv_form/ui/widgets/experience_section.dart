// features/cv_form/ui/widgets/experience_section.dart

import 'package:cv_pro/core/widgets/english_only_text_field.dart';
import 'package:cv_pro/features/cv_form/data/providers/cv_view_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cv_pro/features/cv_form/data/models/cv_data.dart';
import 'package:cv_pro/features/cv_form/data/providers/cv_form_provider.dart';
import 'package:intl/intl.dart';

class ExperienceSection extends ConsumerWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final experiences = ref.watch(sortedExperiencesProvider);
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Icon(Icons.business_center, color: theme.colorScheme.secondary),
                const SizedBox(width: 8),
                Text('Work Experience', style: theme.textTheme.titleLarge),
              ],
            ),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              icon: const Icon(Icons.add),
              label: const Text('Add Experience'),
              onPressed: () => _showExperienceDialog(context, ref),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
            if (experiences.isNotEmpty) const SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: experiences.length,
              itemBuilder: (context, index) {
                final exp = experiences[index];
                final originalIndex =
                    ref.read(cvFormProvider).experiences.indexOf(exp);
                return _buildExperienceCard(context, ref, exp, originalIndex);
              },
            ),
            if (experiences.isEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  'No work experience added yet.',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildExperienceCard(
      BuildContext context, WidgetRef ref, Experience exp, int index) {
    final theme = Theme.of(context);
    // ✅ UPDATED: Formatter now shows Month and Year for better display
    final formatter = DateFormat('MMMM yyyy');
    final dateRange =
        '${formatter.format(exp.startDate)} - ${exp.isCurrent ? "Present" : formatter.format(exp.endDate!)}';

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: theme.dividerColor, width: 1),
        borderRadius: BorderRadius.circular(8.0),
      ),
      margin: const EdgeInsets.only(bottom: 8.0),
      child: ListTile(
        leading: Icon(Icons.check_circle_outline, color: Colors.green.shade600),
        title: Text(exp.position, style: theme.textTheme.titleMedium),
        subtitle: Text('${exp.companyName}\n$dateRange',
            style: theme.textTheme.bodyMedium),
        isThreeLine: true,
        trailing: IconButton(
          icon: Icon(Icons.delete_outline, color: theme.colorScheme.error),
          onPressed: () {
            ref.read(cvFormProvider.notifier).removeExperience(index);
          },
        ),
        onTap: () => _showExperienceDialog(context, ref,
            existingExperience: exp, index: index),
      ),
    );
  }

  void _showExperienceDialog(BuildContext context, WidgetRef ref,
      {Experience? existingExperience, int? index}) {
    final isEditing = existingExperience != null;
    final formKey = GlobalKey<FormState>();

    final positionController = TextEditingController(
        text: isEditing ? existingExperience.position : '');
    final companyController = TextEditingController(
        text: isEditing ? existingExperience.companyName : '');
    final descriptionController = TextEditingController(
        text: isEditing ? existingExperience.description : '');

    DateTime? startDate = isEditing ? existingExperience.startDate : null;
    DateTime? endDate = isEditing ? existingExperience.endDate : null;
    bool isCurrent = isEditing ? existingExperience.isCurrent : true;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            Future<void> selectDate(bool isStartDate) async {
              final now = DateTime.now();
              final firstDate = DateTime(1960);
              final initialDate =
                  isStartDate ? (startDate ?? now) : (endDate ?? now);

              final DateTime? picked = await showDatePicker(
                context: context,
                initialDate: initialDate,
                firstDate: firstDate,
                lastDate: now,
                // ✅ NEW: Start the picker in year view for faster navigation
                initialDatePickerMode: DatePickerMode.year,
              );

              if (picked != null) {
                setDialogState(() {
                  if (isStartDate) {
                    startDate = picked;
                    if (endDate != null && endDate!.isBefore(startDate!)) {
                      endDate = startDate;
                    }
                  } else {
                    if (startDate != null && picked.isBefore(startDate!)) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: const Text(
                                'End date cannot be before start date.'),
                            backgroundColor:
                                Theme.of(context).colorScheme.error),
                      );
                    } else {
                      endDate = picked;
                    }
                  }
                });
              }
            }

            return AlertDialog(
              title: Text(isEditing ? 'Edit Experience' : 'Add Experience'),
              content: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      EnglishOnlyTextField(
                          controller: positionController,
                          labelText: 'Position / Job Title',
                          validator: (v) => v!.isEmpty ? 'Required' : null),
                      const SizedBox(height: 12),
                      EnglishOnlyTextField(
                          controller: companyController,
                          labelText: 'Company Name',
                          validator: (v) => v!.isEmpty ? 'Required' : null),
                      const SizedBox(height: 16),
                      _buildDialogDatePicker(context, 'Start Date', startDate,
                          () => selectDate(true)),
                      const SizedBox(height: 12),
                      _buildDialogDatePicker(
                          context, 'End Date', endDate, () => selectDate(false),
                          enabled: !isCurrent),
                      CheckboxListTile(
                        title: const Text('I currently work here'),
                        value: isCurrent,
                        onChanged: (value) {
                          setDialogState(() {
                            isCurrent = value ?? false;
                            if (isCurrent) {
                              endDate = null;
                            } else {
                              endDate = endDate ?? DateTime.now();
                            }
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                        contentPadding: EdgeInsets.zero,
                      ),
                      const SizedBox(height: 12),
                      EnglishOnlyTextField(
                          controller: descriptionController,
                          labelText: 'Description',
                          maxLines: 3),
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate() && startDate != null) {
                      final notifier = ref.read(cvFormProvider.notifier);
                      final finalEndDate = isCurrent ? null : endDate;

                      if (isEditing) {
                        final updatedExperience = existingExperience.copyWith(
                            companyName: companyController.text,
                            position: positionController.text,
                            description: descriptionController.text,
                            startDate: startDate,
                            endDate: finalEndDate,
                            isCurrent: isCurrent);
                        notifier.updateExperience(index!, updatedExperience);
                      } else {
                        notifier.addExperience(
                          position: positionController.text,
                          companyName: companyController.text,
                          description: descriptionController.text,
                          startDate: startDate!,
                          endDate: finalEndDate,
                        );
                      }
                      Navigator.of(context).pop();
                    } else if (startDate == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: const Text('Please select a start date.'),
                            backgroundColor:
                                Theme.of(context).colorScheme.error),
                      );
                    }
                  },
                  child: const Text('Save'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildDialogDatePicker(
      BuildContext context, String label, DateTime? date, VoidCallback onTap,
      {bool enabled = true}) {
    // ✅ UPDATED: Formatter now shows Month and Year for better display
    final formatter = DateFormat('MMMM yyyy');
    final theme = Theme.of(context);
    return InkWell(
      onTap: enabled ? onTap : null,
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          enabled: enabled,
        ),
        child: Text(
          date != null ? formatter.format(date) : 'Select Date',
          style: TextStyle(
            color: enabled
                ? theme.textTheme.bodyLarge?.color
                : theme.disabledColor,
          ),
        ),
      ),
    );
  }
}
