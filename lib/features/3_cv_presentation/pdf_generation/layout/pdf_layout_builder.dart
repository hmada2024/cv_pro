// lib/features/3_cv_presentation/pdf_generation/layout/pdf_layout_builder.dart
import 'dart:typed_data';
import 'package:cv_pro/features/2_cv_editor/form/data/models/cv_data.dart';
import 'package:cv_pro/features/3_cv_presentation/pdf_generation/cv_designs/classic_two_column/classic_template_layout.dart';
import 'package:cv_pro/features/3_cv_presentation/pdf_generation/cv_designs/modern_top_header/modern_template_layout.dart';
import 'package:cv_pro/features/3_cv_presentation/pdf_generation/cv_designs/yellow_design/yellow_template_layout.dart';
import 'package:pdf/widgets.dart' as pw;

pw.Widget buildPdfLayout({
  required CVData data,
  required pw.Font iconFont,
  required bool showReferencesNote,
  required Uint8List? profileImageData,
  required String templateId,
}) {
  switch (templateId) {
    case 'template_1':
      return ClassicTemplateLayout(
        data: data,
        iconFont: iconFont,
        showReferencesNote: showReferencesNote,
        profileImageData: profileImageData,
      );
    case 'template_2':
      return ModernTopHeaderLayout(
        data: data,
        iconFont: iconFont,
        showReferencesNote: showReferencesNote,
        profileImageData: profileImageData,
      );
    case 'template_3': // إضافة الحالة الجديدة للقالب الأصفر
      return YellowTemplateLayout(
        data: data,
        iconFont: iconFont,
        showReferencesNote: showReferencesNote,
        profileImageData: profileImageData,
      );
    default:
      // قالب افتراضي في حالة عدم العثور على المطلوب
      return ClassicTemplateLayout(
        data: data,
        iconFont: iconFont,
        showReferencesNote: showReferencesNote,
        profileImageData: profileImageData,
      );
  }
}
