// features/pdf_export/layout/pdf_layout_builder.dart
import 'dart:typed_data'; // Import needed for Uint8List
import 'package:pdf/widgets.dart' as pw;
import 'package:cv_pro/features/cv_form/data/models/cv_data.dart';
import 'pdf_left_column.dart';
import 'pdf_right_column.dart';

// ✅✅✅ UPDATED: This function is now PURE. It does NO asset/file loading.
// It simply receives all necessary data and builds the layout.
pw.Widget buildPdfLayout({
  required CVData data,
  required pw.Font iconFont,
  required bool showReferencesNote,
  required Uint8List? profileImageData,
}) {
  pw.ImageProvider? profileImage;

  // If raw image data is provided, create a MemoryImage from it.
  if (profileImageData != null) {
    profileImage = pw.MemoryImage(profileImageData);
  }

  return pw.Row(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      pw.Expanded(
        flex: 1,
        child: PdfLeftColumn(
          data: data,
          profileImage: profileImage,
          iconFont: iconFont,
        ),
      ),
      pw.Expanded(
        flex: 2,
        child: PdfRightColumn(
          data: data,
          iconFont: iconFont,
          showReferencesNote: showReferencesNote,
        ),
      ),
    ],
  );
}
