// features/cv_form/ui/widgets/cv_completion_progress.dart
import 'package:cv_pro/features/cv_form/data/providers/cv_view_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A widget that displays a progress bar indicating the completion
/// percentage of the user's CV.
class CvCompletionProgress extends ConsumerWidget
    implements PreferredSizeWidget {
  const CvCompletionProgress({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final completionPercentage = ref.watch(cvCompletionProvider);
    final theme = Theme.of(context);

    // Animate the progress change for a smoother user experience.
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      height: 4.0,
      child: LinearProgressIndicator(
        value: completionPercentage,
        backgroundColor: theme.dividerColor,
        valueColor: AlwaysStoppedAnimation<Color>(
          theme.colorScheme.primary,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(4.0);
}
