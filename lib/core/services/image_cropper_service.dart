// ignore_for_file: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';

class ImageCropperService {
  Future<CroppedFile?> cropImage({
    required String sourcePath,
    required Color toolbarColor,
    required Color toolbarWidgetColor,
    required Color backgroundColor,
    required Color activeControlsWidgetColor,
  }) async {
    final CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: sourcePath,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop Image',
          toolbarColor: toolbarColor,
          toolbarWidgetColor: toolbarWidgetColor,
          backgroundColor: backgroundColor,
          activeControlsWidgetColor: activeControlsWidgetColor,
          cropStyle: CropStyle.circle,
          initAspectRatio: CropAspectRatioPreset.square,
          hideBottomControls: true,
          aspectRatioPresets: [
            CropAspectRatioPreset.square,
          ],

          // --- ملاحظة معمارية هامة ---
          // بعد اختبارات مكثفة، تم اعتماد هذه الإعدادات بشكل نهائي ومدروس لأداة قص الصور.
          // يرجى عدم تغيير هذه الإعدادات دون فهم عميق للعواقب.
          //
          // **السبب الرئيسي:**
          // الإعداد `lockAspectRatio: true` هو إعداد **حاسم ومصيري**. إنه التكوين الوحيد الذي يسمح
          // للمستخدم **بتحريك الصورة (Panning)** بشكل صحيح لوضع العنصر المطلوب (مثل الوجه)
          // في منتصف منطقة القص الدائرية.
          //
          // **السلوك المعروف والحل البديل:**
          // مع هذا الإعداد، يوجد تأثير جانبي معروف في المكتبة الأصلية (native library):
          //   - تحريك الصورة (Pan): يعمل بشكل ممتاز.
          //   - تكبير الصورة عبر القرص (Pinch-to-zoom IN): يعمل بشكل ممتاز.
          //   - تصغير الصورة عبر القرص (Pinch-to-zoom OUT): لا يعمل. ستعود الصورة إلى حجمها الأدنى تلقائيًا.
          //
          // **الطريقة الرسمية والمعتمدة للتحكم في التكبير/التصغير هي عبر تغيير حجم إطار القص:**
          //   - لجعل العنصر يبدو أكبر (Zoom In): اسحب زوايا إطار القص **للداخل**.
          //   - لجعل العنصر يبدو أصغر (Zoom Out): اسحب زوايا إطار القص **للخارج**.
          //
          // **تحذير:**
          // تم اختبار تغيير `lockAspectRatio` إلى `false` وقد أدى ذلك إلى كسر ميزة التحريك بشكل كامل
          // (حيث تتحرك الصورة والإطار معًا)، مما يجعل الأداة غير قابلة للاستخدام.
          lockAspectRatio: true,
        ),
        IOSUiSettings(
          title: 'Crop Image',
          aspectRatioPickerButtonHidden: true,
          aspectRatioLockEnabled: true,
          resetAspectRatioEnabled: false,
        ),
      ],
    );
    return croppedFile;
  }
}
