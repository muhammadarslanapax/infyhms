import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LogInController extends GetxController {
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  RxBool isCheck = false.obs;
}
