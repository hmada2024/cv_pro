// features/cv_form/ui/widgets/experience_section.dart
import 'package:cv_pro/core/widgets/empty_state_widget.dart';
import 'package:cv_pro/core/widgets/english_only_text_field.dart';
import 'package:cv_pro/features/cv_form/data/providers/cv_view_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cv_pro/features/cv_form/data/models/cv_data.dart';
import 'package:cv_pro/features/cv_form/data/providers/cv_form_provider.dart';
import 'package:intl/intl.dart';

class ExperienceSection extends ConsumerStatefulWidget {
  const ExperienceSection({super.key});

  @override
  ConsumerState<ExperienceSection> createState() => _ExperienceSectionState();
}

class _ExperienceSectionState extends ConsumerState<ExperienceSection> {
  late GlobalKey<FormState> _formKey;
  final _positionController = TextEditingController();
  final _companyController = TextEditingController();
  final _descriptionController = TextEditingController();

  bool _isFormVisible = false;
  DateTime? _startDate;
  DateTime? _endDate;
  bool _isCurrent = true;

  int? _editingIndex;
  Experience? _existingExperience;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    _positionController.dispose();
    _companyController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _showForm({Experience? experience, int? index}) {
    setState(() {
      _formKey = GlobalKey<FormState>();
      if (experience != null && index != null) {
        _editingIndex = index;
        _existingExperience = experience;
        _positionController.text = experience.position;
        _companyController.text = experience.companyName;
        _descriptionController.text = experience.description;
        _startDate = experience.startDate;
        _endDate = experience.endDate;
        _isCurrent = experience.isCurrent;
      } else {
        _editingIndex = null;
        _existingExperience = null;
        final now = DateTime.now();
        _startDate = DateTime(now.year - 1, now.month, now.day);
        _endDate = null;
        _isCurrent = true;
      }
      _isFormVisible = true;
    });
  }

  void _hideAndResetForm() {
    setState(() {
      _isFormVisible = false;
      _positionController.clear();
      _companyController.clear();
      _descriptionController.clear();
      _editingIndex = null;
      _existingExperience = null;
    });
  }

  void _saveExperience() {
    if (_formKey.currentState!.validate() && _startDate != null) {
      final notifier = ref.read(cvFormProvider.notifier);
      final finalEndDate = _isCurrent ? null : _endDate;

      if (_editingIndex != null && _existingExperience != null) {
        final updatedExperience = _existingExperience!.copyWith(
          companyName: _companyController.text,
          position: _positionController.text,
          description: _descriptionController.text,
          startDate: _startDate,
          endDate: finalEndDate,
          isCurrent: _isCurrent,
        );
        notifier.updateExperience(_editingIndex!, updatedExperience);
      } else {
        notifier.addExperience(
          position: _positionController.text,
          companyName: _companyController.text,
          description: _descriptionController.text,
          startDate: _startDate!,
          endDate: finalEndDate,
        );
      }
      _hideAndResetForm();
    } else if (_startDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: const Text('Please select a start date.'),
            backgroundColor: Theme.of(context).colorScheme.error),
      );
    }
  }

  Future<void> _selectDate(bool isStartDate) async {
    final now = DateTime.now();
    final firstDate = DateTime(1960);
    final initialDate = isStartDate ? (_startDate ?? now) : (_endDate ?? now);

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: now,
      initialDatePickerMode: DatePickerMode.year,
    );

    if (picked != null) {
      setState(() {
        if (isStartDate) {
          _startDate = picked;
          if (_endDate != null && _endDate!.isBefore(_startDate!)) {
            _endDate = _startDate;
          }
        } else {
          if (_startDate != null && picked.isBefore(_startDate!)) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: const Text('End date cannot be before start date.'),
                  backgroundColor: Theme.of(context).colorScheme.error),
            );
          } else {
            _endDate = picked;
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
            if (experiences.isNotEmpty) const SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: experiences.length,
              itemBuilder: (context, index) {
                final exp = experiences[index];
                final originalIndex =
                    ref.read(cvFormProvider).experiences.indexOf(exp);
                return _buildExperienceCard(context, exp, originalIndex);
              },
            ),
            if (_isFormVisible)
              _buildFormFields(theme)
            else ...[
              if (experiences.isEmpty) ...[
                const Padding(
                  padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
                  child: EmptyStateWidget(
                    icon: Icons.work_outline,
                    title: 'Add your first work experience',
                    subtitle:
                        'This is the most important section for recruiters.',
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () => _showForm(),
                  icon: const Icon(Icons.add),
                  label: const Text('Add First Experience'),
                ),
              ] else ...[
                const SizedBox(height: 16),
                OutlinedButton.icon(
                  onPressed: () => _showForm(),
                  icon: const Icon(Icons.add),
                  label: const Text('Add New Experience'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ],
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildFormFields(ThemeData theme) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Divider(height: 32),
          Text(
            _editingIndex == null ? 'Add New Experience' : 'Edit Experience',
            style: theme.textTheme.titleMedium,
          ),
          const SizedBox(height: 16),
          EnglishOnlyTextField(
              controller: _positionController,
              labelText: 'Position / Job Title',
              validator: (v) => v!.isEmpty ? 'Required' : null),
          const SizedBox(height: 12),
          EnglishOnlyTextField(
              controller: _companyController,
              labelText: 'Company Name',
              validator: (v) => v!.isEmpty ? 'Required' : null),
          const SizedBox(height: 16),
          _buildDatePicker('Start Date', _startDate, () => _selectDate(true)),
          const SizedBox(height: 12),
          _buildDatePicker('End Date', _endDate, () => _selectDate(false),
              enabled: !_isCurrent),
          CheckboxListTile(
            title: const Text('I currently work here'),
            value: _isCurrent,
            onChanged: (value) {
              setState(() {
                _isCurrent = value ?? false;
                if (_isCurrent) {
                  _endDate = null;
                } else {
                  _endDate = _endDate ?? DateTime.now();
                }
              });
            },
            controlAffinity: ListTileControlAffinity.leading,
            contentPadding: EdgeInsets.zero,
          ),
          const SizedBox(height: 12),
          EnglishOnlyTextField(
              controller: _descriptionController,
              labelText: 'Description (Achievements & Responsibilities)',
              maxLines: 4),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: _hideAndResetForm,
                  child: const Text('Cancel'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton(
                  onPressed: _saveExperience,
                  child: const Text('Save'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildExperienceCard(BuildContext context, Experience exp, int index) {
    final theme = Theme.of(context);
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
        leading:
            Icon(Icons.check_circle_outline, color: theme.colorScheme.primary),
        title: Text(exp.position, style: theme.textTheme.titleMedium),
        subtitle: Text('${exp.companyName}\n$dateRange',
            style: theme.textTheme.bodyMedium),
        isThreeLine: true,
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon:
                  Icon(Icons.edit_outlined, color: theme.colorScheme.secondary),
              onPressed: () => _showForm(experience: exp, index: index),
              tooltip: 'Edit Experience',
            ),
            IconButton(
              icon: Icon(Icons.delete_outline, color: theme.colorScheme.error),
              onPressed: () {
                ref.read(cvFormProvider.notifier).removeExperience(index);
              },
              tooltip: 'Delete Experience',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDatePicker(String label, DateTime? date, VoidCallback onTap,
      {bool enabled = true}) {
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
