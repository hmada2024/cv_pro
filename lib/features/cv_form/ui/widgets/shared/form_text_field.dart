// lib/features/cv_form/ui/widgets/shared/form_text_field.dart
import 'package:cv_pro/core/widgets/english_only_text_field.dart';
import 'package:flutter/material.dart';

class FormTextField extends StatelessWidget {
  const FormTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.iconData,
    required this.focusNode,
    required this.onChanged,
    this.keyboardType,
    this.maxLines = 1,
  });

  final TextEditingController controller;
  final String label;
  final IconData iconData;
  final FocusNode focusNode;
  final ValueChanged<String> onChanged;
  final TextInputType? keyboardType;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // The focus state is managed directly here.
    final bool isFocused = focusNode.hasFocus;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: EnglishOnlyTextField(
        controller: controller,
        focusNode: focusNode,
        labelText: label,
        prefixIcon: Icon(
          iconData,
          color: isFocused
              ? theme.colorScheme.primary
              : theme.colorScheme.onSurface.withOpacity(0.6),
        ),
        keyboardType: keyboardType,
        maxLines: maxLines,
        onChanged: onChanged,
      ),
    );
  }
}
