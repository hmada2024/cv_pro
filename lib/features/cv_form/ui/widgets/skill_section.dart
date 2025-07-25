import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cv_pro/features/cv_form/data/models/cv_data.dart';
import 'package:cv_pro/features/cv_form/data/providers/cv_form_provider.dart';

class SkillSection extends ConsumerStatefulWidget {
  const SkillSection({super.key});

  @override
  ConsumerState<SkillSection> createState() => _SkillSectionState();
}

class _SkillSectionState extends ConsumerState<SkillSection> {
  final _skillController = TextEditingController();

  @override
  void dispose() {
    _skillController.dispose();
    super.dispose();
  }

  // ✅ تم تعديل هذه الدالة لتقرأ من الـ controller مباشرة
  void _addSkill() {
    final value = _skillController.text;
    if (value.isNotEmpty) {
      ref.read(cvFormProvider.notifier).addSkill(Skill(name: value));
      _skillController.clear();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Skill Added: $value')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final skills = ref.watch(cvFormProvider).skills;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Skills', style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 10),
        TextFormField(
          controller: _skillController,
          decoration:
              const InputDecoration(labelText: 'Skill Name (e.g., Flutter)'),
          // onFieldSubmitted لا يزال يعمل كطريقة سريعة للإضافة
          onFieldSubmitted: (value) => _addSkill(),
        ),

        // ✅✅✅ هذا هو الزر الجديد الذي سيحل المشكلة ✅✅✅
        const SizedBox(height: 10),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _addSkill, // استدعاء الدالة عند الضغط
            child: const Text('Add Skill'),
          ),
        ),

        const SizedBox(height: 10),
        Wrap(
          spacing: 8.0,
          runSpacing: 4.0,
          children:
              skills.map((skill) => Chip(label: Text(skill.name))).toList(),
        ),
      ],
    );
  }
}
