import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infyhms_flutter/component/common_button.dart';
import 'package:infyhms_flutter/component/common_text_field.dart';
import 'package:infyhms_flutter/constant/color_const.dart';
import 'package:infyhms_flutter/constant/text_style_const.dart';
import 'package:infyhms_flutter/controller/forgot_controller.dart';
import 'package:infyhms_flutter/utils/image_utils.dart';
import 'package:infyhms_flutter/utils/string_utils.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({Key? key}) : super(key: key);
  ForgotPasswordController forgotPasswordController = Get.put(ForgotPasswordController());
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConst.whiteColor,
        body: ListView(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
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
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Stack(
                      children: [
                        Container(
                          height: height / 3.2,
                          width: width,
                          color: ColorConst.bgGreyColor,
                        ),
                        Container(
                          height: height / 1.6,
                          width: double.infinity,
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
                            child: Column(
                              children: [
                                Text(StringUtils.forgotPassword, style: TextStyleConst.boldTextStyle(ColorConst.blueColor)),
                                SizedBox(height: height * 0.01),
                                Text(StringUtils.forgotScreenDetail, style: TextStyleConst.hintTextStyle(ColorConst.hintGreyColor)),
                                SizedBox(height: height * 0.05),
                                CommonTextField(
                                  controller: forgotPasswordController.forgotController,
                                  hintText: StringUtils.signInEmail,
                                  validator: (value) {
                                    if (forgotPasswordController.forgotController.text.isEmpty) {
                                      return "Please enter an email";
                                    }
                                    if (!RegExp(r"[a-zA-Z0-9+_.-]+@[a-zA-Z.-]+\.[a-z]+").hasMatch(value!)) {
                                      return "Please enter valid email";
                                    }
                                  },
                                ),
                                SizedBox(height: height * 0.07),
                                Row(
                                  children: [
                                    CommonButton(
                                      textColor: ColorConst.whiteColor,
                                      onTap: () {
                                        if (forgotPasswordController.formKey.currentState!.validate()) {
                                          print("object");
                                        }
                                      },
                                      color: ColorConst.blueColor,
                                      text: StringUtils.sendLink,
                                      width: width / 2.3,
                                      height: 50,
                                    ),
                                    const Spacer(),
                                    CommonButton(
                                      textColor: Colors.grey,
                                      onTap: () {
                                        Get.back();
                                        forgotPasswordController.forgotController.clear();
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
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
