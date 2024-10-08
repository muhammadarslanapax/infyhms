import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:infyhms_flutter/component/common_loader.dart';
import 'package:infyhms_flutter/component/common_socket_exception.dart';
import 'package:infyhms_flutter/model/patient/auth_model/logout_model.dart';
import 'package:infyhms_flutter/screens/patient/auth/login_screen.dart';
import 'package:infyhms_flutter/utils/preference_utils.dart';
import 'package:infyhms_flutter/utils/string_utils.dart';

class MyAccountController extends GetxController {
  LogoutModel? logoutModel;
  void logout() {
    Get.back();
    CommonLoader.showLoader();
    StringUtils.client.logout(PreferenceUtils.getStringValue("token")).then((value) {
      logoutModel = value;
      if (logoutModel!.success == true) {
        PreferenceUtils.setStringValue("token", "");
        Get.to(() => LoginScreen());
      }
    }).onError((DioError error, stackTrace) {
      CheckSocketException.checkSocketException(error);
    });
  }
}
