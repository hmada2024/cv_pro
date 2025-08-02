// features/cv_form/data/providers/cv_view_providers.dart

import 'package:cv_pro/features/cv_form/data/models/cv_data.dart';
import 'package:cv_pro/features/cv_form/data/providers/cv_form_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provides a sorted list of experiences for the UI.
/// Sorts by "current" first, then by end date (newest first).
final sortedExperiencesProvider = Provider<List<Experience>>((ref) {
  final experiences = ref.watch(cvFormProvider).experiences;
  final sortedList = List<Experience>.from(experiences);

  sortedList.sort((a, b) {
    // Current jobs come first
    if (a.isCurrent && !b.isCurrent) return -1;
    if (!a.isCurrent && b.isCurrent) return 1;

    // If both are past, sort by end date (newest first).
    if (!a.isCurrent && !b.isCurrent) {
      return b.endDate!.compareTo(a.endDate!);
    }

    // If both are current, sort by start date
    return b.startDate.compareTo(a.startDate);
  });

  return sortedList;
});

/// Provides a sorted list of education qualifications for the UI.
/// Sorts by academic level first (Doctorate > Master > Bachelor),
/// then by date for items of the same level.
final sortedEducationProvider = Provider<List<Education>>((ref) {
  final educationList = ref.watch(cvFormProvider).education;
  final sortedList = List<Education>.from(educationList);

  // Sort by level (Doctor > Master > Bachelor), then by end date
  sortedList.sort((a, b) {
    final levelComparison = b.level.index.compareTo(a.level.index);
    if (levelComparison != 0) return levelComparison;

    // If levels are the same, sort by date (newest first)
    if (a.isCurrent && !b.isCurrent) return -1;
    if (!a.isCurrent && b.isCurrent) return 1;

    if (!a.isCurrent && !b.isCurrent) {
      return b.endDate!.compareTo(a.endDate!);
    }

    // If both are current and same level, sort by start date
    return b.startDate.compareTo(a.startDate);
  });

  return sortedList;
});
