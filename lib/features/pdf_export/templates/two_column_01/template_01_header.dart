// features/pdf_export/templates/two_column_01/template_01_header.dart
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:cv_pro/features/cv_form/data/models/cv_data.dart';
import 'template_01_colors.dart'; // ✅ UPDATED IMPORT

class Template01Header extends pw.StatelessWidget { // ✅ UPDATED CLASS NAME
  final CVData data;
  final pw.ImageProvider? profileImage;

  Template01Header({ // ✅ UPDATED CONSTRUCTOR
    required this.data,
    this.profileImage,
  });

  @override
  pw.Widget build(pw.Context context) {
    const double headerHeight = 120;
    const double avatarRadius = 50;

    return pw.Stack(
      overflow: pw.Overflow.visible,
      children: [
        pw.Container(
          height: headerHeight,
          decoration: const pw.BoxDecoration(
            gradient: pw.LinearGradient(
              colors: [
                Template01Colors.primaryBlueDark,
                Template01Colors.primaryBlueLight,
              ],
              begin: pw.Alignment.topLeft,
              end: pw.Alignment.bottomRight,
            ),
          ),
        ),
        pw.Positioned.fill(
          child: pw.Padding(
            padding: const pw.EdgeInsets.symmetric(horizontal: 30),
            child: pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: [
                if (profileImage != null)
                  pw.Container(
                    width: (avatarRadius + 4) * 2,
                    height: (avatarRadius + 4) * 2,
                    decoration: const pw.BoxDecoration(
                      color: PdfColors.white,
                      shape: pw.BoxShape.circle,
                    ),
                    child: pw.Padding(
                      padding: const pw.EdgeInsets.all(4),
                      child: pw.ClipOval(
                        child: pw.Image(profileImage!, fit: pw.BoxFit.cover),
                      ),
                    ),
                  ),
                pw.SizedBox(width: 20),
                pw.Expanded(
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    children: [
                      pw.Text(
                        data.personalInfo.name.toUpperCase(),
                        style: pw.TextStyle(
                          color: Template01Colors.lightText,
                          fontSize: 28,
                          fontWeight: pw.FontWeight.bold,
                          lineSpacing: 1.2,
                        ),
                      ),
                      pw.SizedBox(height: 5),
                      pw.Text(
                        data.personalInfo.jobTitle,
                        style: const pw.TextStyle(
                          color: Template01Colors.accentBlue,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}