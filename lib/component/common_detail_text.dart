import 'package:flutter/material.dart';
import 'package:infyhms_flutter/constant/color_const.dart';
import 'package:infyhms_flutter/constant/text_style_const.dart';

class CommonDetailText extends StatelessWidget {
  final double width;
  final String titleText;
  final String descriptionText;
  const CommonDetailText({
    Key? key,
    required this.width,
    required this.titleText,
    required this.descriptionText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Center(
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                titleText,
                style: TextStyleConst.hintTextStyle(ColorConst.hintGreyColor),
              ),
            ),
          ),
        ),
        Expanded(
          child: Text(
            descriptionText,
            style: TextStyleConst.mediumTextStyle(
              ColorConst.blackColor,
              width * 0.045,
            ),
          ),
        ),
      ],
    );
  }
}
