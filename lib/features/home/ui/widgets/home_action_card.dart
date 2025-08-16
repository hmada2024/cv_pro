// lib/features/home/ui/widgets/home_action_card.dart
import 'package:cv_pro/core/constants/app_sizes.dart';
import 'package:flutter/material.dart';

class HomeActionCard extends StatelessWidget {
  const HomeActionCard({
    super.key,
    required this.icon,
    required this.label,
    required this.subtitle,
    this.isEnabled = true,
  });

  final IconData icon;
  final String label;
  final String subtitle;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.p16),
        child: Column(
          children: [
            Icon(
              icon,
              size: AppSizes.iconSizeLarge - 10,
              color:
                  isEnabled ? theme.colorScheme.primary : theme.disabledColor,
            ),
            const SizedBox(height: AppSizes.p8),
            Text(
              label,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: isEnabled
                    ? theme.textTheme.bodyMedium?.color
                    : theme.disabledColor,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSizes.p4),
            Text(
              subtitle,
              style: theme.textTheme.bodySmall?.copyWith(
                color: isEnabled
                    ? theme.textTheme.bodySmall?.color
                    : theme.disabledColor,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
