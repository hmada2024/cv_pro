// lib/features/3_cv_presentation/design_selection/screens/template_gallery_screen.dart
import 'package:cv_pro/core/constants/app_sizes.dart';
import 'package:cv_pro/features/3_cv_presentation/design_selection/models/template_model.dart';
import 'package:cv_pro/features/3_cv_presentation/design_selection/providers/template_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TemplateGalleryScreen extends ConsumerStatefulWidget {
  const TemplateGalleryScreen({super.key});

  @override
  ConsumerState<TemplateGalleryScreen> createState() =>
      _TemplateGalleryScreenState();
}

class _TemplateGalleryScreenState extends ConsumerState<TemplateGalleryScreen> {
  late final PageController _pageController;
  late int _currentPage;
  late final List<TemplateModel> _templates;

  @override
  void initState() {
    super.initState();
    _templates = ref.read(allTemplatesProvider);
    final initialTemplate = ref.read(selectedTemplateProvider);
    _currentPage = _templates.indexWhere((t) => t.id == initialTemplate.id);
    if (_currentPage == -1) _currentPage = 0;

    _pageController = PageController(
      viewportFraction: 0.8,
      initialPage: _currentPage,
    );

    _pageController.addListener(() {
      final newPage = _pageController.page?.round();
      if (newPage != null && newPage != _currentPage) {
        setState(() {
          _currentPage = newPage;
        });
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final currentTemplate = _templates[_currentPage];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose Your Template'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: AppSizes.p24),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.55,
              child: PageView.builder(
                controller: _pageController,
                itemCount: _templates.length,
                itemBuilder: (context, index) {
                  final template = _templates[index];
                  final isSelected = index == _currentPage;

                  return AnimatedScale(
                    scale: isSelected ? 1.0 : 0.9,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSizes.p8,
                        vertical: AppSizes.p12,
                      ),
                      child: Card(
                        elevation: isSelected ? 8 : 2,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(AppSizes.cardRadius),
                          side: BorderSide(
                            color: isSelected
                                ? theme.colorScheme.primary
                                : Colors.transparent,
                            width: 2.5,
                          ),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: Image.asset(
                          template.previewImagePath,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Center(
                              child: Text('Image not found!'),
                            );
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: AppSizes.p20),
            Text(
              currentTemplate.name,
              style: theme.textTheme.titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                  AppSizes.p16, 0, AppSizes.p16, AppSizes.p24),
              child: ElevatedButton.icon(
                icon: const Icon(Icons.check_circle_outline),
                label: const Text('Select this Template'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
                onPressed: () {
                  ref.read(selectedTemplateProvider.notifier).state =
                      currentTemplate;
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
