// lib/features/home/widgets/home_project_list_item.dart
import 'dart:io';
import 'package:cv_pro/core/constants/app_sizes.dart';
import 'package:cv_pro/features/cv_form/data/models/cv_data.dart';
import 'package:cv_pro/features/cv_form/data/providers/cv_form_provider.dart';
import 'package:cv_pro/features/cv_form/ui/screens/cv_form_screen.dart';
import 'package:cv_pro/features/cv_projects/providers/cv_projects_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeProjectListItem extends ConsumerWidget {
  final CVData cvData;
  const HomeProjectListItem({super.key, required this.cvData});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final hasImage = cvData.personalInfo.profileImagePath != null &&
        cvData.personalInfo.profileImagePath!.isNotEmpty;

    final projectsNotifier = ref.read(cvProjectsProvider.notifier);
    final Widget profileImageWidget = hasImage
        ? Image.file(
            File(cvData.personalInfo.profileImagePath!),
            fit: BoxFit.cover,
            width: (AppSizes.avatarRadius - 15) * 2,
            height: (AppSizes.avatarRadius - 15) * 2,
            errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.person),
          )
        : Image.asset(
            'assets/images/unknown_person.png',
            fit: BoxFit.cover,
            width: (AppSizes.avatarRadius - 15) * 2,
            height: (AppSizes.avatarRadius - 15) * 2,
          );

    return Card(
      margin: const EdgeInsets.only(bottom: AppSizes.p12),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppSizes.cardRadius),
        onTap: () async {
          ref.read(activeCvProvider.notifier).loadCvProject(cvData);
          await Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => const CvFormScreen()));
          ref.invalidate(cvProjectsProvider);
        },
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.p12),
          child: Row(
            children: [
              ClipOval(
                child: Container(
                  color: theme.scaffoldBackgroundColor,
                  child: profileImageWidget,
                ),
              ),
              const SizedBox(width: AppSizes.p16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cvData.projectName,
                      style: theme.textTheme.titleMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (cvData.personalInfo.name.isNotEmpty) ...[
                      const SizedBox(height: AppSizes.p4),
                      Text(
                        cvData.personalInfo.name,
                        style: theme.textTheme.bodyMedium,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ]
                  ],
                ),
              ),
              IconButton(
                icon:
                    Icon(Icons.delete_outline, color: theme.colorScheme.error),
                tooltip: 'Delete Project',
                onPressed: () {
                  // Use the captured notifier instance
                  projectsNotifier.markProjectForDeletion(cvData.id);

                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Deleted "${cvData.projectName}"'),
                      duration: const Duration(seconds: 4),
                      action: SnackBarAction(
                        label: 'UNDO',
                        onPressed: () {
                          // Use the captured notifier instance here as well.
                          // This is now safe even if the widget is disposed.
                          projectsNotifier.undoDeletion();
                        },
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
