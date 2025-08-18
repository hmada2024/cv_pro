// lib/features/3_cv_presentation/pdf_generation/main_builder/pdf_layout_builder.dart
import 'dart:typed_data';
import 'package:cv_pro/features/2_cv_editor/form/data/models/cv_data.dart';
import 'package:cv_pro/features/3_cv_presentation/pdf_generation/cv_designs/black_blue_asymmetric/layout_black_blue_asymmetric.dart';
import 'package:cv_pro/features/3_cv_presentation/pdf_generation/cv_designs/two_vertical_columns/layout_two_vertical_columns.dart';
import 'package:cv_pro/features/3_cv_presentation/pdf_generation/cv_designs/blue_top_header/layout_blue_top_header.dart';
import 'package:cv_pro/features/3_cv_presentation/pdf_generation/cv_designs/intersection_designs/yellow_intersection/layout_yellow_intersection.dart';
import 'package:cv_pro/features/3_cv_presentation/pdf_generation/core/pdf_template_layout_contract.dart';
import 'package:pdf/widgets.dart' as pw;

PdfTemplateLayout buildPdfLayout({
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
    case 'template_3':
      return YellowTemplateLayout(
        data: data,
        iconFont: iconFont,
        showReferencesNote: showReferencesNote,
        profileImageData: profileImageData,
      );
    case 'template_4':
      return BlackBlueAsymmetricLayout(
        data: data,
        iconFont: iconFont,
        showReferencesNote: showReferencesNote,
        profileImageData: profileImageData,
      );
    default:
      return ClassicTemplateLayout(
        data: data,
        iconFont: iconFont,
        showReferencesNote: showReferencesNote,
        profileImageData: profileImageData,
      );
  }
}
