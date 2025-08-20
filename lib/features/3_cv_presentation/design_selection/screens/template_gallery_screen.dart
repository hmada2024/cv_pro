// lib/features/3_cv_presentation/design_selection/screens/template_gallery_screen.dart
import 'package:cv_pro/core/constants/app_sizes.dart';
import 'package:cv_pro/features/3_cv_presentation/design_selection/models/template_model.dart';
import 'package:cv_pro/features/3_cv_presentation/design_selection/providers/template_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:ui';

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

  static const double a4AspectRatio = 1 / 1.414;

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

  // ويدجت لبناء مؤشر النقاط
  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(_templates.length, (index) {
        bool isSelected = index == _currentPage;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          margin: const EdgeInsets.symmetric(horizontal: 4.0),
          height: isSelected ? 10.0 : 8.0,
          width: isSelected ? 10.0 : 8.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isSelected
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
          ),
        );
      }),
    );
  }

  // ويدجت لبناء أزرار الأسهم
  Widget _buildNavigationArrow({required bool isForward}) {
    // تحديد ما إذا كان يجب إظهار السهم
    bool isVisible =
        isForward ? _currentPage < _templates.length - 1 : _currentPage > 0;

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 200),
      opacity: isVisible ? 1.0 : 0.0,
      child: isVisible
          ? ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(
                  height: 44,
                  width: 44,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.25),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: Icon(
                        isForward
                            ? Icons.arrow_forward_ios
                            : Icons.arrow_back_ios,
                        color: Colors.white,
                        size: 20),
                    onPressed: () {
                      if (isForward) {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeInOutCubic,
                        );
                      } else {
                        _pageController.previousPage(
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeInOutCubic,
                        );
                      }
                    },
                  ),
                ),
              ),
            )
          : const SizedBox(width: 44, height: 44),
    );
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
                  // زيادة ارتفاع الصورة وتغليفها بـ Stack لإضافة الأسهم
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.68,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        PageView.builder(
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
                                    borderRadius: BorderRadius.circular(
                                        AppSizes.cardRadius),
                                    side: BorderSide(
                                      color: isSelected
                                          ? theme.colorScheme.primary
                                          : Colors.transparent,
                                      width: 2.5,
                                    ),
                                  ),
                                  clipBehavior: Clip.antiAlias,
                                  child: AspectRatio(
                                    aspectRatio: a4AspectRatio,
                                    child: Image.asset(
                                      template.previewImagePath,
                                      fit: BoxFit.contain,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return const Center(
                                          child: Text('Image not found!'),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        // وضع الأسهم فوق PageView
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: AppSizes.p12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _buildNavigationArrow(isForward: false),
                              _buildNavigationArrow(isForward: true),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSizes.p16),
                  // إضافة مؤشر النقاط
                  _buildPageIndicator(),
                  const SizedBox(height: AppSizes.p12),
                  // تقريب النص من الأسفل
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
