// lib/features/cv_form/ui/widgets/education_section.dart
import 'package:cv_pro/core/constants/app_sizes.dart';
import 'package:cv_pro/core/widgets/empty_state_widget.dart';
import 'package:cv_pro/core/widgets/english_only_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cv_pro/features/form/data/models/cv_data.dart';
import 'package:cv_pro/features/form/data/providers/cv_form_provider.dart';
import 'package:intl/intl.dart';

class EducationSection extends ConsumerStatefulWidget {
  const EducationSection({super.key});

  @override
  ConsumerState<EducationSection> createState() => _EducationSectionState();
}

class _EducationSectionState extends ConsumerState<EducationSection> {
  late GlobalKey<FormState> _formKey;
  final _degreeNameController = TextEditingController();
  final _schoolController = TextEditingController();
  bool _isFormVisible = false;
  EducationLevel _selectedLevel = EducationLevel.bachelor;
  DateTime? _startDate;
  DateTime? _endDate;
  bool _isCurrent = true;
  final DateFormat _dateFormatter = DateFormat('yyyy');

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    _degreeNameController.dispose();
    _schoolController.dispose();
    super.dispose();
  }

  void _resetForm() {
    setState(() {
      _formKey = GlobalKey<FormState>();
      _degreeNameController.clear();
      _schoolController.clear();
      _selectedLevel = EducationLevel.bachelor;
      _startDate = null;
      _endDate = null;
      _isCurrent = true;
      _isFormVisible = false;
    });
  }

  void _addEducation() {
    if (_formKey.currentState!.validate() && _startDate != null) {
      final newEducation = Education.create(
        level: _selectedLevel,
        degreeName: _degreeNameController.text,
        school: _schoolController.text,
        startDate: _startDate!,
        endDate: _isCurrent ? null : _endDate,
      );
      ref.read(activeCvProvider.notifier).addEducation(newEducation);
      _resetForm();
    } else if (_startDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: const Text('Please select a start date.'),
            backgroundColor: Theme.of(context).colorScheme.error),
      );
    }
  }

  Future<void> _selectYear(bool isStartDate) async {
    final now = DateTime.now();
    final firstDate = DateTime(1960);
    final lastYear = DateTime(now.year - 1, now.month, now.day);
    final initialDate =
        isStartDate ? (_startDate ?? lastYear) : (_endDate ?? now);
    DateTime? pickedDate;
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(isStartDate ? 'Select Start Year' : 'Select End Year'),
          content: SizedBox(
            height: 300,
            width: 300,
            child: YearPicker(
              firstDate: firstDate,
              lastDate: now,
              selectedDate: initialDate,
              onChanged: (DateTime date) {
                pickedDate = date;
                Navigator.of(context).pop();
              },
            ),
          ),
        );
      },
    );
    if (pickedDate != null) {
      setState(() {
        if (isStartDate) {
          _startDate = pickedDate;
          if (_endDate != null && _endDate!.isBefore(_startDate!)) {
            _endDate = _startDate;
          }
        } else {
          if (_startDate != null && pickedDate!.isBefore(_startDate!)) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: const Text('End year cannot be before start year.'),
                  backgroundColor: Theme.of(context).colorScheme.error),
            );
          } else {
            _endDate = pickedDate;
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final cvData = ref.watch(activeCvProvider);
    if (cvData == null) return const SizedBox.shrink();

    final educationList = cvData.education;
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
                Icon(Icons.school, color: theme.colorScheme.secondary),
                const SizedBox(width: AppSizes.p8),
                Text('Education', style: theme.textTheme.titleLarge),
                const SizedBox(width: AppSizes.p8),
                if (educationList.isNotEmpty)
                  Icon(Icons.check_circle,
                      color: Colors.green.shade600, size: 18),
              ],
            ),
            const SizedBox(height: AppSizes.p16),
            if (educationList.isNotEmpty)
              ReorderableListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: educationList.length,
                itemBuilder: (context, index) {
                  final edu = educationList[index];
                  return _buildEducationCard(context, theme, edu, index,
                      key: ValueKey(edu.hashCode));
                },
                onReorder: (oldIndex, newIndex) {
                  ref
                      .read(activeCvProvider.notifier)
                      .reorderEducation(oldIndex, newIndex);
                },
              ),
            if (_isFormVisible)
              _buildFormFields(theme)
            else ...[
              if (educationList.isEmpty) ...[
                const EmptyStateWidget(
                  icon: Icons.school_outlined,
                  title: 'Add your first qualification',
                  subtitle:
                      'Your academic background is a key part of your CV.',
                ),
                const SizedBox(height: AppSizes.p16),
                ElevatedButton.icon(
                  onPressed: () => setState(() => _isFormVisible = true),
                  icon: const Icon(Icons.add),
                  label: const Text('Add First Qualification'),
                ),
              ] else ...[
                const SizedBox(height: AppSizes.p8),
                OutlinedButton.icon(
                  onPressed: () => setState(() => _isFormVisible = true),
                  icon: const Icon(Icons.add),
                  label: const Text('Add New Qualification'),
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
          Text('Add New Qualification', style: theme.textTheme.titleMedium),
          const SizedBox(height: AppSizes.p16),
          DropdownButtonFormField<EducationLevel>(
            value: _selectedLevel,
            decoration: const InputDecoration(labelText: 'Qualification Level'),
            items: EducationLevel.values
                .map((level) => DropdownMenuItem(
                      value: level,
                      child: Text(level.toDisplayString()),
                    ))
                .toList(),
            onChanged: (value) {
              if (value != null) {
                setState(() => _selectedLevel = value);
              }
            },
          ),
          const SizedBox(height: AppSizes.p12),
          EnglishOnlyTextField(
            controller: _degreeNameController,
            labelText: 'Degree Name (e.g., of Computer Science)',
            validator: (val) => (val?.isEmpty ?? true) ? 'Required' : null,
          ),
          const SizedBox(height: AppSizes.p12),
          EnglishOnlyTextField(
            controller: _schoolController,
            labelText: 'School / University',
            validator: (val) => (val?.isEmpty ?? true) ? 'Required' : null,
          ),
          const SizedBox(height: AppSizes.p12),
          Row(
            children: [
              Expanded(
                child: _buildDatePickerField('Start Year', _startDate, true),
              ),
              const SizedBox(width: AppSizes.p12),
              Expanded(
                child: _buildDatePickerField('End Year', _endDate, false),
              ),
            ],
          ),
          CheckboxListTile(
            title: const Text('I currently study here'),
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
            activeColor: theme.primaryColor,
          ),
          const SizedBox(height: AppSizes.p16),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: _resetForm,
                  child: const Text('Cancel'),
                ),
              ),
              const SizedBox(width: AppSizes.p8),
              Expanded(
                child: ElevatedButton(
                  onPressed: _addEducation,
                  child: const Text('Save'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDatePickerField(String label, DateTime? date, bool isStart) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: () {
        if (!isStart && _isCurrent) return;
        _selectYear(isStart);
      },
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          enabled: isStart || !_isCurrent,
        ),
        child: Text(
          date != null ? _dateFormatter.format(date) : 'Select Year',
          style: TextStyle(
            color: (isStart || !_isCurrent)
                ? theme.textTheme.bodyLarge?.color
                : theme.disabledColor,
          ),
        ),
      ),
    );
  }

  Widget _buildEducationCard(
      BuildContext context, ThemeData theme, Education edu, int index,
      {required Key key}) {
    final title = '${edu.level.toDisplayString()} ${edu.degreeName}';
    final subtitle =
        '${edu.school}\n${_dateFormatter.format(edu.startDate)} - ${edu.isCurrent ? "Present" : _dateFormatter.format(edu.endDate!)}';

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
        title: Text(title, style: theme.textTheme.titleMedium),
        subtitle: Text(subtitle, style: theme.textTheme.bodyMedium),
        isThreeLine: true,
        trailing: IconButton(
          icon: Icon(Icons.delete_outline, color: theme.colorScheme.error),
          onPressed: () {
            ref.read(activeCvProvider.notifier).removeEducation(index);
          },
        ),
      ),
    );
  }
}
