import 'package:cv_pro/features/cv_form/data/models/cv_data.dart';
import 'package:pdf/widgets.dart' as pw;
import '../creative_template_colors.dart';

class LanguageItem extends pw.StatelessWidget {
  final Language language;

  LanguageItem(this.language);

  @override
  pw.Widget build(pw.Context context) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 4),
      child: pw.Text(
        '${language.name} (${language.proficiency})',
        style: const pw.TextStyle(
            color: ModernTemplateColors.lightText, fontSize: 10),
      ),
    );
  }
}
