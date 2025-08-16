// lib/features/home/ui/screens/home_screen.dart
import 'package:cv_pro/core/constants/app_sizes.dart';
import 'package:cv_pro/features/cv_form/data/providers/cv_form_provider.dart';
import 'package:cv_pro/features/cv_form/data/providers/cv_view_providers.dart';
import 'package:cv_pro/features/cv_form/ui/screens/cv_form_screen.dart';
import 'package:cv_pro/features/cv_form/ui/screens/pdf_preview_screen.dart';
import 'package:cv_pro/features/cv_form/ui/screens/settings_screen.dart';
import 'package:cv_pro/features/pdf_export/data/providers/pdf_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cvDataState = ref.watch(cvFormProvider);
    final theme = Theme.of(context);
    final isNewUser = cvDataState.personalInfo.name.isEmpty;

    return Scaffold(
      appBar: AppBar(
        title: const Text('CV Pro'),
        leading: IconButton(
          icon: const Icon(Icons.settings_outlined),
          tooltip: 'Settings',
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const SettingsScreen()),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSizes.p16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Main CV Card
            _MainCvCard(isNewUser: isNewUser),
            const SizedBox(height: AppSizes.p24),

            // Quick Actions
            Text('Quick Actions', style: theme.textTheme.titleLarge),
            const SizedBox(height: AppSizes.p12),
            Row(
              children: [
                Expanded(
                  child: _ActionCard(
                    icon: Icons.picture_as_pdf_outlined,
                    label: 'Preview CV',
                    onTap: isNewUser
                        ? null
                        : () {
                            ref.invalidate(pdfBytesProvider);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PdfPreviewScreen(
                                    pdfProvider: pdfBytesProvider),
                              ),
                            );
                          },
                  ),
                ),
                const SizedBox(width: AppSizes.p16),
                Expanded(
                  child: _ActionCard(
                    icon: Icons.style_outlined,
                    label: 'Preview Template',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PdfPreviewScreen(
                              pdfProvider: dummyPdfBytesProvider),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSizes.p24),

            // Professional Tips
            Text('Professional Tips', style: theme.textTheme.titleLarge),
            const SizedBox(height: AppSizes.p12),
            const _TipCard(
              icon: Icons.person_search_outlined,
              title: 'How to write a professional summary?',
              content: '1. Start with your job title and years of experience.\n'
                  '2. Mention 2-3 of your most impressive skills or achievements.\n'
                  '3. Conclude by stating your career goals and what you can offer the company.',
            ),
            const SizedBox(height: AppSizes.p12),
            const _TipCard(
              icon: Icons.star_outline,
              title: 'Use action verbs in your experience',
              content:
                  'Instead of "Responsible for...", try using powerful verbs like:\n'
                  '• Led a team of...\n'
                  '• Increased sales by...\n'
                  '• Developed a new system that...\n'
                  '• Implemented a solution to...',
            ),
          ],
        ),
      ),
    );
  }
}

class _MainCvCard extends ConsumerWidget {
  const _MainCvCard({required this.isNewUser});

  final bool isNewUser;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final cvData = ref.watch(cvFormProvider);

    return Card(
      elevation: 2,
      color: theme.colorScheme.primary,
      child: InkWell(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const CvFormScreen()));
        },
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.p24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (isNewUser) ...[
                const Icon(Icons.add_circle_outline,
                    size: AppSizes.iconSizeLarge, color: Colors.white),
                const SizedBox(height: AppSizes.p12),
                Text(
                  'Start Building Your CV',
                  style: theme.textTheme.titleLarge
                      ?.copyWith(color: Colors.white, fontSize: 20),
                ),
                const SizedBox(height: AppSizes.p8),
                Text(
                  'Create a professional CV in minutes.',
                  style: theme.textTheme.bodyMedium
                      ?.copyWith(color: Colors.white.withOpacity(0.8)),
                ),
              ] else ...[
                Text(
                  cvData.personalInfo.name,
                  style: theme.textTheme.titleLarge
                      ?.copyWith(color: Colors.white, fontSize: 22),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                if (cvData.personalInfo.jobTitle.isNotEmpty) ...[
                  const SizedBox(height: AppSizes.p4),
                  Text(
                    cvData.personalInfo.jobTitle,
                    style: theme.textTheme.bodyMedium
                        ?.copyWith(color: Colors.white.withOpacity(0.8)),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
                const SizedBox(height: AppSizes.p16),
                ClipRRect(
                  borderRadius: BorderRadius.circular(AppSizes.buttonRadius),
                  child: LinearProgressIndicator(
                    value: ref.watch(cvCompletionProvider),
                    minHeight: 6,
                    backgroundColor: Colors.white.withOpacity(0.3),
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ),
                const SizedBox(height: AppSizes.p8),
                Text(
                  'Tap to edit your CV',
                  style: theme.textTheme.bodySmall
                      ?.copyWith(color: Colors.white.withOpacity(0.8)),
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}

class _ActionCard extends StatelessWidget {
  const _ActionCard({
    required this.icon,
    required this.label,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool isEnabled = onTap != null;

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(
            color: isEnabled ? theme.dividerColor : Colors.transparent),
        borderRadius: BorderRadius.circular(AppSizes.cardRadius),
      ),
      color: isEnabled ? theme.cardColor : theme.disabledColor.withOpacity(0.1),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSizes.cardRadius),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TipCard extends StatelessWidget {
  const _TipCard({
    required this.icon,
    required this.title,
    required this.content,
  });

  final IconData icon;
  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: theme.dividerColor),
        borderRadius: BorderRadius.circular(AppSizes.cardRadius),
      ),
      child: ListTile(
        leading: Icon(icon, color: theme.colorScheme.secondary),
        title: Text(title, style: theme.textTheme.titleMedium),
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(title),
              content: Text(content, style: theme.textTheme.bodyMedium),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Got it'),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
