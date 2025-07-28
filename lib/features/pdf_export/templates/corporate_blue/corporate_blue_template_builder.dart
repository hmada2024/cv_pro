import 'dart:io';
import 'package:flutter/services.dart'; // ✅ NEW: Import
import 'package:pdf/widgets.dart' as pw;
import 'package:cv_pro/features/cv_form/data/models/cv_data.dart';
import 'package:cv_pro/features/pdf_export/templates/corporate_blue/corporate_blue_header.dart';
import 'package:cv_pro/features/pdf_export/templates/corporate_blue/corporate_blue_left_column.dart';
import 'package:cv_pro/features/pdf_export/templates/corporate_blue/corporate_blue_right_column.dart';

Future<pw.Widget> buildCorporateBlueTemplate({
  required CVData data,
  required pw.Font iconFont,
}) async {
  pw.ImageProvider? profileImage;
  final imagePath = data.personalInfo.profileImagePath;

  if (imagePath != null && imagePath.isNotEmpty) {
    // ✅ UPDATED: Check if the path is an asset or a file path
    if (imagePath.startsWith('assets/')) {
      // It's an asset
      final imageBytes = await rootBundle.load(imagePath);
      profileImage = pw.MemoryImage(imageBytes.buffer.asUint8List());
    } else {
      // It's a file path
      final imageFile = File(imagePath);
      if (await imageFile.exists()) {
        profileImage = pw.MemoryImage(await imageFile.readAsBytes());
      }
    }
  }

  return pw.Column(
    children: [
      CorporateBlueHeader(data: data, profileImage: profileImage),
      pw.Expanded(
        child: pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Expanded(
              flex: 2,
              child: CorporateBlueLeftColumn(data: data, iconFont: iconFont),
            ),
            pw.Expanded(
              flex: 3,
              child: CorporateBlueRightColumn(data: data),
            ),
          ],
        ),
      ),
    ],
  );
}
