import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:cv_pro/features/cv_form/data/models/cv_data.dart';

// هذه الدالة مسؤولة فقط عن التصميم والترتيب (نسخة اللغة الإنجليزية فقط).
pw.Widget buildClassicTemplate({
  required CVData data,
}) {
  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      // --- Header Section ---
      pw.Container(
        alignment: pw.Alignment.center,
        child: pw.Column(
          children: [
            pw.Text(data.personalInfo.name,
                style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold, fontSize: 26)),
            pw.SizedBox(height: 5),
            pw.Text(data.personalInfo.jobTitle,
                style: const pw.TextStyle(
                    fontSize: 16, color: PdfColors.grey700)),
            pw.SizedBox(height: 5),
            pw.Text(data.personalInfo.email,
                style: const pw.TextStyle(
                    fontSize: 12, color: PdfColors.blue700)),
          ],
        ),
      ),
      pw.SizedBox(height: 20),
      pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          // --- Left Column (Experience) ---
          pw.Expanded(
            flex: 2,
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                _buildSectionTitle('WORK EXPERIENCE'),
                ...data.experiences.map((exp) => _buildExperienceItem(exp)),
              ],
            ),
          ),
          pw.SizedBox(width: 30),
          // --- Right Column (Skills & Languages) ---
          pw.Expanded(
            flex: 1,
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                _buildSectionTitle('SKILLS'),
                ...data.skills.map((skill) => pw.Bullet(
                      text: skill.name,
                      style: const pw.TextStyle(fontSize: 11),
                    )),
                pw.SizedBox(height: 20),
                _buildSectionTitle('LANGUAGES'),
                ...data.languages.map((lang) => pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text(lang.name,
                              style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold,
                                  fontSize: 11)),
                          pw.Text(lang.proficiency,
                              style: const pw.TextStyle(
                                  fontSize: 10, color: PdfColors.grey600)),
                          pw.SizedBox(height: 5),
                        ])),
              ],
            ),
          ),
        ],
      ),
    ],
  );
}

pw.Widget _buildSectionTitle(String title) {
  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      pw.Text(
        title.toUpperCase(),
        style: pw.TextStyle(
          fontWeight: pw.FontWeight.bold,
          fontSize: 14,
          color: PdfColors.blueGrey800,
        ),
      ),
      pw.Container(height: 2, width: 40, color: PdfColors.blueGrey800),
      pw.SizedBox(height: 10),
    ],
  );
}

pw.Widget _buildExperienceItem(Experience exp) {
  final formatter = DateFormat('MMM yyyy', 'en_US');
  return pw.Container(
    margin: const pw.EdgeInsets.only(bottom: 15),
    child: pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text(exp.position,
                style: pw.TextStyle(
                    fontSize: 13, fontWeight: pw.FontWeight.bold)),
            pw.Text(
              '${formatter.format(exp.startDate)} - ${formatter.format(exp.endDate)}',
              style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey600),
            ),
          ],
        ),
        pw.Text(exp.companyName,
            style:
                const pw.TextStyle(color: PdfColors.grey700, fontSize: 11)),
        pw.SizedBox(height: 5),
        pw.Text(
          exp.description,
          style: const pw.TextStyle(fontSize: 11, lineSpacing: 2),
          textAlign: pw.TextAlign.justify,
        ),
      ],
    ),
  );
}