import 'package:get/get.dart';
import 'package:infyhms_flutter/model/auth_model/logout_model.dart';
import 'package:infyhms_flutter/screens/auth/login_screen.dart';
import 'package:infyhms_flutter/utils/preference_utils.dart';
import 'package:infyhms_flutter/utils/string_utils.dart';

class MyAccountController extends GetxController {
  LogoutModel? logoutModel;
  void logout() {
    StringUtils.client.logout("Bearer ${PreferenceUtils.getStringValue("token")}").then((value) {
      logoutModel = value;
      if (logoutModel!.success == true) {
        PreferenceUtils.setStringValue("token", "");
        Get.offAll(() => LoginScreen());
      }
    });
  }
}
