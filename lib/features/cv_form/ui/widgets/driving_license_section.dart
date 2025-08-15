// features/cv_form/ui/widgets/driving_license_section.dart
import 'package:cv_pro/features/cv_form/data/models/cv_data.dart';
import 'package:cv_pro/features/cv_form/data/providers/cv_form_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DrivingLicenseSection extends ConsumerWidget {
  const DrivingLicenseSection({super.key});

  // Helper to convert enum to display text
  String _licenseTypeToString(LicenseType type) {
    switch (type) {
      case LicenseType.local:
        return 'Local';
      case LicenseType.international:
        return 'International';
      case LicenseType.both:
        return 'Both';
      case LicenseType.none:
        return ''; // Not displayed
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final personalInfo = ref.watch(cvFormProvider).personalInfo;
    final notifier = ref.read(cvFormProvider.notifier);
    final theme = Theme.of(context);

    // Filter out 'none' for the SegmentedButton
    final selectableTypes =
        LicenseType.values.where((type) => type != LicenseType.none).toSet();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Section Header
            Row(
              children: [
                Icon(Icons.directions_car, color: theme.colorScheme.secondary),
                const SizedBox(width: 8),
                Text('Driving License', style: theme.textTheme.titleLarge),
              ],
            ),
            const SizedBox(height: 8),

            // Main Toggle Switch
            SwitchListTile(
              title: const Text('I have a driver\'s license'),
              value: personalInfo.hasDriverLicense,
              onChanged: (bool value) {
                notifier.updateLicenseInfo(hasLicense: value);
              },
              activeColor: theme.colorScheme.primary,
              contentPadding: EdgeInsets.zero,
            ),

            // Animated Options
            AnimatedOpacity(
              duration: const Duration(milliseconds: 300),
              opacity: personalInfo.hasDriverLicense ? 1.0 : 0.4,
              child: IgnorePointer(
                ignoring: !personalInfo.hasDriverLicense,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 12),
                    SegmentedButton<LicenseType>(
                      segments: selectableTypes
                          .map((type) => ButtonSegment<LicenseType>(
                                value: type,
                                label: Text(_licenseTypeToString(type)),
                              ))
                          .toList(),
                      selected: {
                        // Ensure a valid selection if license is enabled
                        if (personalInfo.hasDriverLicense &&
                            personalInfo.licenseType != LicenseType.none)
                          personalInfo.licenseType
                      },
                      onSelectionChanged: (Set<LicenseType> newSelection) {
                        notifier.updateLicenseInfo(type: newSelection.first);
                      },
                      style: SegmentedButton.styleFrom(
                        selectedBackgroundColor:
                            theme.colorScheme.primary.withOpacity(0.2),
                        selectedForegroundColor: theme.colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
