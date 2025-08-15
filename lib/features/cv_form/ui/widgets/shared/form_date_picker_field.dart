// lib/features/cv_form/ui/widgets/shared/form_date_picker_field.dart
import 'package:flutter/material.dart';

class FormDatePickerField extends StatelessWidget {
  const FormDatePickerField({
    super.key,
    required this.controller,
    required this.label,
    required this.icon,
    required this.onTap,
  });

  final TextEditingController controller;
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon:
              Icon(icon, color: theme.colorScheme.onSurface.withOpacity(0.6)),
        ),
        readOnly: true,
        onTap: onTap,
      ),
    );
  }
}
