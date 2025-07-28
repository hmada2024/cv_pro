import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../timeline_professional_colors.dart';

class FoldedBanner extends pw.StatelessWidget {
  final String title;
  final double bannerWidth;
  final double bannerHeight;
  final double foldDepth;

  FoldedBanner({
    required this.title,
    this.bannerWidth = 200,
    this.bannerHeight = 28,
    this.foldDepth = 12,
  });

  @override
  pw.Widget build(pw.Context context) {
    return pw.SizedBox(
      width: bannerWidth,
      height: bannerHeight + foldDepth,
      child: pw.Stack(
        children: [
          // The main banner rectangle
          pw.Container(
            width: bannerWidth,
            height: bannerHeight,
            color: TimelineProfessionalColors.primaryGray,
            child: pw.Center(
              child: pw.Text(
                title.toUpperCase(),
                style: pw.TextStyle(
                  color: TimelineProfessionalColors.lightText,
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ),
          // The "folded" part (the shadow triangle)
          pw.Positioned(
            top: bannerHeight,
            right: 0,
            child: pw.Polygon(
              points: [
                const PdfPoint(0, 0), // Top-left of the polygon
                PdfPoint(-foldDepth, foldDepth), // Bottom-left corner
                PdfPoint(0, foldDepth), // Bottom-right corner
              ],
              fillColor: TimelineProfessionalColors.secondaryGray,
              strokeWidth: 0,
            ),
          ),
        ],
      ),
    );
  }
}
