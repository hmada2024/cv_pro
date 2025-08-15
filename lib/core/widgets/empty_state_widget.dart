// lib/core/widgets/empty_state_widget.dart
import 'package:cv_pro/core/constants/app_sizes.dart';
import 'package:flutter/material.dart';

class EmptyStateWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const EmptyStateWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(
          vertical: AppSizes.p24, horizontal: AppSizes.p16),
      decoration: BoxDecoration(
        color: theme.brightness == Brightness.light
            ? Colors.grey.shade100
            : theme.cardTheme.color,
        borderRadius: BorderRadius.circular(AppSizes.buttonRadius),
      ),
      child: Column(
        children: [
          Icon(icon,
              size: AppSizes.iconSizeLarge, color: theme.colorScheme.secondary),
          const SizedBox(height: AppSizes.p12),
          Text(
            title,
            style: theme.textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSizes.p4),
          Text(
            subtitle,
            style: theme.textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
