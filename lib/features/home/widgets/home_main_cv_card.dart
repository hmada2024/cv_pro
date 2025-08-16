// lib/features/home/ui/widgets/home_main_cv_card.dart
import 'package:cv_pro/core/constants/app_sizes.dart';
import 'package:cv_pro/core/theme/app_colors.dart';
import 'package:cv_pro/features/cv_form/data/providers/cv_form_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeMainCvCard extends ConsumerWidget {
  const HomeMainCvCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final cvData = ref.watch(activeCvProvider);
    final isNewUser = cvData == null || cvData.personalInfo.name.isEmpty;

    return Card(
      elevation: 0,
      color: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.cardRadius),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSizes.cardRadius),
          gradient: LinearGradient(
            colors: [
              theme.colorScheme.primary,
              AppColors.accentLight.withOpacity(0.8),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: theme.colorScheme.primary.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.p20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (isNewUser) ...[
                const Icon(Icons.add_circle_outline,
                    size: AppSizes.iconSizeLarge, color: Colors.white),
                const SizedBox(height: AppSizes.p12),
                Text(
                  'Start Building Your CV',
                  style: theme.textTheme.titleLarge
                      ?.copyWith(color: Colors.white, fontSize: 20),
                ),
                const SizedBox(height: AppSizes.p8),
                Text(
                  'Create a professional CV in minutes.',
                  style: theme.textTheme.bodyMedium
                      ?.copyWith(color: Colors.white.withOpacity(0.8)),
                ),
              ] else ...[
                Text(
                  cvData.personalInfo.name,
                  style: theme.textTheme.titleLarge
                      ?.copyWith(color: Colors.white, fontSize: 22),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                if (cvData.personalInfo.jobTitle.isNotEmpty) ...[
                  const SizedBox(height: AppSizes.p4),
                  Text(
                    cvData.personalInfo.jobTitle,
                    style: theme.textTheme.bodyMedium
                        ?.copyWith(color: Colors.white.withOpacity(0.8)),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
                const SizedBox(height: AppSizes.p16),
                Text(
                  'Tap to edit your CV',
                  style: theme.textTheme.bodySmall
                      ?.copyWith(color: Colors.white.withOpacity(0.8)),
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
