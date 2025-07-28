import 'package:pdf/widgets.dart' as pw;
import 'package:cv_pro/features/cv_form/data/models/cv_data.dart';
import 'widgets/folded_banner.dart';

pw.Widget buildTimelineProfessionalTemplate({
  required CVData data,
  required pw.Font iconFont,
}) {
  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      pw.Padding(
        padding: const pw.EdgeInsets.all(40),
        child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('Testing the new component:',
                  style: const pw.TextStyle(fontSize: 20)),
              pw.SizedBox(height: 20),
              FoldedBanner(title: 'Education', bannerWidth: 250),
              pw.SizedBox(height: 30),
              FoldedBanner(title: 'Experience', bannerWidth: 250),
            ]),
      ),
    ],
  );
}
