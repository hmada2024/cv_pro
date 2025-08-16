// lib/features/cv_form/ui/widgets/project_status_header.dart
import 'package:cv_pro/core/constants/app_sizes.dart';
import 'package:cv_pro/features/cv_form/data/providers/cv_form_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProjectStatusHeader extends ConsumerWidget
    implements PreferredSizeWidget {
  const ProjectStatusHeader({super.key});

  Widget _buildSectionIcon(
      BuildContext context, IconData icon, bool isComplete) {
    final theme = Theme.of(context);

    // AnimatedSwitcher provides a smooth cross-fade transition
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (child, animation) {
        return FadeTransition(opacity: animation, child: child);
      },
      child: Icon(
        icon,
        key:
            ValueKey<bool>(isComplete), // Key is important for AnimatedSwitcher
        size: AppSizes.iconSizeMedium,
        color: isComplete
            ? theme.colorScheme.primary
            : theme.disabledColor.withOpacity(0.5),
      ),
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
          const SizedBox(width: AppSizes.p16),
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
          const SizedBox(width: AppSizes.p12),
          _buildSectionIcon(
              context, Icons.language, cvData.languages.isNotEmpty),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50.0);
}
