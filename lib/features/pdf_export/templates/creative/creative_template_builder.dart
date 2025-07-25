import 'dart:io';
import 'package:pdf/widgets.dart' as pw;
import 'package:cv_pro/features/cv_form/data/models/cv_data.dart';
import 'left_column.dart';
import 'right_column.dart';

Future<pw.Widget> buildModernTemplate({
  required CVData data,
  required pw.Font iconFont,
}) async {
  pw.ImageProvider? profileImage;
  if (data.personalInfo.profileImagePath != null) {
    final imageFile = File(data.personalInfo.profileImagePath!);
    if (await imageFile.exists()) {
      profileImage = pw.MemoryImage(await imageFile.readAsBytes());
    }
  }

  return pw.Row(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      // --- Left Column ---
      pw.Expanded(
        flex: 1,
        child: LeftColumn(
          data: data,
          profileImage: profileImage,
          iconFont: iconFont,
        ),
      ),
      // --- Right Column ---
      pw.Expanded(
        flex: 2,
        child: RightColumn(
          data: data,
        ),
      ),
    ],
  );
}
