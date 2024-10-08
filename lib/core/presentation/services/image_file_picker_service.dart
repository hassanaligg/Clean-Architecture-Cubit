import 'dart:io';

import 'package:dawaa24/core/utils/extentions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../../router.dart';
import '../../domain/params/show_pdf_params.dart';

class ImageFilePickerService {
  static ImageFilePickerService? _instance;
  final ImagePicker picker;

  ImageFilePickerService._(this.picker);

  factory ImageFilePickerService.getInstance() {
    _instance ??= ImageFilePickerService._(ImagePicker());
    return _instance!;
  }

  Future<File?> pickImageFromGallery(
      {int? imageQuality, int maxSizeMB = 5, bool limited = true}) async {
    final ImagePicker picker = ImagePicker();
    final XFile? xFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: imageQuality,
    );

    if (xFile == null) {
      return null;
    }

    File file = File(xFile.path);
    int fileSizeInBytes = await file.length();
    double fileSizeInMB = fileSizeInBytes / (1024 * 1024);

    if (fileSizeInMB <= maxSizeMB || limited == false) {
      return file;
    } else {
      "chat.image_5MB".tr().showToast(toastGravity: ToastGravity.CENTER);
      return null;
    }
  }

  Future<File?> pickImageFromCamera(
      {int maxSizeMB = 5, bool limited = true}) async {
    final ImagePicker picker = ImagePicker();
    final XFile? xFile = await picker.pickImage(source: ImageSource.camera);

    if (xFile == null) {
      return null;
    }

    File file = File(xFile.path);
    int fileSizeInBytes = await file.length();
    double fileSizeInMB = fileSizeInBytes / (1024 * 1024);
    if (fileSizeInMB <= maxSizeMB || limited == false) {
      return file;
    } else {
      "chat.image_5MB".tr().showToast(toastGravity: ToastGravity.CENTER);
      return null;
    }
  }

  Future<String?> pickFile(BuildContext context) async {
    try {
      const XTypeGroup typeGroup = XTypeGroup(
        label: 'documents',
        extensions: <String>['pdf'],
        uniformTypeIdentifiers: ['pdf'],
      );
      final XFile? file =
          await openFile(acceptedTypeGroups: <XTypeGroup>[typeGroup]);
      if (file != null) {
        File res = File(file.path);
        int fileSizeInBytes = await res.length();
        double fileSizeInMB = fileSizeInBytes / (1024 * 1024);
        if (fileSizeInMB <= 5) {
          bool? confirmSend = await context.push(AppPaths.externalPaths.showPdf,
              extra: ShowPdfParams(file: res.path, isNetwork: false));
          if (confirmSend == true) {
            return res.path;
          } else {
            return null;
          }
        } else {
          Fluttertoast.showToast(
            msg: "chat.file_5MB".tr(),
            gravity: ToastGravity.CENTER,
          );
          return null;
        }
      } else {
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
