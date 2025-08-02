// features/pdf_export/templates/two_column_02/widgets/contact_info_line.dart
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../template_02_colors.dart'; // ✅ UPDATED IMPORT

class ContactInfoLine extends pw.StatelessWidget {
  final pw.IconData iconData;
  final String text;
  final pw.Font iconFont;
  final PdfColor textColor;
  final PdfColor iconColor;

  ContactInfoLine({
    required this.iconData,
    required this.text,
    required this.iconFont,
    this.textColor = Template02Colors.lightText, // ✅ UPDATED
    this.iconColor = Template02Colors.accent,   // ✅ UPDATED
  });
  // ... rest of file is the same
}