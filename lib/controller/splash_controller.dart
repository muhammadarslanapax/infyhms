import 'package:get/get.dart';
import 'package:infyhms_flutter/screens/auth/login_screen.dart';
import 'package:infyhms_flutter/screens/home_screen.dart';
import 'package:infyhms_flutter/screens/welcome/onboarding_screen.dart';
import 'package:infyhms_flutter/utils/preference_utils.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    Future.delayed(
      const Duration(seconds: 5),
      () {
        if (PreferenceUtils.getBoolValue("isShowOnBoarding")) {
          Get.offAll(() => OnBoardingScreen(), transition: Transition.fade);
        } else {
          if (PreferenceUtils.getStringValue("token") != "") {
            Get.offAll(() => const HomeScreen(), transition: Transition.fade);
          } else {
            Get.offAll(() => LoginScreen(), transition: Transition.fade);
          }
        }
      },
    );
    // TODO: implement onInit
    super.onInit();
  }
}
