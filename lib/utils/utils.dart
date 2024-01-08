import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class AppUtils {
  static void showPickImageDialog(
      BuildContext context, AsyncCallback byCamera, AsyncCallback byGallery) {
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext cont) {
          return CupertinoActionSheet(
            actions: [
              CupertinoActionSheetAction(
                onPressed: byCamera,
                child: const Text(
                  'Use Camera',
                  textScaler: TextScaler.linear(1.0),
                ),
              ),
              CupertinoActionSheetAction(
                onPressed: byGallery,
                child: const Text(
                  'Upload from files',
                  textScaler: TextScaler.linear(1.0),
                ),
              ),
            ],
            cancelButton: CupertinoActionSheetAction(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Not Now',
                textScaler: TextScaler.linear(1.0),
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
          );
        });
  }

  static bool isValidEmail(String email) {
    // Regular expression for a simple email validation
    RegExp emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');

    return emailRegex.hasMatch(email);
  }

  static Timer? _timer;

  static void showLoadingNoTimer() {
    _timer?.cancel();
    EasyLoading.show(
      status: 'Please wait...',
      dismissOnTap: false,
      maskType: EasyLoadingMaskType.black,
    );
  }

  static void cancelLoading() async {
    _timer?.cancel();
    await EasyLoading.dismiss();
  }
}
