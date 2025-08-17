// lib/features/home/screens/home_screen.dart
import 'package:cv_pro/core/constants/app_sizes.dart';
import 'package:cv_pro/features/2_cv_editor/form/data/models/cv_data.dart';
import 'package:cv_pro/features/2_cv_editor/form/data/providers/cv_form_provider.dart';
import 'package:cv_pro/features/2_cv_editor/form/ui/screens/cv_form_screen.dart';
import 'package:cv_pro/features/2_cv_editor/projects/providers/cv_projects_provider.dart';
import 'package:cv_pro/features/2_cv_editor/projects/ui/widgets/create_cv_dialog.dart';
import 'package:cv_pro/features/3_cv_presentation/design_selection/widgets/home_template_section.dart';
import 'package:cv_pro/features/1_main_screens/home/widgets/home_project_list_item.dart';
import 'package:cv_pro/features/1_main_screens/settings/screens/settings_screen.dart';
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
      // تم تبسيط بنية الـ body بالكامل لحل مشكلة التعارض
      body: projectsAsync.when(
        data: (projects) {
          // نستخدم SingleChildScrollView كأب رئيسي للمحتوى
          return SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: AppSizes.p16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // إذا لم تكن هناك مشاريع، نعرض رسالة الترحيب
                if (projects.isEmpty) _buildWelcomeView(context),
                // إذا كانت هناك مشاريع، نعرض القائمة
                if (projects.isNotEmpty) _buildProjectsList(projects),
                // الأقسام السفلية تظهر دائمًا
                const SizedBox(height: AppSizes.p16),
                const HomeTemplateSection(),
                _buildCreateCvButton(context, ref),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => _buildErrorView(context, ref, error),
      ),
    );
  }

  // ويدجت لبناء قائمة المشاريع
  Widget _buildProjectsList(List<CVData> projects) {
    // هذه الويدجت لم تعد بحاجة لأن تكون Expanded
    return ListView.builder(
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
      padding: const EdgeInsets.fromLTRB(
          AppSizes.p16, AppSizes.p16, AppSizes.p16, 0),
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
    // نستخدم Padding للتحكم في المساحة بدلاً من Spacer و Expanded
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.p32, vertical: AppSizes.p32 * 2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
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
