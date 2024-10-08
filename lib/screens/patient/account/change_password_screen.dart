import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infyhms_flutter/component/common_app_bar.dart';
import 'package:infyhms_flutter/component/common_button.dart';
import 'package:infyhms_flutter/component/common_required_text.dart';
import 'package:infyhms_flutter/component/common_text_field.dart';
import 'package:infyhms_flutter/constant/color_const.dart';
import 'package:infyhms_flutter/constant/text_style_const.dart';
import 'package:infyhms_flutter/controller/patient/auth_controller/change_password_controller.dart';
import 'package:infyhms_flutter/utils/string_utils.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({Key? key}) : super(key: key);
  final ChangePasswordController changePasswordController = Get.put(ChangePasswordController());

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Scaffold(
          backgroundColor: ColorConst.whiteColor,
          appBar: CommonAppBar(
            title: StringUtils.changePassword,
            leadOnTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
              if (MediaQuery.of(context).viewInsets.bottom == 0.0) {
                Navigator.pop(context);
              }
              changePasswordController.clearController();
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
                  SizedBox(height: height * 0.02),
                  CommonRequiredText(
                    width: width,
                    text: StringUtils.currentPassword,
                  ),
                  SizedBox(height: height * 0.01),
                  CommonTextField(
                    hintText: "Enter Current Password",
                    validator: (value) {
                      return null;
                    },
                    controller: changePasswordController.currentPasswordController,
                  ),
                  SizedBox(height: height * 0.02),
                  CommonRequiredText(
                    width: width,
                    text: StringUtils.newPassword,
                  ),
                  SizedBox(height: height * 0.01),
                  CommonTextField(
                    hintText: "Enter New Password",
                    validator: (value) {
                      return null;
                    },
                    controller: changePasswordController.newPasswordController,
                  ),
                  SizedBox(height: height * 0.02),
                  CommonRequiredText(
                    width: width,
                    text: StringUtils.confirmPassword,
                  ),
                  SizedBox(height: height * 0.01),
                  CommonTextField(
                    hintText: "Re-enter New Password",
                    validator: (value) {
                      return null;
                    },
                    controller: changePasswordController.confirmPasswordController,
                  ),
                  SizedBox(height: height * 0.05),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CommonButton(
                        textStyleConst: TextStyleConst.mediumTextStyle(ColorConst.whiteColor, width * 0.05),
                        onTap: () {
                          print('-=-=-=-=-=-=-=-=-=-=');
                          changePasswordController.changePassword(context);
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
                          changePasswordController.clearController();
                        },
                        color: ColorConst.borderGreyColor,
                        text: StringUtils.cancel,
                        width: width / 2.3,
                        height: 50,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
