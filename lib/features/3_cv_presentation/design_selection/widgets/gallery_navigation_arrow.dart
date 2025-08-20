// lib/features/3_cv_presentation/design_selection/widgets/gallery_navigation_arrow.dart
import 'dart:ui';
import 'package:flutter/material.dart';

class GalleryNavigationArrow extends StatelessWidget {
  final bool isVisible;
  final bool isForward;
  final VoidCallback onPressed;

  const GalleryNavigationArrow({
    super.key,
    required this.isVisible,
    required this.isForward,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
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
                    onPressed: onPressed,
                  ),
                ),
              ),
            )
          : const SizedBox(width: 44, height: 44),
    );
  }
}
