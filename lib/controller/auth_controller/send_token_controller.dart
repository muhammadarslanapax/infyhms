import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:infyhms_flutter/component/common_snackbar.dart';
import 'package:infyhms_flutter/component/common_socket_exception.dart';
import 'package:infyhms_flutter/model/patient/auth_model/send_token_model.dart';
import 'package:infyhms_flutter/screens/auth/login_screen.dart';
import 'package:infyhms_flutter/utils/string_utils.dart';

class SendTokenController extends GetxController {
  SendTokenModel? sendTokenModel;
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  void sendToken(BuildContext context) {
    if (newPassword.text.isEmpty) {
      DisplaySnackBar.displaySnackBar("Please enter password");
    } else if (newPassword.text.length < 6) {
      DisplaySnackBar.displaySnackBar("Please enter minimum 6 character");
    } else if (confirmPassword.text.isEmpty) {
      DisplaySnackBar.displaySnackBar("Please enter confirm password");
    } else if (newPassword.text != confirmPassword.text) {
      DisplaySnackBar.displaySnackBar("Password doesn't match");
    } else {
      StringUtils.client.sendToken(StringUtils.token!, newPassword.text, confirmPassword.text, StringUtils.sendEmail)
        ..then((value) {
          sendTokenModel = value;
          if (sendTokenModel!.success == true) {
            Get.offAll(() => LoginScreen());
            DisplaySnackBar.displaySnackBar(sendTokenModel!.message!);
          }
        })
        ..onError((DioError error, stackTrace) {
          CheckSocketException.checkSocketException(error);
          return SendTokenModel();
        });
    }
  }
}
