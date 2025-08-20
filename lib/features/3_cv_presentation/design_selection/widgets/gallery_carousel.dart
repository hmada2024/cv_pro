// lib/features/3_cv_presentation/design_selection/widgets/gallery_carousel.dart
import 'package:cv_pro/core/constants/app_sizes.dart';
import 'package:cv_pro/features/3_cv_presentation/design_selection/models/template_model.dart';
import 'package:cv_pro/features/3_cv_presentation/design_selection/widgets/gallery_navigation_arrow.dart';
import 'package:flutter/material.dart';

class GalleryCarousel extends StatelessWidget {
  static const double a4AspectRatio = 1 / 1.414;

  final List<TemplateModel> templates;
  final PageController pageController;
  final int currentPage;

  const GalleryCarousel({
    super.key,
    required this.templates,
    required this.pageController,
    required this.currentPage,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.68,
      child: Stack(
        alignment: Alignment.center,
        children: [
          PageView.builder(
            controller: pageController,
            itemCount: templates.length,
            itemBuilder: (context, index) {
              final template = templates[index];
              final isSelected = index == currentPage;

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
                      borderRadius: BorderRadius.circular(AppSizes.cardRadius),
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
                        errorBuilder: (context, error, stackTrace) {
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSizes.p12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GalleryNavigationArrow(
                  isVisible: currentPage > 0,
                  isForward: false,
                  onPressed: () {
                    pageController.previousPage(
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeInOutCubic,
                    );
                  },
                ),
                GalleryNavigationArrow(
                  isVisible: currentPage < templates.length - 1,
                  isForward: true,
                  onPressed: () {
                    pageController.nextPage(
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeInOutCubic,
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
