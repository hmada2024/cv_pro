// features/cv_form/data/providers/cv_view_providers.dart

import 'package:cv_pro/features/cv_form/data/models/cv_data.dart';
import 'package:cv_pro/features/cv_form/data/providers/cv_form_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// ✅ OPTIMIZED: Provides a sorted list of experiences.
/// Now uses `.select` to only listen for changes to the `experiences` list,
/// ignoring all other changes in the CV data, which prevents unnecessary recalculations.
final sortedExperiencesProvider = Provider<List<Experience>>((ref) {
  final experiences = ref.watch(cvFormProvider.select((cv) => cv.experiences));
  final sortedList = List<Experience>.from(experiences);

  sortedList.sort((a, b) {
    if (a.isCurrent && !b.isCurrent) return -1;
    if (!a.isCurrent && b.isCurrent) return 1;

    if (!a.isCurrent && !b.isCurrent) {
      return b.endDate!.compareTo(a.endDate!);
    }
    return b.startDate.compareTo(a.startDate);
  });

  return sortedList;
});

/// ✅ OPTIMIZED: Provides a sorted list of education qualifications.
/// Now uses `.select` to only listen for changes to the `education` list,
/// drastically improving performance.
final sortedEducationProvider = Provider<List<Education>>((ref) {
  final educationList = ref.watch(cvFormProvider.select((cv) => cv.education));
  final sortedList = List<Education>.from(educationList);

  sortedList.sort((a, b) {
    final levelComparison = b.level.index.compareTo(a.level.index);
    if (levelComparison != 0) return levelComparison;

    if (a.isCurrent && !b.isCurrent) return -1;
    if (!a.isCurrent && b.isCurrent) return 1;

    if (!a.isCurrent && !b.isCurrent) {
      return b.endDate!.compareTo(a.endDate!);
    }
    return b.startDate.compareTo(a.startDate);
  });

  return sortedList;
});

/// ✅ OPTIMIZED: Provider to calculate the completion percentage of the CV.
/// This provider is now highly efficient. It watches each condition separately.
/// It will only recalculate if one of the `.isNotEmpty` statuses actually changes,
/// not on every single keystroke.
final cvCompletionProvider = Provider<double>((ref) {
  const totalSections = 6;
  int completedSections = 0;

  // Each `watch` is now granular and efficient.
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
