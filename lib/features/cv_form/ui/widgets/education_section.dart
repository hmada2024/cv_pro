// features/cv_form/ui/widgets/education_section.dart

import 'package:cv_pro/core/widgets/english_only_text_field.dart';
import 'package:cv_pro/features/cv_form/data/providers/cv_view_providers.dart'; // ✅ UPDATED IMPORT
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

  final DateFormat _dateFormatter = DateFormat('MMMM yyyy');

  @override
  void dispose() {
    _degreeNameController.dispose();
    _schoolController.dispose();
    super.dispose();
  }

  String _educationLevelToString(EducationLevel level) {
    switch (level) {
      case EducationLevel.bachelor:
        return 'Bachelor';
      case EducationLevel.master:
        return 'Master';
      case EducationLevel.doctor:
        return 'Doctorate';
    }
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
        const SnackBar(
            content: Text('Please select a start date.'),
            backgroundColor: Colors.red),
      );
    }
  }

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final now = DateTime.now();
    final firstDate = DateTime(1960);
    final initialDate = isStartDate ? (_startDate ?? now) : (_endDate ?? now);

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: now,
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
              const SnackBar(
                  content: Text('End date cannot be before start date.'),
                  backgroundColor: Colors.red),
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
    final educationList = ref.watch(sortedEducationProvider);

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
                  const Icon(Icons.school, color: Colors.blueGrey),
                  const SizedBox(width: 8),
                  Text('Education',
                      style: Theme.of(context).textTheme.titleLarge),
                ],
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<EducationLevel>(
                value: _selectedLevel,
                decoration:
                    const InputDecoration(labelText: 'Qualification Level'),
                items: EducationLevel.values
                    .map((level) => DropdownMenuItem(
                          value: level,
                          child: Text(_educationLevelToString(level)),
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
                        _buildDatePickerField('Start Date', _startDate, true),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildDatePickerField('End Date', _endDate, false),
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
                activeColor: Theme.of(context).primaryColor,
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: _addEducation,
                child: const Text('Add Education'),
              ),
              if (educationList.isNotEmpty) const SizedBox(height: 16),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: educationList.length,
                itemBuilder: (context, index) {
                  final edu = educationList[index];
                  final originalIndex =
                      ref.read(cvFormProvider).education.indexOf(edu);
                  return _buildEducationCard(edu, originalIndex);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDatePickerField(String label, DateTime? date, bool isStart) {
    return InkWell(
      onTap: () {
        if (!isStart && _isCurrent) return;
        _selectDate(context, isStart);
      },
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          enabled: isStart || !_isCurrent,
        ),
        child: Text(
          date != null ? _dateFormatter.format(date) : 'Select Date',
          style: TextStyle(
            color: (isStart || !_isCurrent)
                ? Theme.of(context).textTheme.bodyLarge?.color
                : Colors.grey,
          ),
        ),
      ),
    );
  }

  Widget _buildEducationCard(Education edu, int index) {
    final title = '${_educationLevelToString(edu.level)} ${edu.degreeName}';
    final subtitle =
        '${edu.school}\n${_dateFormatter.format(edu.startDate)} - ${edu.isCurrent ? "Present" : _dateFormatter.format(edu.endDate!)}';

    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 8.0),
      child: ListTile(
        leading: const Icon(Icons.menu_book, color: Colors.purple),
        title: Text(title, style: Theme.of(context).textTheme.titleMedium),
        subtitle: Text(subtitle, style: Theme.of(context).textTheme.bodyMedium),
        isThreeLine: true,
        trailing: IconButton(
          icon: Icon(Icons.delete_outline,
              color: Theme.of(context).colorScheme.error),
          onPressed: () {
            ref.read(cvFormProvider.notifier).removeEducation(index);
          },
        ),
      ),
    );
  }
}
