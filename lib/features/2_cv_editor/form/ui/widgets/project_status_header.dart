// lib/features/cv_form/ui/widgets/project_status_header.dart
import 'package:cv_pro/core/constants/app_sizes.dart';
import 'package:cv_pro/features/2_cv_editor/form/data/providers/cv_form_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProjectStatusHeader extends ConsumerWidget
    implements PreferredSizeWidget {
  const ProjectStatusHeader({super.key});

  Widget _buildSectionIcon(
      BuildContext context, IconData icon, bool isComplete) {
    final theme = Theme.of(context);

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (child, animation) {
        return FadeTransition(opacity: animation, child: child);
      },
      child: Icon(
        icon,
        key: ValueKey<bool>(isComplete),
        size: AppSizes.iconSizeMedium,
        color: isComplete
            ? theme.colorScheme.primary
            : theme.disabledColor.withOpacity(0.5),
      ),
    );
  }

  Widget _buildSaveStatusIndicator(
      BuildContext context, WidgetRef ref, ThemeData theme) {
    final saveStatus = ref.watch(saveStatusProvider);

    Widget child = const SizedBox.shrink(); // Initialize with a default value
    switch (saveStatus) {
      case SaveStatus.saving:
        child = Row(
          key: const ValueKey('saving'),
          children: [
            const SizedBox(
                width: 14,
                height: 14,
                child: CircularProgressIndicator(strokeWidth: 2)),
            const SizedBox(width: 8),
            Text("Saving...", style: theme.textTheme.bodySmall),
          ],
        );
        break;
      case SaveStatus.saved:
        child = Row(
          key: const ValueKey('saved'),
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 16),
            const SizedBox(width: 8),
            Text("Saved", style: theme.textTheme.bodySmall),
          ],
        );
        break;
      case SaveStatus.idle:
        child = const SizedBox(key: ValueKey('idle'), height: 16);
        break;
    }
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return FadeTransition(
          opacity: animation,
          child: SizeTransition(
            sizeFactor: animation,
            axis: Axis.horizontal,
            child: child,
          ),
        );
      },
      child: child,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final cvData = ref.watch(activeCvProvider);

    if (cvData == null) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.p16, vertical: AppSizes.p8),
      decoration: BoxDecoration(
        color: theme.appBarTheme.backgroundColor,
        border:
            Border(bottom: BorderSide(color: theme.dividerColor, width: 1.0)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              cvData.projectName,
              style: theme.textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: AppSizes.p8),
          _buildSaveStatusIndicator(context, ref, theme),
          const Spacer(),
          _buildSectionIcon(context, Icons.person_outline,
              cvData.personalInfo.name.isNotEmpty),
          const SizedBox(width: AppSizes.p12),
          _buildSectionIcon(
              context, Icons.school_outlined, cvData.education.isNotEmpty),
          const SizedBox(width: AppSizes.p12),
          _buildSectionIcon(
              context, Icons.work_outline, cvData.experiences.isNotEmpty),
          const SizedBox(width: AppSizes.p12),
          _buildSectionIcon(
              context, Icons.star_border, cvData.skills.isNotEmpty),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50.0);
}
