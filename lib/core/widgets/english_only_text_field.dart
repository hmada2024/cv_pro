// lib/core/widgets/english_only_text_field.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// ويدجت مخصصة لحقل إدخال النص يسمح فقط بالأحرف الإنجليزية والأرقام
/// والنقطة والفاصلة.
///
/// تعمل هذه الويدجت على تبسيط إنشاء النماذج من خلال مركزية منطق فلترة المدخلات،
/// مما يضمن الاتساق عبر التطبيق والالتزام بمبدأ "لا تكرر نفسك".
class EnglishOnlyTextField extends StatelessWidget {
  const EnglishOnlyTextField({
    super.key,
    this.controller,
    this.labelText,
    this.hintText,
    this.validator,
    this.maxLines = 1,
    this.keyboardType,
    this.textInputAction,
    this.onChanged,
  });

  final TextEditingController? controller;
  final String? labelText;
  final String? hintText;
  final String? Function(String?)? validator;
  final int maxLines;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    // هذا التعبير النمطي يسمح بما يلي:
    // a-z, A-Z (الأحرف الإنجليزية)
    // 0-9 (الأرقام)
    // \s (المسافات)
    // . (النقطة) و , (الفاصلة)
    final allowedCharactersRegex = RegExp(r'[a-zA-Z0-9\s.,]');

    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        helperText: 'English Characters Only',
        border: const OutlineInputBorder(),
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      keyboardType: keyboardType,
      maxLines: maxLines,
      textInputAction: textInputAction,
      // تطبيق منسق الإدخال لفلترة الأحرف في الوقت الفعلي.
      inputFormatters: [
        FilteringTextInputFormatter.allow(allowedCharactersRegex),
      ],
      validator: validator,
    );
  }
}
