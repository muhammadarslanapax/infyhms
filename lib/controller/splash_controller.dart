import 'package:get/get.dart';
import 'package:infyhms_flutter/screens/onboarding_screen.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    Future.delayed(
      const Duration(seconds: 5),
      () => Get.offAll(() => OnBoardingScreen(), transition: Transition.fade),
    );
    // TODO: implement onInit
    super.onInit();
  }
}
