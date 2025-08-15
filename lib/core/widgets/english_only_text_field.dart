// lib/core/widgets/english_only_text_field.dart

import 'package:flutter/material.dart';

class EnglishOnlyTextField extends StatelessWidget {
  const EnglishOnlyTextField({
    super.key,
    this.controller,
    this.labelText,
    this.hintText,
    this.maxLines = 1,
    this.keyboardType,
    this.textInputAction,
    this.onChanged,
    this.prefixIcon,
    this.onFieldSubmitted,
    this.focusNode,
    this.validator,
    this.enabled,
    this.autofocus = false,
  });

  final TextEditingController? controller;
  final String? labelText;
  final String? hintText;
  final int maxLines;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onChanged;
  final Widget? prefixIcon;
  final ValueChanged<String>? onFieldSubmitted;
  final FocusNode? focusNode;
  final FormFieldValidator<String>? validator;
  final bool? enabled;
  final bool autofocus;

  @override
  Widget build(BuildContext context) {
    final disallowedCharactersRegex = RegExp(r"[^a-zA-Z0-9\s.,\-@()/#&+:’\']");

    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      enabled: enabled,
      autofocus: autofocus,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        prefixIcon: prefixIcon,
      ),
      keyboardType: keyboardType,
      maxLines: maxLines,
      textInputAction: textInputAction,
      validator: (value) {
        if (validator != null) {
          final externalValidationResult = validator!(value);
          if (externalValidationResult != null) {
            return externalValidationResult; // Return external error immediately.
          }
        }

        // If the external validator passes, run the internal English-only check.
        if (value != null && disallowedCharactersRegex.hasMatch(value)) {
          return 'Please use English characters and numbers only.';
        }
        return null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }
}
