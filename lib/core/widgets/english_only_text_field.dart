// lib/core/widgets/english_only_text_field.dart

import 'package:flutter/material.dart';

///
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

  @override
  Widget build(BuildContext context) {
    // هذا التعبير النمطي يبحث عن أي حرف *ليس* من ضمن المجموعة المسموح بها.
    final disallowedCharactersRegex = RegExp(r"[^a-zA-Z0-9\s.,-@()/#&+:']");

    return TextFormField(
      controller: controller,
      focusNode: focusNode, // Pass focus node
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        prefixIcon: prefixIcon,
      ),
      keyboardType: keyboardType,
      maxLines: maxLines,
      textInputAction: textInputAction,
      validator: (value) {
        if (value != null && disallowedCharactersRegex.hasMatch(value)) {
          // إذا وجد أي حرف غير مسموح به، أظهر رسالة الخطأ هذه.
          return 'Please use English characters and numbers only.';
        }
        // إذا كانت كل الأحرف مسموح بها، فلا يوجد خطأ.
        return null;
      },
      // Automatically validate as the user types for immediate feedback.
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }
}
