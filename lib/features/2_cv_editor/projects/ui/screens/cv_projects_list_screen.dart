// lib/features/cv_projects/ui/screens/cv_projects_list_screen.dart
import 'package:cv_pro/core/constants/app_sizes.dart';
import 'package:cv_pro/core/widgets/empty_state_widget.dart';
import 'package:cv_pro/features/2_cv_editor/projects/providers/cv_projects_provider.dart';
import 'package:cv_pro/features/2_cv_editor/projects/ui/widgets/cv_project_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CvProjectsListScreen extends ConsumerWidget {
  const CvProjectsListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Corrected provider name
    final projectsAsync = ref.watch(cvProjectsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My CV Projects'),
      ),
      body: projectsAsync.when(
        data: (projects) {
          if (projects.isEmpty) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(AppSizes.p24),
                child: EmptyStateWidget(
                  icon: Icons.folder_off_outlined,
                  title: 'No Projects Yet',
                  subtitle:
                      'Go back to the home screen and create your first CV project.',
                ),
              ),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(AppSizes.p16),
            itemCount: projects.length,
            itemBuilder: (context, index) {
              return CvProjectCard(cvData: projects[index]);
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
