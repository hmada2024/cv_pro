import 'dart:io';
import 'package:flutter/services.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:cv_pro/features/cv_form/data/models/cv_data.dart';
import 'left_column.dart';
import 'right_column.dart';

Future<pw.Widget> buildModernTemplate({
  required CVData data,
  required pw.Font iconFont,
  required bool showReferencesNote, // ✅ NEW
}) async {
  pw.ImageProvider? profileImage;
  final imagePath = data.personalInfo.profileImagePath;

  if (imagePath != null && imagePath.isNotEmpty) {
    if (imagePath.startsWith('assets/')) {
      final imageBytes = await rootBundle.load(imagePath);
      profileImage = pw.MemoryImage(imageBytes.buffer.asUint8List());
    } else {
      final imageFile = File(imagePath);
      if (await imageFile.exists()) {
        profileImage = pw.MemoryImage(await imageFile.readAsBytes());
      }
    }
  }

  return pw.Row(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      pw.Expanded(
        flex: 1,
        child: LeftColumn(
          data: data,
          profileImage: profileImage,
          iconFont: iconFont,
        ),
      ),
      pw.Expanded(
        flex: 2,
        child: RightColumn(
          data: data,
          iconFont: iconFont,
          showReferencesNote: showReferencesNote, // ✅ NEW: Pass down
        ),
      ),
    ],
  );
}
