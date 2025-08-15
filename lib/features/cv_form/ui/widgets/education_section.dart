// features/cv_form/ui/widgets/education_section.dart
import 'package:cv_pro/core/widgets/english_only_text_field.dart';
import 'package:cv_pro/features/cv_form/data/providers/cv_view_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cv_pro/features/cv_form/data/models/cv_data.dart';
import 'package:cv_pro/features/cv_form/data/providers/cv_form_provider.dart';
import 'package:intl/intl.dart';

class EducationSection extends ConsumerStatefulWidget {
  const EducationSection({super.key});

  @override
  ConsumerState<EducationSection> createState() => _EducationSectionState();
}

class _EducationSectionState extends ConsumerState<EducationSection> {
  final _formKey = GlobalKey<FormState>();
  final _degreeNameController = TextEditingController();
  final _schoolController = TextEditingController();

  EducationLevel _selectedLevel = EducationLevel.bachelor;
  DateTime? _startDate;
  DateTime? _endDate;
  bool _isCurrent = true;

  final DateFormat _dateFormatter = DateFormat('yyyy');

  @override
  void dispose() {
    _degreeNameController.dispose();
    _schoolController.dispose();
    super.dispose();
  }

  void _addEducation() {
    if (_formKey.currentState!.validate() && _startDate != null) {
      ref.read(cvFormProvider.notifier).addEducation(
            level: _selectedLevel,
            degreeName: _degreeNameController.text,
            school: _schoolController.text,
            startDate: _startDate!,
            endDate: _isCurrent ? null : _endDate,
          );
      // Reset form
      _formKey.currentState!.reset();
      _degreeNameController.clear();
      _schoolController.clear();
      setState(() {
        _selectedLevel = EducationLevel.bachelor;
        _startDate = null;
        _endDate = null;
        _isCurrent = true;
      });
    } else if (_startDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: const Text('Please select a start date.'),
            backgroundColor: Theme.of(context).colorScheme.error),
      );
    }
  }

  Future<void> _selectYear(BuildContext context, bool isStartDate) async {
    final now = DateTime.now();
    final firstDate = DateTime(1960);
    final lastYear = DateTime(now.year - 1, now.month, now.day);
    final initialDate = isStartDate
        ? (_startDate ?? lastYear) // Smart Default
        : (_endDate ?? now);

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
    final educationList = ref.watch(sortedEducationProvider);
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Icon(Icons.school, color: theme.colorScheme.secondary),
                  const SizedBox(width: 8),
                  Text('Education', style: theme.textTheme.titleLarge),
                ],
              ),
              const SizedBox(height: 16),
              // Enhanced Empty State
              if (educationList.isEmpty)
                const _EmptyStateWidget(
                  icon: Icons.school_outlined,
                  title: 'Add your first qualification',
                  subtitle:
                      'Your academic background is a key part of your CV.',
                ),
              if (educationList.isNotEmpty)
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: educationList.length,
                  itemBuilder: (context, index) {
                    final edu = educationList[index];
                    final originalIndex =
                        ref.read(cvFormProvider).education.indexOf(edu);
                    return _buildEducationCard(
                        context, theme, edu, originalIndex);
                  },
                ),
              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 16),
              Text('Add New Qualification', style: theme.textTheme.titleMedium),
              const SizedBox(height: 16),
              DropdownButtonFormField<EducationLevel>(
                value: _selectedLevel,
                decoration:
                    const InputDecoration(labelText: 'Qualification Level'),
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
              const SizedBox(height: 12),
              EnglishOnlyTextField(
                controller: _degreeNameController,
                labelText: 'Degree Name (e.g., of Computer Science)',
                validator: (val) => (val?.isEmpty ?? true) ? 'Required' : null,
              ),
              const SizedBox(height: 12),
              EnglishOnlyTextField(
                controller: _schoolController,
                labelText: 'School / University',
                validator: (val) => (val?.isEmpty ?? true) ? 'Required' : null,
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child:
                        _buildDatePickerField('Start Year', _startDate, true),
                  ),
                  const SizedBox(width: 12),
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
              const SizedBox(height: 8),
              ElevatedButton.icon(
                onPressed: _addEducation,
                icon: const Icon(Icons.add),
                label: const Text('Add Education'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDatePickerField(String label, DateTime? date, bool isStart) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: () {
        if (!isStart && _isCurrent) return;
        _selectYear(context, isStart);
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
      BuildContext context, ThemeData theme, Education edu, int index) {
    final title = '${edu.level.toDisplayString()} ${edu.degreeName}';
    final subtitle =
        '${edu.school}\n${_dateFormatter.format(edu.startDate)} - ${edu.isCurrent ? "Present" : _dateFormatter.format(edu.endDate!)}';

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: theme.dividerColor, width: 1),
        borderRadius: BorderRadius.circular(8.0),
      ),
      margin: const EdgeInsets.only(bottom: 8.0),
      child: ListTile(
        leading: Icon(Icons.menu_book, color: theme.colorScheme.primary),
        title: Text(title, style: theme.textTheme.titleMedium),
        subtitle: Text(subtitle, style: theme.textTheme.bodyMedium),
        isThreeLine: true,
        trailing: IconButton(
          icon: Icon(Icons.delete_outline, color: theme.colorScheme.error),
          onPressed: () {
            ref.read(cvFormProvider.notifier).removeEducation(index);
          },
        ),
      ),
    );
  }
}

class _EmptyStateWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _EmptyStateWidget({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        children: [
          Icon(icon, size: 48, color: theme.colorScheme.secondary),
          const SizedBox(height: 12),
          Text(
            title,
            style: theme.textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: theme.textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
