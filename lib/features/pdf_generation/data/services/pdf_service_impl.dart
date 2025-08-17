// lib/features/pdf_export/data/services/pdf_service_impl.dart
import 'package:cv_pro/features/design_selection/models/template_model.dart';
import 'package:flutter/foundation.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:cv_pro/core/services/pdf_service.dart';
import 'package:cv_pro/features/form/data/models/cv_data.dart';
import 'package:cv_pro/features/pdf_generation/layout/pdf_layout_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Provider لتحديد ما إذا كان يجب إظهار ملاحظة "المراجع عند الطلب"
final showReferencesNoteProvider = StateProvider<bool>((ref) => true);

// Typedef لتمرير كل البيانات اللازمة إلى isolate الحاسوبي
typedef PdfGenerationData = ({
  CVData data,
  bool showReferencesNote,
  ByteData fontData,
  ByteData boldFontData,
  ByteData iconFontData,
  Uint8List? profileImageData,
  String templateId,
});

// هذه الدالة تعمل في isolate منفصل لتجنب تجميد الواجهة
Future<Uint8List> _generatePdfInBackground(PdfGenerationData params) async {
  final doc = pw.Document();

  final font = pw.Font.ttf(params.fontData);
  final boldFont = pw.Font.ttf(params.boldFontData);
  final iconFont = pw.Font.ttf(params.iconFontData);

  // استدعاء المُوجِّه (builder) الذي سيختار لوحة البناء الصحيحة
  final layoutWidget = buildPdfLayout(
    data: params.data,
    iconFont: iconFont,
    showReferencesNote: params.showReferencesNote,
    profileImageData: params.profileImageData,
    templateId: params.templateId,
  );

  doc.addPage(
    pw.Page(
      margin: pw.EdgeInsets.zero,
      theme: pw.ThemeData.withFont(
        base: font,
        bold: boldFont,
        fontFallback: [iconFont],
      ),
      build: (pw.Context context) {
        return layoutWidget;
      },
    ),
  );

  return doc.save();
}

class PdfServiceImpl implements PdfService {
  @override
  Future<Uint8List> generateCv(CVData data,
      {required bool showReferencesNote}) {
    // هذه الدالة لم تعد مستخدمة مباشرة، الـ provider يتعامل مع كل شيء
    throw UnimplementedError(
        'generateCv should be called via the provider which handles asset loading.');
  }

  // دالة ثابتة جديدة تستقبل كل البيانات المطلوبة بما فيها القالب
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

    // استخدام compute لتشغيل الدالة في isolate منفصل
    return await compute(_generatePdfInBackground, params);
  }
}
