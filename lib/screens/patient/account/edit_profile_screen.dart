import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infyhms_flutter/component/common_app_bar.dart';
import 'package:infyhms_flutter/component/common_button.dart';
import 'package:infyhms_flutter/component/common_required_text.dart';
import 'package:infyhms_flutter/component/common_text_field.dart';
import 'package:infyhms_flutter/constant/color_const.dart';
import 'package:infyhms_flutter/constant/text_style_const.dart';
import 'package:infyhms_flutter/controller/patient/my_account_controller/edit_profile_controller.dart';
import 'package:infyhms_flutter/utils/string_utils.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
        child: GetBuilder<EditProfileController>(
      init: EditProfileController(),
      builder: (editProfileController) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Scaffold(
            backgroundColor: ColorConst.whiteColor,
            appBar: CommonAppBar(
              title: StringUtils.editProfile,
              leadOnTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
                if (MediaQuery.of(context).viewInsets.bottom == 0.0) {
                  Navigator.pop(context);
                }
                editProfileController.showFile = false;
                if (editProfileController.file != null) {
                  editProfileController.file = null;
                }
                // editProfileController.update();
              },
              leadIcon: const Icon(
                Icons.arrow_back_rounded,
                color: ColorConst.blackColor,
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: height * 0.04),
                    Center(
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: ColorConst.borderGreyColor,
                              image: editProfileController.showFile == true
                                  ? DecorationImage(
                                      fit: BoxFit.cover,
                                      image: FileImage(File(editProfileController.file!.path)),
                                    )
                                  : DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(editProfileController.imageUrl!.replaceAll(" ", "")),
                                    ),
                            ),
                          ),
                          Positioned(
                            bottom: -5,
                            right: -8,
                            child: Container(
                              height: 45,
                              width: 45,
                              decoration: const BoxDecoration(
                                color: ColorConst.whiteColor,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: GestureDetector(
                                  onTap: () {
                                    editProfileController.pickImage(context);
                                  },
                                  child: Container(
                                    height: 35,
                                    width: 35,
                                    decoration: const BoxDecoration(
                                      color: ColorConst.blueColor,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.camera_alt,
                                      color: ColorConst.whiteColor,
                                      size: 15,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: height * 0.04),
                    CommonRequiredText(
                      width: width,
                      text: StringUtils.firstName,
                    ),
                    SizedBox(height: height * 0.01),
                    CommonTextField(
                      validator: (value) {
                        return null;
                      },
                      controller: editProfileController.firstNameController,
                    ),
                    SizedBox(height: height * 0.02),
                    CommonRequiredText(
                      width: width,
                      text: StringUtils.lastName,
                    ),
                    SizedBox(height: height * 0.01),
                    CommonTextField(
                      validator: (value) {
                        return null;
                      },
                      controller: editProfileController.lastNameController,
                    ),
                    SizedBox(height: height * 0.02),
                    CommonRequiredText(
                      width: width,
                      text: StringUtils.email,
                    ),
                    SizedBox(height: height * 0.01),
                    CommonTextField(
                      validator: (value) {
                        return null;
                      },
                      controller: editProfileController.emailController,
                    ),
                    SizedBox(height: height * 0.02),
                    CommonRequiredText(
                      width: width,
                      text: StringUtils.phone,
                    ),
                    SizedBox(height: height * 0.01),
                    CommonTextField(
                      validator: (value) {
                        return null;
                      },
                      controller: editProfileController.phoneController,
                    ),
                    SizedBox(height: height * 0.05),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CommonButton(
                          textStyleConst: TextStyleConst.mediumTextStyle(ColorConst.whiteColor, width * 0.05),
                          onTap: () {
                            editProfileController.updateProfile();
                          },
                          color: ColorConst.blueColor,
                          text: StringUtils.save,
                          width: width / 2.3,
                          height: 50,
                        ),
                        CommonButton(
                          textStyleConst: TextStyleConst.mediumTextStyle(ColorConst.hintGreyColor, width * 0.05),
                          onTap: () {
                            FocusScope.of(context).requestFocus(FocusNode());
                            if (MediaQuery.of(context).viewInsets.bottom == 0.0) {
                              Navigator.pop(context);
                            }
                            editProfileController.showFile = false;
                            if (editProfileController.file != null) {
                              editProfileController.file = null;
                            }
                          },
                          color: ColorConst.borderGreyColor,
                          text: StringUtils.cancel,
                          width: width / 2.3,
                          height: 50,
                        ),
                      ],
                    ),
                    SizedBox(height: height * 0.03),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    ));
  }
}
