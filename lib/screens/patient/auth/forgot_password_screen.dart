import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infyhms_flutter/component/common_button.dart';
import 'package:infyhms_flutter/component/common_text_field.dart';
import 'package:infyhms_flutter/constant/color_const.dart';
import 'package:infyhms_flutter/constant/text_style_const.dart';
import 'package:infyhms_flutter/controller/patient/auth_controller/forgot_password_controller.dart';
import 'package:infyhms_flutter/utils/image_utils.dart';
import 'package:infyhms_flutter/utils/string_utils.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({Key? key}) : super(key: key);
  final ForgotPasswordController forgotPasswordController = Get.put(ForgotPasswordController());

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: ColorConst.whiteColor,
          body: ListView(
            // shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              Form(
                key: forgotPasswordController.formKey,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      height: height / 3.2,
                      color: ColorConst.bgGreyColor,
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(ImageUtils.splashLogo),
                          ),
                        ),
                      ),
                    ),
                    // Container(
                    //   height: height / 3.2,
                    //   width: width,
                    //   color: ColorConst.bgGreyColor,
                    // ),
                    Container(
                      height: height / 1.6,
                      width: double.infinity,
                      padding: EdgeInsets.only(bottom: mediaQuery.viewInsets.bottom, ),
                      decoration: BoxDecoration(
                        color: ColorConst.whiteColor,
                        boxShadow: [
                          BoxShadow(
                            color: ColorConst.greyShadowColor,
                            blurRadius: 5,
                            spreadRadius: 3,
                            offset: const Offset(0, -5),
                          ),
                        ],
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(60),
                          topLeft: Radius.circular(60),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(top: height * 0.06, left: 20, right: 20),
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            children: [
                              Text(StringUtils.forgotPassword, style: TextStyleConst.boldTextStyle(ColorConst.blueColor, width * 0.06)),
                              SizedBox(height: height * 0.01),
                              Text(StringUtils.forgotScreenDetail,
                                  style: TextStyleConst.hintTextStyle(ColorConst.hintGreyColor), textAlign: TextAlign.center),
                              SizedBox(height: height * 0.05),
                              CommonTextField(
                                keyBoardType: TextInputType.emailAddress,
                                controller: forgotPasswordController.emailController,
                                hintText: StringUtils.signInEmail,
                                validator: (value) {
                                  if (forgotPasswordController.emailController.text.isEmpty) {
                                    return "Please enter an email";
                                  }
                                  if (!RegExp(r"[a-zA-Z0-9+_.-]+@[a-zA-Z.-]+\.[a-z]+").hasMatch(value!)) {
                                    return "Please enter valid email";
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: height * 0.07),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Obx(
                                      () => forgotPasswordController.isSendLink.value == true
                                          ? Center(
                                              child: CommonButton(
                                                textStyleConst: TextStyleConst.mediumTextStyle(ColorConst.whiteColor, width * 0.05),
                                                onTap: () {
                                                  if (forgotPasswordController.formKey.currentState!.validate()) {
                                                    forgotPasswordController.forgotPassword(context);
                                                  }
                                                },
                                                color: ColorConst.blueColor,
                                                text: StringUtils.sendLink,
                                                width: width / 2.3,
                                                height: 50,
                                              ),
                                            )
                                          : const Center(child: CircularProgressIndicator()),
                                    ),
                                  ),
                                  CommonButton(
                                    textStyleConst: TextStyleConst.mediumTextStyle(ColorConst.hintGreyColor, width * 0.05),
                                    onTap: () {
                                      Get.back();
                                      forgotPasswordController.emailController.clear();
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
