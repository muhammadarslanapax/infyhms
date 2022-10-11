import 'package:get/get.dart';
import 'package:infyhms_flutter/screens/login_screen.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    Future.delayed(
      const Duration(seconds: 3),
      () => Get.to(const LoginScreen()),
    );
    // TODO: implement onInit
    super.onInit();
  }
}
