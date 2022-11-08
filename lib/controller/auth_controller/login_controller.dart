import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:infyhms_flutter/model/auth_model/login_model.dart';

class LogInController extends GetxController {
  LoginModel? loginModel;
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RxBool isCheck = false.obs;
  RxBool showPassword = false.obs;

  void hideAndShowPassword() {
    showPassword.value = !showPassword.value;
  }
}
