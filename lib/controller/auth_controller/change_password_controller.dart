import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infyhms_flutter/component/common_snackbar.dart';
import 'package:infyhms_flutter/model/auth_model/reset_password_model.dart';
import 'package:infyhms_flutter/utils/preference_utils.dart';
import 'package:infyhms_flutter/utils/string_utils.dart';
import 'package:infyhms_flutter/utils/variable_utils.dart';

class ChangePasswordController extends GetxController {
  final TextEditingController currentPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  ResetPasswordModel? resetPasswordModel;

  void changePassword(BuildContext context) {
    if (currentPasswordController.text.isEmpty) {
      DisplaySnackBar.displaySnackBar(context, "Please enter current password");
    } else if (currentPasswordController.text != PreferenceUtils.getStringValue("password")) {
      DisplaySnackBar.displaySnackBar(context, "Please enter correct current password");
    } else if (newPasswordController.text.isEmpty) {
      DisplaySnackBar.displaySnackBar(context, "Please enter new password");
    } else if (newPasswordController.text.length < 6) {
      DisplaySnackBar.displaySnackBar(context, "Please enter minimum 6 character password");
    } else if (confirmPasswordController.text.isEmpty) {
      DisplaySnackBar.displaySnackBar(context, "Please enter confirm password");
    } else if (newPasswordController.text != confirmPasswordController.text) {
      DisplaySnackBar.displaySnackBar(context, "Password doesn't match");
    } else {
      StringUtils.client.resetPassword("Bearer ${PreferenceUtils.getStringValue("token")}", {
        "email": VariableUtils.email.value,
        "old_password": currentPasswordController.text,
        "password": newPasswordController.text,
        "password_confirmation": confirmPasswordController.text,
      }).then((value) {
        resetPasswordModel = value;
        if (resetPasswordModel!.success == true) {
          DisplaySnackBar.displaySnackBar(context, resetPasswordModel!.message!);

          Get.back();
          clearController();
        }
      });
    }
  }

  void clearController() {
    currentPasswordController.clear();
    newPasswordController.clear();
    confirmPasswordController.clear();
  }
}
