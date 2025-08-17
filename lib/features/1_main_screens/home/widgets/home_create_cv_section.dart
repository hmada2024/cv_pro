// lib/features/home/widgets/home_create_cv_section.dart
import 'package:cv_pro/core/constants/app_sizes.dart';
import 'package:flutter/material.dart';

class HomeCreateCvSection extends StatelessWidget {
  final VoidCallback onCreate;
  const HomeCreateCvSection({super.key, required this.onCreate});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: theme.brightness == Brightness.light
            ? theme.scaffoldBackgroundColor
            : theme.cardColor.withOpacity(0.5),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(AppSizes.cardRadius * 2),
          topRight: Radius.circular(AppSizes.cardRadius * 2),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.p32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Ready to impress?',
              textAlign: TextAlign.center,
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(height: AppSizes.p12),
            ElevatedButton.icon(
              onPressed: onCreate,
              icon: const Icon(Icons.add_circle_outline),
              label: const Text('Create New CV'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: AppSizes.p16),
                textStyle: theme.textTheme.titleMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
