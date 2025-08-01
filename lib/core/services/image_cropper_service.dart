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
          lockAspectRatio: true,
          hideBottomControls:
              true,
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
