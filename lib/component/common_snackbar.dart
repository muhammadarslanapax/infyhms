import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infyhms_flutter/constant/text_style_const.dart';

class DisplaySnackBar {
  static displaySnackBar(String content, [int? sec]) {
    Get.rawSnackbar(
      backgroundColor: const Color(0xff2d2d2d),
      messageText: Text(
        content,
        style: TextStyleConst.mediumTextStyle(Colors.white, 15),
      ),
      borderRadius: 5,
      duration: Duration(seconds: sec ?? 3),
      margin: const EdgeInsets.all(10),
      dismissDirection: DismissDirection.horizontal,
    );
  }
}
