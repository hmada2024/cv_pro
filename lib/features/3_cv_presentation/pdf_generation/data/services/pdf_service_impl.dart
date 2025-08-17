// lib/features/3_cv_presentation/pdf_generation/data/services/pdf_service_impl.dart
import 'package:cv_pro/features/3_cv_presentation/design_selection/models/template_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:cv_pro/core/services/pdf_service.dart';
import 'package:cv_pro/features/2_cv_editor/form/data/models/cv_data.dart';
import 'package:cv_pro/features/3_cv_presentation/pdf_generation/layout/pdf_layout_builder.dart';

final showReferencesNoteProvider = StateProvider<bool>((ref) => true);

typedef PdfGenerationData = ({
  CVData data,
  bool showReferencesNote,
  ByteData fontData,
  ByteData boldFontData,
  ByteData iconFontData,
  Uint8List? profileImageData,
  String templateId,
});

Future<Uint8List> _generatePdfInBackground(PdfGenerationData params) async {
  final doc = pw.Document();

  final font = pw.Font.ttf(params.fontData);
  final boldFont = pw.Font.ttf(params.boldFontData);
  final iconFont = pw.Font.ttf(params.iconFontData);

  // التغيير: نستقبل الآن الويدجت والهامش معًا من المهندس
  final pageConfig = buildPdfLayout(
    data: params.data,
    iconFont: iconFont,
    showReferencesNote: params.showReferencesNote,
    profileImageData: params.profileImageData,
    templateId: params.templateId,
  );

  doc.addPage(
    pw.Page(
      margin: pageConfig.margin,
      theme: pw.ThemeData.withFont(
        base: font,
        bold: boldFont,
        fontFallback: [iconFont],
      ),
      build: (pw.Context context) {
        return pageConfig.layout;
      },
    ),
  );

  return doc.save();
}

class PdfServiceImpl implements PdfService {
  @override
  Future<Uint8List> generateCv(CVData data,
      {required bool showReferencesNote}) {
    throw UnimplementedError(
        'generateCv should be called via the provider which handles asset loading.');
  }

  static Future<Uint8List> generateCvWithAssets({
    required CVData data,
    required bool showReferencesNote,
    required ByteData fontData,
    required ByteData boldFontData,
    required ByteData iconFontData,
    required Uint8List? profileImageData,
    required TemplateModel selectedTemplate,
  }) async {
    final params = (
      data: data,
      showReferencesNote: showReferencesNote,
      fontData: fontData,
      boldFontData: boldFontData,
      iconFontData: iconFontData,
      profileImageData: profileImageData,
      templateId: selectedTemplate.id,
    );

    return await compute(_generatePdfInBackground, params);
  }
}
