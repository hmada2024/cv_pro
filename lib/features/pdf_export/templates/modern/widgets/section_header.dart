import 'package:pdf/widgets.dart' as pw;
import '../modern_template_colors.dart';

enum HeaderType { forLeftColumn, forRightColumn }

class SectionHeader extends pw.StatelessWidget {
  final String title;
  final HeaderType type;

  SectionHeader({required this.title, required this.type});

  @override
  pw.Widget build(pw.Context context) {
    // ✅✅ تم التصحيح: إزالة المتغيرات غير المستخدمة واستخدام الشروط مباشرة ✅✅
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          title,
          style: pw.TextStyle(
            color: type == HeaderType.forLeftColumn
                ? ModernTemplateColors.lightText
                : ModernTemplateColors.primary,
            fontWeight: pw.FontWeight.bold,
            fontSize: type == HeaderType.forLeftColumn ? 14 : 16,
          ),
        ),
        pw.Container(
          height: 2,
          width: type == HeaderType.forLeftColumn ? 30 : 50,
          color: ModernTemplateColors.accent,
          margin: const pw.EdgeInsets.only(top: 4, bottom: 12),
        ),
      ],
    );
  }
}