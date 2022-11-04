import 'package:flutter/material.dart';
import 'package:infyhms_flutter/constant/text_style_const.dart';

class DisplaySnackBar {
  static displaySnackBar(BuildContext context, String content, [int? sec]) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: const Color(0xff2d2d2d),
        content: Text(
          content,
          style: TextStyleConst.mediumTextStyle(Colors.white, 17),
        ),
        elevation: 0,
        duration: const Duration(seconds: 2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        margin: const EdgeInsets.all(10),
        dismissDirection: DismissDirection.up,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
