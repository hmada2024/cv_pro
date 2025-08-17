// lib/features/home/screens/home_screen.dart
import 'package:cv_pro/core/constants/app_sizes.dart';
import 'package:cv_pro/features/cv_form/data/models/cv_data.dart';
import 'package:cv_pro/features/cv_form/data/providers/cv_form_provider.dart';
import 'package:cv_pro/features/cv_form/ui/screens/cv_form_screen.dart';
import 'package:cv_pro/features/cv_projects/providers/cv_projects_provider.dart';
import 'package:cv_pro/features/cv_projects/ui/widgets/create_cv_dialog.dart';
import 'package:cv_pro/features/cv_templates/widgets/home_template_section.dart';
import 'package:cv_pro/features/home/widgets/home_project_list_item.dart';
import 'package:cv_pro/features/settings/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final projectsAsync = ref.watch(cvProjectsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('CV Pro'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            tooltip: 'Settings',
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              );
            },
          ),
          const SizedBox(width: AppSizes.p8),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: projectsAsync.when(
                  data: (projects) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // الجزء العلوي (قائمة المشاريع أو رسالة الترحيب)
                        Expanded(
                          child: projects.isNotEmpty
                              ? _buildProjectsList(projects)
                              : _buildWelcomeView(context),
                        ),
                        // الجزء السفلي (دائمًا موجود)
                        const SizedBox(height: AppSizes.p16),
                        const HomeTemplateSection(),
                        _buildCreateCvButton(context, ref),
                      ],
                    );
                  },
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (error, stack) => _buildErrorView(context, ref, error),
                ),
              ),
            ),
          );
        },
      ),
      // --- END: RESPONSIVE LAYOUT FIX ---
    );
  }

  // ويدجت لبناء قائمة المشاريع
  Widget _buildProjectsList(List<CVData> projects) {
    return ListView.builder(
      // shrinkWrap and physics are needed inside a SingleChildScrollView
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(
          AppSizes.p16, AppSizes.p16, AppSizes.p16, 0),
      itemCount: projects.length,
      itemBuilder: (context, index) {
        return HomeProjectListItem(cvData: projects[index]);
      },
    );
  }

  // ويدجت لبناء زر إنشاء CV
  Widget _buildCreateCvButton(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(AppSizes.p16),
      child: ElevatedButton.icon(
        onPressed: () => _createNewCv(context, ref),
        icon: const Icon(Icons.add_circle_outline),
        label: const Text('Create New CV'),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: AppSizes.p16),
          textStyle: Theme.of(context).textTheme.titleMedium,
        ),
      ),
    );
  }

  // ويدجت لعرض رسالة الترحيب عندما لا توجد مشاريع
  Widget _buildWelcomeView(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.p32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Spacer(flex: 2),
          Icon(
            Icons.rocket_launch_outlined,
            size: 60,
            color: theme.colorScheme.primary,
          ),
          const SizedBox(height: AppSizes.p24),
          Text(
            'Welcome to CV Pro!',
            style: theme.textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSizes.p12),
          Text(
            'Your professional journey starts here. Create your first CV below.',
            style: theme.textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
          const Spacer(flex: 3),
        ],
      ),
    );
  }

  // ويدجت لعرض حالة الخطأ
  Widget _buildErrorView(BuildContext context, WidgetRef ref, Object error) {
    return Padding(
      padding: const EdgeInsets.all(AppSizes.p24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 48, color: Colors.redAccent),
          const SizedBox(height: AppSizes.p16),
          Text(
            'Failed to load projects',
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSizes.p8),
          Text(
            'An unexpected error occurred. Please try again.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: AppSizes.p24),
          ElevatedButton.icon(
            onPressed: () => ref.invalidate(cvProjectsProvider),
            icon: const Icon(Icons.refresh),
            label: const Text('Retry'),
          )
        ],
      ),
    );
  }

  Future<void> _createNewCv(BuildContext context, WidgetRef ref) async {
    final newCvId = await showCreateCvDialog(context, ref);

    if (newCvId != null && context.mounted) {
      final newCv =
          await ref.read(cvProjectsProvider.notifier).getProjectById(newCvId);

      if (newCv != null && context.mounted) {
        ref.read(activeCvProvider.notifier).loadCvProject(newCv);
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => const CvFormScreen()));
      }
    }
  }
}
