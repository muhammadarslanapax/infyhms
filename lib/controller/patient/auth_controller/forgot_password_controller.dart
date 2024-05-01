import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infyhms_flutter/component/common_snackbar.dart';
import 'package:infyhms_flutter/model/patient/auth_model/forgot_password_model.dart';
import 'package:infyhms_flutter/utils/string_utils.dart';

class ForgotPasswordController extends GetxController {
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();

  ForgotPasswordModel? forgotPasswordModel;
  RxBool isSendLink = true.obs;

  forgotPassword(BuildContext context) {
    isSendLink.value = false;
    StringUtils.client.forgotPassword({"email": emailController.text, "url_domain": Platform.isAndroid?'http:':'myHMSApp:'})
      ..then((value) {
        forgotPasswordModel = value;
        if (forgotPasswordModel!.success == true) {
          isSendLink.value = true;
          StringUtils.sendEmail = emailController.text;
          emailController.clear();
          DisplaySnackBar.displaySnackBar(forgotPasswordModel!.message!);
        }
      })
      ..onError((DioError error, stackTrace) {
        isSendLink.value = true;
        DisplaySnackBar.displaySnackBar("${error.response?.data["message"] ?? error.message}");
        return ForgotPasswordModel();
      });
  }
}
