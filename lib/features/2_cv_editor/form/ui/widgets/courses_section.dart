// lib/features/2_cv_editor/form/ui/widgets/courses_section.dart
import 'package:cv_pro/core/constants/app_sizes.dart';
import 'package:cv_pro/core/widgets/empty_state_widget.dart';
import 'package:cv_pro/core/widgets/english_only_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cv_pro/features/2_cv_editor/form/data/models/cv_data.dart';
import 'package:cv_pro/features/2_cv_editor/form/data/providers/cv_form_provider.dart';
import 'package:intl/intl.dart';

class CoursesSection extends ConsumerWidget {
  const CoursesSection({super.key});

  void _showCourseForm(BuildContext context, WidgetRef ref,
      {Course? course, int? index}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.8,
        builder: (_, scrollController) =>
            _CourseForm(course: course, index: index),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cvData = ref.watch(activeCvProvider);
    if (cvData == null) return const SizedBox.shrink();

    final courses = cvData.courses;
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.p20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Icon(Icons.menu_book_outlined,
                    color: theme.colorScheme.secondary),
                const SizedBox(width: AppSizes.p8),
                Text('Courses & Certifications',
                    style: theme.textTheme.titleLarge),
                const SizedBox(width: AppSizes.p8),
                if (courses.isNotEmpty)
                  Icon(Icons.check_circle,
                      color: Colors.green.shade600, size: 18),
              ],
            ),
            const SizedBox(height: AppSizes.p16),
            if (courses.isEmpty)
              const EmptyStateWidget(
                icon: Icons.school_outlined,
                title: 'Add your courses',
                subtitle:
                    'List relevant courses and certifications you have completed.',
              )
            else
              ReorderableListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: courses.length,
                itemBuilder: (context, index) {
                  final course = courses[index];
                  return _buildCourseCard(context, ref, course, index,
                      key: ValueKey(course.hashCode));
                },
                onReorder: (oldIndex, newIndex) {
                  ref
                      .read(activeCvProvider.notifier)
                      .reorderCourse(oldIndex, newIndex);
                },
              ),
            const SizedBox(height: AppSizes.p16),
            courses.isEmpty
                ? ElevatedButton.icon(
                    onPressed: () => _showCourseForm(context, ref),
                    icon: const Icon(Icons.add),
                    label: const Text('Add First Course'),
                  )
                : OutlinedButton.icon(
                    onPressed: () => _showCourseForm(context, ref),
                    icon: const Icon(Icons.add),
                    label: const Text('Add New Course'),
                  ),
          ],
        ),
      ),
    );
  }

  Widget _buildCourseCard(
      BuildContext context, WidgetRef ref, Course course, int index,
      {required Key key}) {
    final theme = Theme.of(context);
    final formatter = DateFormat('MMM yyyy');
    final dateText =
        course.isCurrent ? "Ongoing" : formatter.format(course.completionDate!);
    final subtitle = '${course.institution} • $dateText';

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
        title: Text(course.name, style: theme.textTheme.titleMedium),
        subtitle: Text(subtitle, style: theme.textTheme.bodyMedium),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon:
                  Icon(Icons.edit_outlined, color: theme.colorScheme.secondary),
              onPressed: () =>
                  _showCourseForm(context, ref, course: course, index: index),
              tooltip: 'Edit Course',
            ),
            IconButton(
              icon: Icon(Icons.delete_outline, color: theme.colorScheme.error),
              onPressed: () {
                ref.read(activeCvProvider.notifier).removeCourse(index);
              },
              tooltip: 'Delete Course',
            ),
          ],
        ),
      ),
    );
  }
}

class _CourseForm extends ConsumerStatefulWidget {
  final Course? course;
  final int? index;

  const _CourseForm({this.course, this.index});

  @override
  ConsumerState<_CourseForm> createState() => _CourseFormState();
}

class _CourseFormState extends ConsumerState<_CourseForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _institutionController = TextEditingController();
  final _descriptionController = TextEditingController();

  DateTime? _completionDate;
  bool _isCurrent = false;
  final DateFormat _dateFormatter = DateFormat('MMMM yyyy');

  @override
  void initState() {
    super.initState();
    if (widget.course != null) {
      _nameController.text = widget.course!.name;
      _institutionController.text = widget.course!.institution;
      _descriptionController.text = widget.course!.description ?? '';
      _completionDate = widget.course!.completionDate;
      _isCurrent = widget.course!.isCurrent;
    } else {
      _completionDate = DateTime.now();
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _institutionController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    final now = DateTime.now();
    final firstDate = DateTime(1980);
    final picked = await showDatePicker(
      context: context,
      initialDate: _completionDate ?? now,
      firstDate: firstDate,
      lastDate: now,
    );
    if (picked != null) {
      setState(() {
        _completionDate = picked;
      });
    }
  }

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      final notifier = ref.read(activeCvProvider.notifier);
      final newCourse = Course.create(
        name: _nameController.text,
        institution: _institutionController.text,
        description: _descriptionController.text.isNotEmpty
            ? _descriptionController.text
            : null,
        completionDate: _isCurrent ? null : _completionDate,
      );

      if (widget.index != null) {
        notifier.updateCourse(widget.index!, newCourse);
      } else {
        notifier.addCourse(newCourse);
      }
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isEditing = widget.course != null;

    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.fromLTRB(AppSizes.p16, AppSizes.p16, AppSizes.p16,
            MediaQuery.of(context).viewInsets.bottom + AppSizes.p16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                isEditing ? 'Edit Course' : 'Add New Course',
                style: theme.textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSizes.p24),
              EnglishOnlyTextField(
                controller: _nameController,
                labelText: 'Course Name',
                validator: (v) => v!.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: AppSizes.p12),
              EnglishOnlyTextField(
                controller: _institutionController,
                labelText: 'Institution (e.g., Udemy)',
                validator: (v) => v!.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: AppSizes.p16),
              InkWell(
                onTap: _isCurrent ? null : _selectDate,
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: 'Completion Date',
                    enabled: !_isCurrent,
                  ),
                  child: Text(
                    _completionDate != null
                        ? _dateFormatter.format(_completionDate!)
                        : 'Select Date',
                    style: TextStyle(
                      color: _isCurrent ? theme.disabledColor : null,
                    ),
                  ),
                ),
              ),
              CheckboxListTile(
                title: const Text('I am currently taking this course'),
                value: _isCurrent,
                onChanged: (value) {
                  setState(() {
                    _isCurrent = value ?? false;
                    if (_isCurrent) _completionDate = null;
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: EdgeInsets.zero,
              ),
              const SizedBox(height: AppSizes.p12),
              EnglishOnlyTextField(
                controller: _descriptionController,
                labelText: 'Description (Optional)',
                maxLines: 3,
              ),
              const SizedBox(height: AppSizes.p24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Cancel'),
                    ),
                  ),
                  const SizedBox(width: AppSizes.p8),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _saveForm,
                      child: const Text('Save'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
