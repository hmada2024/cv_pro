// features/cv_form/ui/widgets/driving_license_section.dart
import 'package:cv_pro/core/constants/app_sizes.dart';
import 'package:cv_pro/features/cv_form/data/models/cv_data.dart';
import 'package:cv_pro/features/cv_form/data/providers/cv_form_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DrivingLicenseSection extends ConsumerWidget {
  const DrivingLicenseSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the activeCvProvider and handle the nullable state
    final cvData = ref.watch(activeCvProvider);
    if (cvData == null) {
      return const SizedBox.shrink(); // Don't build if no CV is active
    }

    final licenseInfo = (
      hasLicense: cvData.personalInfo.hasDriverLicense,
      type: cvData.personalInfo.licenseType
    );
    final notifier = ref.read(activeCvProvider.notifier);
    final theme = Theme.of(context);

    final selectableTypes =
        LicenseType.values.where((type) => type != LicenseType.none).toList();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.p16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Icon(Icons.directions_car, color: theme.colorScheme.secondary),
                const SizedBox(width: AppSizes.p8),
                Text('Driving License', style: theme.textTheme.titleLarge),
              ],
            ),
            const SizedBox(height: AppSizes.p8),
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
                child: Padding(
                  padding: const EdgeInsets.only(top: AppSizes.p12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: selectableTypes.map((type) {
                      final isSelected = (licenseInfo.type == type);
                      final isLast = type == selectableTypes.last;
                      return Padding(
                        padding:
                            EdgeInsets.only(bottom: isLast ? 0 : AppSizes.p8),
                        child: OutlinedButton.icon(
                          onPressed: () =>
                              notifier.updateLicenseInfo(type: type),
                          icon: Icon(
                            isSelected ? Icons.check : null,
                            size: AppSizes.iconSizeSmall,
                            color:
                                isSelected ? theme.colorScheme.primary : null,
                          ),
                          label: Text(type.toDisplayString()),
                          style: OutlinedButton.styleFrom(
                            backgroundColor: isSelected
                                ? theme.colorScheme.primary.withOpacity(0.12)
                                : null,
                            foregroundColor: isSelected
                                ? theme.colorScheme.primary
                                : theme.colorScheme.onSurface.withOpacity(0.8),
                            side: BorderSide(
                              color: isSelected
                                  ? theme.colorScheme.primary
                                  : theme.dividerColor,
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    AppSizes.buttonRadius)),
                            padding: const EdgeInsets.symmetric(
                                vertical: AppSizes.p12),
                            alignment: Alignment.center,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
