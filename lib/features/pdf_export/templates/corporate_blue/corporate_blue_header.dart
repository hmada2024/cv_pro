import 'package:pdf/widgets.dart' as pw;
import 'package:cv_pro/features/cv_form/data/models/cv_data.dart';
import 'package:cv_pro/features/pdf_export/templates/corporate_blue/corporate_blue_template_colors.dart';

class CorporateBlueHeader extends pw.StatelessWidget {
  final CVData data;
  final pw.ImageProvider? profileImage;

  CorporateBlueHeader({
    required this.data,
    this.profileImage,
  });

  @override
  pw.Widget build(pw.Context context) {
    return pw.Container(
      color: CorporateBlueColors.primaryBlue,
      padding: const pw.EdgeInsets.all(20),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          // Name and Title
          pw.Expanded(
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              mainAxisAlignment: pw.MainAxisAlignment.center,
              children: [
                pw.Text(
                  data.personalInfo.name.toUpperCase(),
                  style: pw.TextStyle(
                    color: CorporateBlueColors.lightText,
                    fontSize: 28,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 5),
                pw.Text(
                  data.personalInfo.jobTitle.toUpperCase(),
                  style: const pw.TextStyle(
                    color: CorporateBlueColors.lightText,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          // Profile Image
          if (profileImage != null)
            pw.SizedBox(
              width: 90,
              height: 90,
              child: pw.ClipOval(
                // ✅✅ تم التصحيح: إضافة '!' لتأكيد أن القيمة ليست null هنا ✅✅
                child: pw.Image(profileImage!, fit: pw.BoxFit.cover),
              ),
            ),
        ],
      ),
    );
  }
}