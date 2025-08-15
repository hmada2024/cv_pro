// features/cv_form/data/providers/cv_view_providers.dart
import 'package:cv_pro/features/cv_form/data/providers/cv_form_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final cvCompletionProvider = Provider<double>((ref) {
  const totalSections = 6;
  int completedSections = 0;

  if (ref
      .watch(cvFormProvider.select((cv) => cv.personalInfo.name.isNotEmpty))) {
    completedSections++;
  }
  if (ref.watch(cvFormProvider.select((cv) => cv.education.isNotEmpty))) {
    completedSections++;
  }
  if (ref.watch(cvFormProvider.select((cv) => cv.experiences.isNotEmpty))) {
    completedSections++;
  }
  if (ref.watch(cvFormProvider.select((cv) => cv.skills.isNotEmpty))) {
    completedSections++;
  }
  if (ref.watch(cvFormProvider.select((cv) => cv.languages.isNotEmpty))) {
    completedSections++;
  }
  if (ref.watch(cvFormProvider.select((cv) => cv.references.isNotEmpty))) {
    completedSections++;
  }

  return completedSections / totalSections;
});
