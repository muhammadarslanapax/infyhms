import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infyhms_flutter/component/common_button.dart';
import 'package:infyhms_flutter/component/common_text_field.dart';
import 'package:infyhms_flutter/constant/color_const.dart';
import 'package:infyhms_flutter/constant/text_style_const.dart';
import 'package:infyhms_flutter/controller/patient/auth_controller/login_controller.dart';
import 'package:infyhms_flutter/screens/patient/auth/forgot_password_screen.dart';
import 'package:infyhms_flutter/utils/image_utils.dart';
import 'package:infyhms_flutter/utils/string_utils.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final LogInController logInController = Get.put(LogInController());

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
          backgroundColor: ColorConst.bgGreyColor,
          body: WillPopScope(
            onWillPop: ()async => false,
            child: ListView(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
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
                    height: height / 1.53,
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
                      padding:  EdgeInsets.only(left: 20, right: 20, top: height * 0.06),
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            /// SignIn
                            //SizedBox(height: height * 0.06),
                            Text(StringUtils.signIn, style: TextStyleConst.boldTextStyle(Colors.black, width * 0.06)),
                            SizedBox(height: height * 0.03),

                            /// Email TextField
                            CommonTextField(
                              controller: logInController.emailController,
                              keyBoardType: TextInputType.emailAddress,
                              validator: (value) {
                                return null;
                              },
                              hintText: StringUtils.signInEmail,
                            ),
                            SizedBox(height: height * 0.02),

                            /// password TextField
                            Obx(() {
                              return CommonTextField(
                                obscureText: !logInController.showPassword.value,
                                suffixIcon: InkWell(
                                  onTap: () {
                                    logInController.hideAndShowPassword();
                                  },
                                  child: !logInController.showPassword.value
                                      ? const Icon(Icons.visibility_off_outlined, color: Colors.black)
                                      : const Icon(Icons.visibility, color: Colors.black),
                                ),
                                maxLine: 1,
                                controller: logInController.passwordController,
                                validator: (value) {
                                  return null;
                                },
                                hintText: StringUtils.signInPassword,
                              );
                            }),

                            /// Forgot password
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                child: Text(
                                  StringUtils.forgotPassword,
                                  style: TextStyleConst.forgotTextStyle(ColorConst.blueColor, 15),
                                ),
                                onPressed: () {
                                  logInController.emailController.clear();
                                  logInController.passwordController.clear();

                                  Get.to(() => ForgotPasswordScreen(), transition: Transition.rightToLeft);
                                },
                              ),
                            ),

                            SizedBox(height: height * 0.07),

                            /// Login button
                            CommonButton(
                              textStyleConst: TextStyleConst.mediumTextStyle(ColorConst.whiteColor, width * 0.05),
                              onTap: () {
                                logInController.loginPatient(context);
                              },
                              color: ColorConst.blueColor,
                              text: StringUtils.login,
                              width: width,
                              height: 50,
                            ),
                            SizedBox(height: height * 0.04),

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
