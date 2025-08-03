// features/pdf_export/templates/two_column_01/template_01_builder.dart
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:cv_pro/features/cv_form/data/models/cv_data.dart';
import 'header_template_01.dart';
import 'column_template_01_left.dart';
import 'right_column_template_01.dart';

Future<pw.Widget> buildTemplate01( // ✅ UPDATED FUNCTION NAME
    {
  required CVData data,
  required pw.Font iconFont,
  required bool showReferencesNote,
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

  return pw.Column(
    children: [
      Template01Header(data: data, profileImage: profileImage), // ✅ UPDATED
      pw.Expanded(
        child: pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Expanded(
              flex: 2,
              child: Template01LeftColumn(
                  data: data, iconFont: iconFont), // ✅ UPDATED
            ),
            pw.Expanded(
              flex: 3,
              child: Template01RightColumn(
                // ✅ UPDATED
                data: data,
                iconFont: iconFont,
                showReferencesNote: showReferencesNote,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
