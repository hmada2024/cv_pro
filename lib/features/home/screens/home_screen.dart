// lib/features/home/ui/screens/home_screen.dart
import 'package:cv_pro/core/constants/app_sizes.dart';
import 'package:cv_pro/features/cv_form/data/providers/cv_form_provider.dart';
import 'package:cv_pro/features/cv_form/ui/screens/cv_form_screen.dart';
import 'package:cv_pro/features/cv_form/ui/screens/pdf_preview_screen.dart';
import 'package:cv_pro/features/settings/screens/settings_screen.dart';
import 'package:cv_pro/features/home/widgets/animated_scale_tap.dart';
import 'package:cv_pro/features/home/widgets/home_action_card.dart';
import 'package:cv_pro/features/home/widgets/home_main_cv_card.dart';
import 'package:cv_pro/features/home/widgets/home_tip_card.dart';
import 'package:cv_pro/features/pdf_export/data/providers/pdf_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isNewUser =
        ref.watch(cvFormProvider.select((cv) => cv.personalInfo.name.isEmpty));
    final theme = Theme.of(context);

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
      body: Stack(
        children: [
          // Background Pattern
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: const AssetImage('assets/images/background_pattern.png'),
                fit: BoxFit.cover,
                opacity: theme.brightness == Brightness.light ? 0.03 : 0.02,
              ),
            ),
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.all(AppSizes.p16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AnimatedScaleTap(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CvFormScreen()));
                  },
                  child: HomeMainCvCard(isNewUser: isNewUser),
                ),
                const SizedBox(height: AppSizes.p24),
                Row(
                  children: [
                    Icon(Icons.bolt_outlined,
                        color: theme.colorScheme.secondary),
                    const SizedBox(width: AppSizes.p8),
                    Text('Quick Actions', style: theme.textTheme.titleLarge),
                  ],
                ),
                const SizedBox(height: AppSizes.p12),
                Row(
                  children: [
                    Expanded(
                      child: AnimatedScaleTap(
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
                        child: HomeActionCard(
                          icon: Icons.picture_as_pdf_outlined,
                          label: 'Preview & Export',
                          subtitle: isNewUser
                              ? 'Enter your data first'
                              : 'Your final PDF file',
                          isEnabled: !isNewUser,
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSizes.p16),
                    Expanded(
                      child: AnimatedScaleTap(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PdfPreviewScreen(
                                  pdfProvider: dummyPdfBytesProvider),
                            ),
                          );
                        },
                        child: const HomeActionCard(
                          icon: Icons.style_outlined,
                          label: 'Preview Template',
                          subtitle: 'Using dummy data',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSizes.p24),
                Row(
                  children: [
                    Icon(Icons.lightbulb_outline,
                        color: theme.colorScheme.secondary),
                    const SizedBox(width: AppSizes.p8),
                    Text('Quick Start Guide',
                        style: theme.textTheme.titleLarge),
                  ],
                ),
                const SizedBox(height: AppSizes.p12),
                const AnimatedScaleTap(
                  child: HomeTipCard(
                    icon: Icons.edit_note_outlined,
                    title: 'How do I edit my information?',
                    content:
                        'Simply tap on the large CV card at the top to enter edit mode. There you can add and change all your details.',
                  ),
                ),
                const SizedBox(height: AppSizes.p12),
                const AnimatedScaleTap(
                  child: HomeTipCard(
                    icon: Icons.swap_vert_outlined,
                    title: 'How to reorder my experience?',
                    content:
                        'In the Education and Experience sections, press and hold the drag handle icon (::) on the left of any item, then drag it to your desired position.',
                  ),
                ),
                const SizedBox(height: AppSizes.p12),
                const AnimatedScaleTap(
                  child: HomeTipCard(
                    icon: Icons.save_alt_outlined,
                    title: 'How do I save the PDF?',
                    content:
                        "Tap the 'Preview & Export' button on this screen. From the preview page, use the share or print icon to save the file to your device.",
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
