import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infyhms_flutter/utils/preference_utils.dart';

class EditProfileController extends GetxController {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  String? imageUrl;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    emailController.text = PreferenceUtils.getStringValue("email");
    firstNameController.text = PreferenceUtils.getStringValue("first_name");
    lastNameController.text = PreferenceUtils.getStringValue("last_name");
    phoneController.text = PreferenceUtils.getStringValue("phone_number");
    imageUrl = PreferenceUtils.getStringValue("image_url");
  }
}
