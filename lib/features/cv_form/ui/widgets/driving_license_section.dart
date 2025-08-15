// features/cv_form/ui/widgets/driving_license_section.dart
import 'package:cv_pro/features/cv_form/data/models/cv_data.dart';
import 'package:cv_pro/features/cv_form/data/providers/cv_form_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DrivingLicenseSection extends ConsumerWidget {
  const DrivingLicenseSection({super.key});

  String _licenseTypeToString(LicenseType type) {
    switch (type) {
      case LicenseType.local:
        return 'Local';
      case LicenseType.international:
        return 'International';
      case LicenseType.both:
        return 'Both';
      case LicenseType.none:
        return '';
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final licenseInfo = ref.watch(cvFormProvider.select((cv) => (
          hasLicense: cv.personalInfo.hasDriverLicense,
          type: cv.personalInfo.licenseType
        )));
    final notifier = ref.read(cvFormProvider.notifier);
    final theme = Theme.of(context);

    final selectableTypes =
        LicenseType.values.where((type) => type != LicenseType.none).toSet();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Icon(Icons.directions_car, color: theme.colorScheme.secondary),
                const SizedBox(width: 8),
                Text('Driving License', style: theme.textTheme.titleLarge),
              ],
            ),
            const SizedBox(height: 8),
            SwitchListTile(
              title: const Text('I have a driver\'s license'),
              value: licenseInfo.hasLicense,
              onChanged: (bool value) {
                notifier.updateLicenseInfo(hasLicense: value);
              },
              activeColor: theme.colorScheme.primary,
              contentPadding: EdgeInsets.zero,
            ),
            AnimatedOpacity(
              duration: const Duration(milliseconds: 300),
              opacity: licenseInfo.hasLicense ? 1.0 : 0.4,
              child: IgnorePointer(
                ignoring: !licenseInfo.hasLicense,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 12),
                    SegmentedButton<LicenseType>(
                      segments: selectableTypes
                          .map((type) => ButtonSegment<LicenseType>(
                                value: type,
                                label: Text(_licenseTypeToString(type)),
                                // Conditionally add a check icon to the selected segment
                                icon: licenseInfo.type == type
                                    ? const Icon(Icons.check, size: 18)
                                    : null,
                              ))
                          .toList(),
                      selected: {
                        (licenseInfo.hasLicense &&
                                licenseInfo.type != LicenseType.none)
                            ? licenseInfo.type
                            : LicenseType.local,
                      },
                      onSelectionChanged: (Set<LicenseType> newSelection) {
                        if (newSelection.isNotEmpty) {
                          notifier.updateLicenseInfo(type: newSelection.first);
                        }
                      },
                      style: SegmentedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        selectedBackgroundColor:
                            theme.colorScheme.primary.withOpacity(0.2),
                        selectedForegroundColor: theme.colorScheme.primary,
                      ),
                      // This ensures the button shows the icon when selected.
                      showSelectedIcon: true,
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
