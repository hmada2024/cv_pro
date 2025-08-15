// features/pdf_export/data/services/pdf_service_impl.dart
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:cv_pro/core/services/pdf_service.dart';
import 'package:cv_pro/features/cv_form/data/models/cv_data.dart';

/// that is independent of the template itself.
final showReferencesNoteProvider = StateProvider<bool>((ref) => true);

class PdfServiceImpl implements PdfService {
  @override
  Future<Uint8List> generateCv(CVData data,
      {required bool showReferencesNote}) async {
    // 1. إنشاء مستند PDF جديد.
    final doc = pw.Document();

    // 2. تحميل الخطوط اللازمة.
    // نقوم بتحميل نسخة عادية ونسخة عريضة للنصوص، وخط مخصص للأيقونات.
    final font = await PdfGoogleFonts.cairoRegular();
    final boldFont = await PdfGoogleFonts.cairoBold();
    final iconFontData =
        await rootBundle.load('assets/fonts/MaterialIcons-Regular.ttf');
    final iconFont = pw.Font.ttf(iconFontData);

    // 3. بناء واجهة القالب الوحيد المعتمد.
    // كل المنطق الخاص بالقالب موجود داخل دالة buildTemplate02.
    final templateWidget = await buildTemplate02(
      data: data,
      iconFont: iconFont,
      showReferencesNote: showReferencesNote,
    );

    // 4. إضافة الواجهة كصفحة جديدة في المستند.
    // نطبق الخطوط التي تم تحميلها على "theme" الصفحة.
    doc.addPage(
      pw.Page(
        margin: pw.EdgeInsets.zero, // القالب يعالج الهوامش الداخلية بنفسه.
        theme: pw.ThemeData.withFont(
          base: font,
          bold: boldFont,
        ),
        build: (pw.Context context) {
          return templateWidget;
        },
      ),
    );

    // 5. حفظ المستند وإعادته كقائمة من البايتات (byte list).
    return doc.save();
  }
}
