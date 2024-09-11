import 'package:get/get.dart';
import 'package:infyhms_flutter/screens/home_screen.dart';
import 'package:infyhms_flutter/screens/patient/auth/login_screen.dart';
import 'package:infyhms_flutter/screens/patient/welcome/onboarding_screen.dart';
import 'package:infyhms_flutter/utils/preference_utils.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    Future.delayed(
      const Duration(seconds: 5),
      () {
        if (PreferenceUtils.getBoolValue("isShowOnBoarding")) {
          Get.to(() => OnBoardingScreen(), transition: Transition.fade);
        } else {
          if (PreferenceUtils.getStringValue("token") != "") {
            Get.to(() => const HomeScreen(), transition: Transition.fade);
          } else {
            Get.to(() => LoginScreen(), transition: Transition.fade);
          }
        }
      },
    );
    super.onInit();
  }
}
