import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommonLoader {
  static void showLoader(context) {
    if (Platform.isIOS) {
      showIOSLoader(context);
    } else {
      showAndroidLoader(context);
    }
  }

  static void showIOSLoader(context) {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          content: Row(
            children: const [
              CupertinoActivityIndicator(),
              SizedBox(width: 10),
              Text("Please wait"),
            ],
          ),
        );
      },
      barrierDismissible: false,
    );
  }

  static void showAndroidLoader(context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Row(
            children: const [
              CircularProgressIndicator(),
              SizedBox(width: 10),
              Text("Please wait"),
            ],
          ),
        );
      },
    );
  }
}
