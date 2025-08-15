// features/pdf_export/templates/two_column_02/template_02_builder.dart
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:cv_pro/features/cv_form/data/models/cv_data.dart';
import 'left_column_template_02.dart'; // ✅ UPDATED IMPORT
import 'right_column_template_02.dart'; // ✅ UPDATED IMPORT

Future<pw.Widget> buildTemplate02( // ✅ UPDATED FUNCTION NAME
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

  return pw.Row(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      pw.Expanded(
        flex: 1,
        child: Template02LeftColumn( // ✅ UPDATED
          data: data,
          profileImage: profileImage,
          iconFont: iconFont,
        ),
      ),
      pw.Expanded(
        flex: 2,
        child: Template02RightColumn( // ✅ UPDATED
          data: data,
          iconFont: iconFont,
          showReferencesNote: showReferencesNote,
        ),
      ),
    ],
  );
}