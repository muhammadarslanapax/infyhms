import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infyhms_flutter/component/common_loader.dart';
import 'package:infyhms_flutter/component/common_snackbar.dart';
import 'package:infyhms_flutter/component/common_socket_exception.dart';
import 'package:infyhms_flutter/model/patient/auth_model/sigup_model.dart';
import 'package:infyhms_flutter/utils/string_utils.dart';

class SignUpController extends GetxController {
  TextEditingController firstController = TextEditingController();
  TextEditingController lastController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  RxInt currentIndex = 0.obs;

  RxBool showPassword = false.obs;
  RxBool showConfirmPassword = false.obs;

  SignUpModel? signUpModel;

  void registerUser() {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(pattern);
    if (firstController.text.trim().isEmpty) {
      DisplaySnackBar.displaySnackBar("Please enter first name");
    } else if (lastController.text.trim().isEmpty) {
      DisplaySnackBar.displaySnackBar("Please enter last name");
    } else if (emailController.text.trim().isEmpty) {
      DisplaySnackBar.displaySnackBar("Please enter email address");
    } else if (!regExp.hasMatch(emailController.text.trim())) {
      DisplaySnackBar.displaySnackBar("Please enter valid email");
    } else if (passwordController.text.trim().isEmpty) {
      DisplaySnackBar.displaySnackBar("Please enter password");
    } else if (passwordController.text.trim().length < 6) {
      DisplaySnackBar.displaySnackBar("Please enter password more then 6 characters");
    } else if (confirmPasswordController.text.trim().isEmpty) {
      DisplaySnackBar.displaySnackBar("Please enter confirm password");
    } else if (passwordController.text.trim() != confirmPasswordController.text.trim()) {
      DisplaySnackBar.displaySnackBar("Password and Confirm password does not match");
    } else {
      CommonLoader.showLoader();
      StringUtils.client.patientRegistration(
        firstController.text,
        lastController.text,
        emailController.text,
        currentIndex.value == 0 ? "male" : "female",
        passwordController.text,
        confirmPasswordController.text,
      )
        ..then((value) {
          signUpModel = value;
          Get.back();
          Get.back();
          DisplaySnackBar.displaySnackBar("Patient registered successfully");
        })
        ..onError((DioError error, stackTrace) {
          CheckSocketException.checkSocketException(error);
          return SignUpModel();
        });
    }
  }
}
