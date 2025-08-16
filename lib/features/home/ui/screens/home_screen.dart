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
            _AnimatedScaleTap(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CvFormScreen()));
              },
              child: _MainCvCard(isNewUser: isNewUser),
            ),
            const SizedBox(height: AppSizes.p24),
            Text('Quick Actions', style: theme.textTheme.titleLarge),
            const SizedBox(height: AppSizes.p12),
            Row(
              children: [
                Expanded(
                  child: _AnimatedScaleTap(
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
                    child: _ActionCard(
                      icon: Icons.picture_as_pdf_outlined,
                      label: 'Preview CV',
                      isEnabled: !isNewUser,
                    ),
                  ),
                ),
                const SizedBox(width: AppSizes.p16),
                Expanded(
                  child: _AnimatedScaleTap(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PdfPreviewScreen(
                              pdfProvider: dummyPdfBytesProvider),
                        ),
                      );
                    },
                    child: const _ActionCard(
                      icon: Icons.style_outlined,
                      label: 'Preview Template',
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSizes.p24),
            Text('Professional Tips', style: theme.textTheme.titleLarge),
            const SizedBox(height: AppSizes.p12),
            const _AnimatedScaleTap(
              child: _TipCard(
                icon: Icons.person_search_outlined,
                title: 'How to write a professional summary?',
                content:
                    '1. Start with your job title and years of experience.\n'
                    '2. Mention 2-3 of your most impressive skills or achievements.\n'
                    '3. Conclude by stating your career goals and what you can offer the company.',
              ),
            ),
            const SizedBox(height: AppSizes.p12),
            const _AnimatedScaleTap(
              child: _TipCard(
                icon: Icons.star_outline,
                title: 'Use action verbs in your experience',
                content:
                    'Instead of "Responsible for...", try using powerful verbs like:\n'
                    '• Led a team of...\n'
                    '• Increased sales by...\n'
                    '• Developed a new system that...\n'
                    '• Implemented a solution to...',
              ),
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
      elevation: 4,
      shadowColor: theme.colorScheme.primary.withOpacity(0.2),
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.p20),
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
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
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
    );
  }
}

class _ActionCard extends StatelessWidget {
  const _ActionCard({
    required this.icon,
    required this.label,
    this.isEnabled = true,
  });

  final IconData icon;
  final String label;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
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

// Helper widget for tap animations
class _AnimatedScaleTap extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;

  const _AnimatedScaleTap({required this.child, this.onTap});

  @override
  State<_AnimatedScaleTap> createState() => _AnimatedScaleTapState();
}

class _AnimatedScaleTapState extends State<_AnimatedScaleTap>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.97).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    if (widget.onTap != null) {
      _controller.forward();
    }
  }

  void _onTapUp(TapUpDetails details) {
    if (widget.onTap != null) {
      Future.delayed(const Duration(milliseconds: 100), () {
        if (mounted) {
          _controller.reverse();
        }
      });
    }
  }

  void _onTapCancel() {
    if (widget.onTap != null) {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      onTap: widget.onTap,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: widget.child,
      ),
    );
  }
}
