// features/pdf_export/templates/two_column_01/template_01_right_column.dart
import 'package:cv_pro/features/cv_form/data/models/cv_data.dart';
import 'package:cv_pro/features/pdf_export/templates/two_column_01/widgets/skill_progress_item.dart';
import 'package:cv_pro/features/pdf_export/templates/two_column_02/widgets/experience_item.dart';
import 'package:intl/intl.dart';
import 'package:pdf/widgets.dart' as pw;
import 'template_01_colors.dart';
import 'widgets/section_header_pill.dart';

class Template01RightColumn extends pw.StatelessWidget {
  final CVData data;
  final pw.Font iconFont;
  final bool showReferencesNote;

  Template01RightColumn({
    required this.data,
    required this.iconFont,
    required this.showReferencesNote,
  });

  String _educationLevelToString(EducationLevel level) {
    switch (level) {
      case EducationLevel.bachelor:
        return "Bachelor's Degree";
      case EducationLevel.master:
        return "Master's Degree";
      case EducationLevel.doctor:
        return 'Doctorate';
    }
  }

  // ✅✅ FIXED: The entire build method was missing. It has been restored. ✅✅
  @override
  pw.Widget build(pw.Context context) {
    final sortedEducation = List<Education>.from(data.education)
      ..sort((a, b) {
        final levelComparison = b.level.index.compareTo(a.level.index);
        if (levelComparison != 0) return levelComparison;
        if (a.isCurrent && !b.isCurrent) return -1;
        if (!a.isCurrent && b.isCurrent) return 1;
        if (!a.isCurrent && !b.isCurrent) {
          return b.endDate!.compareTo(a.endDate!);
        }
        return b.startDate.compareTo(a.startDate);
      });

    final sortedExperience = List<Experience>.from(data.experiences)
      ..sort((a, b) {
        if (a.isCurrent && !b.isCurrent) return -1;
        if (!a.isCurrent && b.isCurrent) return 1;
        if (!a.isCurrent && !b.isCurrent) {
          return b.endDate!.compareTo(a.endDate!);
        }
        return b.startDate.compareTo(a.startDate);
      });

    return pw.Container(
      padding: const pw.EdgeInsets.fromLTRB(20, 25, 20, 20),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          if (sortedExperience.isNotEmpty)
            SectionHeaderPill(
              title: 'Experience',
              backgroundColor: Template01Colors.primaryBlueDark,
              textColor: Template01Colors.lightText,
            ),
          ...sortedExperience.map((exp) => ExperienceItem(
                exp,
                iconFont: iconFont,
                positionColor: Template01Colors.darkText,
                companyColor: Template01Colors.subtleText,
              )),
          if (sortedExperience.isNotEmpty) pw.SizedBox(height: 20),
          if (sortedEducation.isNotEmpty)
            SectionHeaderPill(
              title: 'Education',
              backgroundColor: Template01Colors.primaryBlueDark,
              textColor: Template01Colors.lightText,
            ),
          ...sortedEducation.map((edu) {
            final formatter = DateFormat('yyyy');
            final dateRange =
                '${formatter.format(edu.startDate)} - ${edu.isCurrent ? "Present" : formatter.format(edu.endDate!)}';
            return pw.Padding(
              padding: const pw.EdgeInsets.only(bottom: 10),
              child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      '${_educationLevelToString(edu.level)} ${edu.degreeName}',
                      style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold,
                          color: Template01Colors.darkText),
                    ),
                    pw.Text(
                      '${edu.school} / $dateRange',
                      style: const pw.TextStyle(
                          color: Template01Colors.subtleText, fontSize: 9),
                    ),
                  ]),
            );
          }),
          if (sortedEducation.isNotEmpty) pw.SizedBox(height: 20),
          if (data.skills.isNotEmpty)
            SectionHeaderPill(
              title: 'Skills Summary',
              backgroundColor: Template01Colors.primaryBlueDark,
              textColor: Template01Colors.lightText,
            ),
          ...data.skills.map((skill) => SkillProgressItem(skill: skill)),
          if (data.skills.isNotEmpty) pw.SizedBox(height: 20),
          _buildReferencesSection(data, showReferencesNote),
        ],
      ),
    );
  }

  pw.Widget _buildReferencesSection(CVData data, bool showReferencesNote) {
    if (showReferencesNote) {
      return pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          SectionHeaderPill(
            title: 'References',
            backgroundColor: Template01Colors.primaryBlueDark,
            textColor: Template01Colors.lightText,
          ),
          pw.Text(
            'References available upon request.',
            style: pw.TextStyle(
              fontSize: 10,
              fontStyle: pw.FontStyle.italic,
              color: Template01Colors.subtleText,
            ),
          ),
        ],
      );
    } else if (data.references.isNotEmpty) {
      return pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          SectionHeaderPill(
            title: 'References',
            backgroundColor: Template01Colors.primaryBlueDark,
            textColor: Template01Colors.lightText,
          ),
          pw.Wrap(
            spacing: 20,
            runSpacing: 15,
            children:
                data.references.map((ref) => _buildReferenceItem(ref)).toList(),
          ),
        ],
      );
    }
    return pw.SizedBox();
  }

  pw.Widget _buildReferenceItem(Reference reference) {
    return pw.SizedBox(
      width: 200,
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            reference.name,
            style: pw.TextStyle(
              fontWeight: pw.FontWeight.bold,
              color: Template01Colors.darkText,
            ),
          ),
          pw.Text(
            '${reference.position}, ${reference.company}',
            style: pw.TextStyle(
              fontSize: 9,
              color: Template01Colors.subtleText,
              fontStyle: pw.FontStyle.italic,
            ),
          ),
          pw.SizedBox(height: 4),
          pw.Text(
            reference.email,
            style: const pw.TextStyle(
              fontSize: 9,
              color: Template01Colors.subtleText,
            ),
          ),
          if (reference.phone != null && reference.phone!.isNotEmpty)
            pw.Text(
              reference.phone!,
              style: const pw.TextStyle(
                fontSize: 9,
                color: Template01Colors.subtleText,
              ),
            ),
        ],
      ),
    );
  }
}
