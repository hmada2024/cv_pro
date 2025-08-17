// lib/features/pdf_export/data/providers/pdf_providers.dart
import 'dart:io';
import 'package:cv_pro/features/cv_templates/providers/template_provider.dart';
import 'package:flutter/services.dart';
import 'package:cv_pro/features/cv_form/data/providers/cv_form_provider.dart';
import 'package:cv_pro/features/pdf_export/data/services/pdf_service_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cv_pro/features/pdf_export/data/dummy_data/cv_data_dummy.dart';

// Typedef لتسهيل قراءة نوع البيانات
typedef PdfFontAssets = ({
  ByteData fontData,
  ByteData boldFontData,
  ByteData iconFontData,
});

// Provider لتحميل الخطوط والصور مرة واحدة
final pdfAssetsProvider = FutureProvider<PdfFontAssets>((ref) async {
  final fontData = await rootBundle.load('assets/fonts/Lato-Regular.ttf');
  final boldFontData = await rootBundle.load('assets/fonts/Lato-Bold.ttf');
  final iconFontData =
      await rootBundle.load('assets/fonts/MaterialIcons-Regular.ttf');

  return (
    fontData: fontData,
    boldFontData: boldFontData,
    iconFontData: iconFontData,
  );
});

// دالة مشتركة لتوليد PDF سواء كان للبيانات الحقيقية أو الوهمية
Future<Uint8List> _generatePdf(Ref ref, {required bool isDummy}) async {
  final fontAssets = await ref.watch(pdfAssetsProvider.future);
  final selectedTemplate = ref.read(selectedTemplateProvider);

  final cvData = isDummy ? createDummyCvData() : ref.read(activeCvProvider);
  final showNote = isDummy ? false : ref.read(showReferencesNoteProvider);

  if (cvData == null) {
    throw Exception('CV data is not available for PDF generation.');
  }

  Uint8List? profileImageData;
  final imagePath = cvData.personalInfo.profileImagePath;

  if (imagePath != null && imagePath.isNotEmpty) {
    // التعامل مع الصور من الـ assets (للبيانات الوهمية) أو من ملفات الجهاز
    if (imagePath.startsWith('assets/')) {
      profileImageData =
          (await rootBundle.load(imagePath)).buffer.asUint8List();
    } else {
      final imageFile = File(imagePath);
      if (await imageFile.exists()) {
        profileImageData = await imageFile.readAsBytes();
      }
    }
  }

  // استدعاء الخدمة الجديدة وتمرير القالب المختار
  return PdfServiceImpl.generateCvWithAssets(
    data: cvData,
    showReferencesNote: showNote,
    fontData: fontAssets.fontData,
    boldFontData: fontAssets.boldFontData,
    iconFontData: fontAssets.iconFontData,
    profileImageData: profileImageData,
    selectedTemplate: selectedTemplate,
  );
}

// Provider لتوليد PDF للبيانات الحقيقية للمستخدم
final pdfBytesProvider = FutureProvider.autoDispose<Uint8List>((ref) async {
  ref.watch(activeCvProvider);
  ref.watch(showReferencesNoteProvider);
  ref.watch(selectedTemplateProvider);
  return _generatePdf(ref, isDummy: false);
});

// Provider لتوليد PDF باستخدام بيانات وهمية لمعاينة القوالب
final dummyPdfBytesProvider =
    FutureProvider.autoDispose<Uint8List>((ref) async {
  ref.watch(selectedTemplateProvider);
  return _generatePdf(ref, isDummy: true);
});
