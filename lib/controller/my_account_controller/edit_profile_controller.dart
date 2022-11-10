import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:infyhms_flutter/model/account_model/edit_profile_model.dart';
import 'package:infyhms_flutter/utils/preference_utils.dart';
import 'package:infyhms_flutter/utils/string_utils.dart';
import 'package:infyhms_flutter/utils/variable_utils.dart';

class EditProfileController extends GetxController {
  EditProfileModel? editProfileModel;
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  XFile? file;
  bool showFile = false;
  ImagePicker imagePicker = ImagePicker();

  String? imageUrl;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    emailController.text = VariableUtils.email.value;
    firstNameController.text = VariableUtils.firstName.value;
    lastNameController.text = VariableUtils.lastName.value;
    phoneController.text = VariableUtils.phoneNo.value;
    imageUrl = VariableUtils.imageUrl.value;
  }

  void pickImage(BuildContext context) async {
    file = await imagePicker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      showFile = true;
      update();
    }
  }

  void updateProfile() {
    StringUtils.client
        .editProfile("Bearer ${PreferenceUtils.getStringValue("token")}", firstNameController.text, lastNameController.text, emailController.text,
            phoneController.text, file == null ? null : File(file!.path))
        .then((value) {
      print(value.data!.profile_image);

      editProfileModel = value;

      if (editProfileModel!.success == true) {
        VariableUtils.firstName.value = editProfileModel!.data!.first_name!;
        VariableUtils.lastName.value = editProfileModel!.data!.last_name!;
        VariableUtils.imageUrl.value = editProfileModel!.data!.profile_image!;
        VariableUtils.phoneNo.value = editProfileModel!.data!.phone!;
        VariableUtils.email.value = editProfileModel!.data!.email!;

        PreferenceUtils.setStringValue("first_name", editProfileModel!.data!.first_name!);
        PreferenceUtils.setStringValue("last_name", editProfileModel!.data!.last_name!);
        PreferenceUtils.setStringValue("email", editProfileModel!.data!.email!);
        PreferenceUtils.setStringValue("phone_number", editProfileModel!.data!.phone!);
        PreferenceUtils.setStringValue("image_url", editProfileModel!.data!.profile_image!);

        Get.back();
      }
    });
  }
}
