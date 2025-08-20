// lib/features/3_cv_presentation/design_selection/widgets/gallery_page_indicator.dart
import 'package:flutter/material.dart';

class GalleryPageIndicator extends StatelessWidget {
  final int itemCount;
  final int currentPage;

  const GalleryPageIndicator({
    super.key,
    required this.itemCount,
    required this.currentPage,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(itemCount, (index) {
        bool isSelected = index == currentPage;
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
}
