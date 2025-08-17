// lib/features/cv_form/ui/widgets/experience_section.dart
import 'package:cv_pro/core/constants/app_sizes.dart';
import 'package:cv_pro/core/widgets/empty_state_widget.dart';
import 'package:cv_pro/core/widgets/english_only_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cv_pro/features/2_cv_editor/form/data/models/cv_data.dart';
import 'package:cv_pro/features/2_cv_editor/form/data/providers/cv_form_provider.dart';
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
      final notifier = ref.read(activeCvProvider.notifier);
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
        final newExperience = Experience.create(
          position: _positionController.text,
          companyName: _companyController.text,
          description: _descriptionController.text,
          startDate: _startDate!,
          endDate: finalEndDate,
        );
        notifier.addExperience(newExperience);
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
    final cvData = ref.watch(activeCvProvider);
    if (cvData == null) return const SizedBox.shrink();

    final experiences = cvData.experiences;
    final theme = Theme.of(context);

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.cardRadius),
        side: _isFormVisible
            ? BorderSide(color: theme.colorScheme.primary, width: 1.5)
            : BorderSide.none,
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.p20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Icon(Icons.business_center, color: theme.colorScheme.secondary),
                const SizedBox(width: AppSizes.p8),
                Text('Work Experience', style: theme.textTheme.titleLarge),
                const SizedBox(width: AppSizes.p8),
                if (experiences.isNotEmpty)
                  Icon(Icons.check_circle,
                      color: Colors.green.shade600, size: 18),
              ],
            ),
            if (experiences.isNotEmpty) const SizedBox(height: AppSizes.p16),
            if (experiences.isNotEmpty)
              ReorderableListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: experiences.length,
                itemBuilder: (context, index) {
                  final exp = experiences[index];
                  return _buildExperienceCard(context, exp, index,
                      key: ValueKey(exp.hashCode));
                },
                onReorder: (oldIndex, newIndex) {
                  ref
                      .read(activeCvProvider.notifier)
                      .reorderExperience(oldIndex, newIndex);
                },
              ),
            if (_isFormVisible)
              _buildFormFields(theme)
            else ...[
              if (experiences.isEmpty) ...[
                const Padding(
                  padding:
                      EdgeInsets.only(top: AppSizes.p16, bottom: AppSizes.p16),
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
                const SizedBox(height: AppSizes.p16),
                OutlinedButton.icon(
                  onPressed: () => _showForm(),
                  icon: const Icon(Icons.add),
                  label: const Text('Add New Experience'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: AppSizes.p12),
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
          const Divider(height: AppSizes.p32),
          Text(
            _editingIndex == null ? 'Add New Experience' : 'Edit Experience',
            style: theme.textTheme.titleMedium,
          ),
          const SizedBox(height: AppSizes.p16),
          EnglishOnlyTextField(
              controller: _positionController,
              labelText: 'Position / Job Title',
              validator: (v) => v!.isEmpty ? 'Required' : null),
          const SizedBox(height: AppSizes.p12),
          EnglishOnlyTextField(
              controller: _companyController,
              labelText: 'Company Name',
              validator: (v) => v!.isEmpty ? 'Required' : null),
          const SizedBox(height: AppSizes.p16),
          _buildDatePicker('Start Date', _startDate, () => _selectDate(true)),
          const SizedBox(height: AppSizes.p12),
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
          const SizedBox(height: AppSizes.p12),
          EnglishOnlyTextField(
              controller: _descriptionController,
              labelText: 'Description (Achievements & Responsibilities)',
              maxLines: 4),
          const SizedBox(height: AppSizes.p16),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: _hideAndResetForm,
                  child: const Text('Cancel'),
                ),
              ),
              const SizedBox(width: AppSizes.p8),
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

  Widget _buildExperienceCard(BuildContext context, Experience exp, int index,
      {required Key key}) {
    final theme = Theme.of(context);
    final formatter = DateFormat('MMMM yyyy');
    final dateRange =
        '${formatter.format(exp.startDate)} - ${exp.isCurrent ? "Present" : formatter.format(exp.endDate!)}';

    return Card(
      key: key,
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: theme.dividerColor, width: 1),
        borderRadius: BorderRadius.circular(AppSizes.buttonRadius),
      ),
      margin: const EdgeInsets.only(bottom: AppSizes.p8),
      child: ListTile(
        leading: const Icon(Icons.drag_handle),
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
                ref.read(activeCvProvider.notifier).removeExperience(index);
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
