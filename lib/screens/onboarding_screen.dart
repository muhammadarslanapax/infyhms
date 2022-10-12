import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infyhms_flutter/component/common_button.dart';
import 'package:infyhms_flutter/constant/color_const.dart';
import 'package:infyhms_flutter/constant/text_style_const.dart';
import 'package:infyhms_flutter/controller/onBoarding_controller.dart';
import 'package:infyhms_flutter/screens/login_screen.dart';
import 'package:infyhms_flutter/utils/image_utils.dart';
import 'package:infyhms_flutter/utils/string_utils.dart';
import 'package:onboarding_animation/onboarding_animation.dart';

class OnBoardingScreen extends StatelessWidget {
  OnBoardingScreen({Key? key}) : super(key: key);
  OnBoardingController onBoardingController = Get.put(OnBoardingController());
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            OnBoardingAnimation(
              controller: onBoardingController.controller,
              pages: [
                /// First page

                Container(
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
                            image: AssetImage(ImageUtils.introOne),
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.06),
                      Text(
                        StringUtils.introOneTitle,
                        style: TextStyleConst.boldTextStyle(Colors.black, width * 0.06),
                      ),
                      SizedBox(height: height * 0.02),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          StringUtils.introOneSubTitle,
                          textAlign: TextAlign.center,
                          style: TextStyleConst.hintTextStyle(ColorConst.hintGreyColor),
                        ),
                      ),
                    ],
                  ),
                ),

                /// Second page
                Container(
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
                            image: AssetImage(ImageUtils.introTwo),
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.06),
                      Text(
                        StringUtils.introTwoTitle,
                        style: TextStyleConst.boldTextStyle(Colors.black, width * 0.06),
                      ),
                      SizedBox(height: height * 0.02),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          StringUtils.introTwoSubTitle,
                          textAlign: TextAlign.center,
                          style: TextStyleConst.hintTextStyle(ColorConst.hintGreyColor),
                        ),
                      ),
                    ],
                  ),
                ),

                /// Third page
                Container(
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
                ),
              ],
              indicatorDotHeight: 20.0,
              indicatorDotWidth: 20.0,
              indicatorType: IndicatorType.scrollingDots,
              indicatorActiveDotColor: Colors.transparent,
              indicatorPosition: IndicatorPosition.bottomCenter,
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(
                      () => Row(
                        children: [
                          CircleAvatar(
                            radius: 5,
                            backgroundColor: onBoardingController.index.value == 0.0 ? ColorConst.blueColor : ColorConst.borderGreyColor,
                          ),
                          const SizedBox(width: 5),
                          CircleAvatar(
                            radius: 5,
                            backgroundColor: onBoardingController.index.value == 1.0 ? ColorConst.blueColor : ColorConst.borderGreyColor,
                          ),
                          const SizedBox(width: 5),
                          CircleAvatar(
                              radius: 5,
                              backgroundColor: onBoardingController.index.value == 2.0 ? ColorConst.blueColor : ColorConst.borderGreyColor),
                        ],
                      ),
                    ),
                    CommonButton(
                      width: width * 0.2,
                      height: 45,
                      text: "Next",
                      color: ColorConst.blueColor,
                      textColor: ColorConst.whiteColor,
                      onTap: () {
                        if (onBoardingController.index.value != 2.0) {
                          onBoardingController.controller.nextPage(
                            duration: const Duration(
                              milliseconds: 1000,
                            ),
                            curve: Curves.ease,
                          );
                        } else {
                          Get.to(() => LoginScreen(), transition: Transition.fade);
                        }
                      },
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
