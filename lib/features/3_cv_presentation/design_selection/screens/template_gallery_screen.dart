// lib/features/3_cv_presentation/design_selection/screens/template_gallery_screen.dart
import 'package:cv_pro/core/constants/app_sizes.dart';
import 'package:cv_pro/features/3_cv_presentation/design_selection/models/template_model.dart';
import 'package:cv_pro/features/3_cv_presentation/design_selection/providers/template_provider.dart';
import 'package:cv_pro/features/3_cv_presentation/design_selection/widgets/gallery_carousel.dart';
import 'package:cv_pro/features/3_cv_presentation/design_selection/widgets/gallery_page_indicator.dart';
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
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 100),
              child: Column(
                children: [
                  const SizedBox(height: AppSizes.p24),
                  GalleryCarousel(
                    templates: _templates,
                    pageController: _pageController,
                    currentPage: _currentPage,
                  ),
                  const SizedBox(height: AppSizes.p16),
                  GalleryPageIndicator(
                    itemCount: _templates.length,
                    currentPage: _currentPage,
                  ),
                  const SizedBox(height: AppSizes.p12),
                  Text(
                    currentTemplate.name,
                    style: theme.textTheme.titleLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: theme.scaffoldBackgroundColor.withOpacity(0.95),
                padding: const EdgeInsets.fromLTRB(
                    AppSizes.p16, AppSizes.p12, AppSizes.p16, AppSizes.p24),
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
            ),
          ],
        ),
      ),
    );
  }
}
