import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommonLoader {
  static void showLoader(context) {
    if (Platform.isIOS) {
      showIOSLoader(context);
    } else {
      showAndroidLoader(context);
    }
  }

  static void showIOSLoader(context) {
    Get.dialog(CupertinoAlertDialog(
      content: Row(
        children: const [
          CupertinoActivityIndicator(),
          SizedBox(width: 10),
          Text("Please wait"),
        ],
      ),
    ));
  }

  static void showAndroidLoader(context) {
    Get.dialog(
      AlertDialog(
        content: Row(
          children: const [
            CircularProgressIndicator(),
            SizedBox(width: 10),
            Text("Please wait"),
          ],
        ),
      ),
    );
  }
}
