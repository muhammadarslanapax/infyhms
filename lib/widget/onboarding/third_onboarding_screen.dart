import 'package:flutter/material.dart';
import 'package:infyhms_flutter/constant/color_const.dart';
import 'package:infyhms_flutter/constant/text_style_const.dart';
import 'package:infyhms_flutter/utils/image_utils.dart';
import 'package:infyhms_flutter/utils/string_utils.dart';

class ThirdOnBoardingScreen extends StatelessWidget {
  const ThirdOnBoardingScreen({
    Key? key,
    required this.height,
    required this.width,
  }) : super(key: key);

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage(ImageUtils.onBoardingBg),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: height / 3.2,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(ImageUtils.introThree),
              ),
            ),
          ),
          SizedBox(height: height * 0.06),
          Text(
            StringUtils.introThreeTitle,
            style: TextStyleConst.boldTextStyle(Colors.black, width * 0.06),
          ),
          SizedBox(height: height * 0.02),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              StringUtils.introThreeSubTitle,
              textAlign: TextAlign.center,
              style: TextStyleConst.hintTextStyle(ColorConst.hintGreyColor),
            ),
          ),
        ],
      ),
    );
  }
}
