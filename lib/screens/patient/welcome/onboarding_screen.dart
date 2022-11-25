import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infyhms_flutter/component/common_button.dart';
import 'package:infyhms_flutter/constant/color_const.dart';
import 'package:infyhms_flutter/constant/text_style_const.dart';
import 'package:infyhms_flutter/controller/patient/intro_controller/onboarding_controller.dart';
import 'package:infyhms_flutter/screens/patient/auth/login_screen.dart';
import 'package:infyhms_flutter/utils/preference_utils.dart';
import 'package:infyhms_flutter/widget/onboarding/first_onboarding_screen.dart';
import 'package:infyhms_flutter/widget/onboarding/second_onboarding_screen.dart';
import 'package:infyhms_flutter/widget/onboarding/third_onboarding_screen.dart';
import 'package:onboarding_animation/onboarding_animation.dart';

class OnBoardingScreen extends StatelessWidget {
  OnBoardingScreen({Key? key}) : super(key: key);
  final OnBoardingController onBoardingController = Get.put(OnBoardingController());
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConst.whiteColor,
        body: Stack(
          children: [
            OnBoardingAnimation(
              controller: onBoardingController.controller,
              pages: [
                /// First page
                FirstOnBoardingScreen(height: height, width: width),

                /// Second page
                SecondOnBoardingScreen(height: height, width: width),

                /// Third page
                ThirdOnBoardingScreen(height: height, width: width),
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
                    /// Three indicator
                    Obx(() => Row(
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
                        )),

                    /// Next button
                    Obx(() => CommonButton(
                          textStyleConst: TextStyleConst.mediumTextStyle(ColorConst.whiteColor, width * 0.05),
                          width: width * 0.25,
                          height: 45,
                          text: onBoardingController.index.value != 2.0 ? "Next" : "Start",
                          color: ColorConst.blueColor,
                          onTap: () {
                            if (onBoardingController.index.value != 2.0) {
                              onBoardingController.controller.nextPage(
                                duration: const Duration(
                                  milliseconds: 1000,
                                ),
                                curve: Curves.ease,
                              );
                            } else {
                              PreferenceUtils.setBoolValue("isShowOnBoarding", false);
                              Get.offAll(() => LoginScreen(), transition: Transition.fade);
                            }
                          },
                        )),
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
