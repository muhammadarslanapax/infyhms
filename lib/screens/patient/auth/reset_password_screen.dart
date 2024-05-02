import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/src/state.dart';
import 'package:infyhms_flutter/component/common_button.dart';
import 'package:infyhms_flutter/component/common_text_field.dart';
import 'package:infyhms_flutter/constant/color_const.dart';
import 'package:infyhms_flutter/constant/text_style_const.dart';
import 'package:infyhms_flutter/controller/patient/auth_controller/send_token_controller.dart';
import 'package:infyhms_flutter/utils/image_utils.dart';
import 'package:infyhms_flutter/utils/string_utils.dart';

class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({super.key, required this.state});
  final GoRouterState state;
  final SendTokenController sendTokenController = Get.put(SendTokenController());

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
          backgroundColor: ColorConst.whiteColor,
          body: ListView(
            // shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              Column(
                children: [
                  /// top logo
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

                  /// bottom container
                  Container(
                    height: height / 1.54,
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
                            /// SignIn
                            Text(
                              StringUtils.resetPassword,
                              style: TextStyleConst.boldTextStyle(Colors.black, width * 0.06),
                            ),
                            SizedBox(height: height * 0.03),

                            /// Email TextField
                            CommonTextField(
                              controller: sendTokenController.newPassword,
                              keyBoardType: TextInputType.emailAddress,
                              validator: (value) {
                                return null;
                              },
                              hintText: StringUtils.enterNewPassword,
                            ),
                            SizedBox(height: height * 0.02),

                            /// password TextField
                            CommonTextField(
                              maxLine: 1,
                              controller: sendTokenController.confirmPassword,
                              validator: (value) {
                                return null;
                              },
                              hintText: StringUtils.enterNewPassword,
                            ),
                            SizedBox(height: height * 0.06),

                                  /// Login button
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      CommonButton(
                                        textStyleConst: TextStyleConst.mediumTextStyle(ColorConst.whiteColor, width * 0.05),
                                        onTap: () {
                                          String token = state.uri.toString().split('token=').last.split('&').first;
                                          String email = state.uri.toString().split('email=').last.split('&').first;
                                          sendTokenController.sendToken(context, email, token);
                                        } ,
                                        color: ColorConst.blueColor,
                                        text: StringUtils.save,
                                        width: width / 2.3,
                                        height: 50,
                                      ),
                                      CommonButton(
                                        textStyleConst: TextStyleConst.mediumTextStyle(ColorConst.hintGreyColor, width * 0.05),
                                        onTap: () {
                                          Get.back();
                                        },
                                        color: ColorConst.borderGreyColor,
                                        text: StringUtils.cancel,
                                        width: width / 2.3,
                                        height: 50,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: height * 0.04)
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
          ),
        ),

    );
  }
}
