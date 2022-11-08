import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infyhms_flutter/component/common_button.dart';
import 'package:infyhms_flutter/component/common_error.dart';
import 'package:infyhms_flutter/component/common_snackbar.dart';
import 'package:infyhms_flutter/component/common_text_field.dart';
import 'package:infyhms_flutter/constant/color_const.dart';
import 'package:infyhms_flutter/constant/text_style_const.dart';
import 'package:infyhms_flutter/controller/auth_controller/login_controller.dart';
import 'package:infyhms_flutter/screens/auth/forgot_password_screen.dart';
import 'package:infyhms_flutter/screens/home_screen.dart';
import 'package:infyhms_flutter/utils/image_utils.dart';
import 'package:infyhms_flutter/utils/preference_utils.dart';
import 'package:infyhms_flutter/utils/string_utils.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final LogInController logInController = Get.put(LogInController());

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
          body: ListView(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            children: [
              Form(
                key: logInController.formKey,
                child: Column(
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
                            height: height / 1.54,
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
                              child: SingleChildScrollView(
                                physics: const BouncingScrollPhysics(),
                                child: Column(
                                  children: [
                                    /// SignIn
                                    Text(StringUtils.signIn, style: TextStyleConst.boldTextStyle(Colors.black, width * 0.06)),
                                    SizedBox(height: height * 0.03),

                                    /// Email TextField
                                    CommonTextField(
                                      controller: logInController.emailController,
                                      keyBoardType: TextInputType.emailAddress,
                                      validator: (value) {
                                        // if (logInController.emailController.text.trim().isEmpty) {
                                        //   return "Please enter an email";
                                        // }
                                        // if (!RegExp(r"[a-zA-Z0-9+_.-]+@[a-zA-Z.-]+\.[a-z]+").hasMatch(value!)) {
                                        //   return "Please enter valid email";
                                        // }
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
                                          //   if (logInController.passwordController.text.trim().isEmpty) {
                                          //     return "Please enter password";
                                          //   }
                                          //   return null;
                                          // },
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
                                    SizedBox(height: height * 0.01),

                                    /// Remember me
                                    Row(
                                      children: [
                                        Obx(
                                          () => InkWell(
                                            onTap: () {
                                              if (logInController.isCheck.value == false) {
                                                logInController.isCheck.value = true;
                                              } else {
                                                logInController.isCheck.value = false;
                                              }
                                            },
                                            child: logInController.isCheck.value == true
                                                ? Container(
                                                    height: 25,
                                                    width: 25,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(5),
                                                      color: ColorConst.blueColor,
                                                    ),
                                                    child: const Icon(
                                                      Icons.check,
                                                      color: ColorConst.whiteColor,
                                                      size: 18,
                                                    ),
                                                  )
                                                : Container(
                                                    height: 25,
                                                    width: 25,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(5),
                                                      border: Border.all(
                                                        width: 1.5,
                                                        color: ColorConst.borderGreyColor,
                                                      ),
                                                    ),
                                                  ),
                                          ),
                                        ),
                                        SizedBox(width: width * 0.03),
                                        Text(
                                          StringUtils.rememberPassword,
                                          style: TextStyleConst.mediumTextStyle(ColorConst.blackColor, width * 0.05),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: height * 0.06),

                                    /// Login button
                                    CommonButton(
                                      textStyleConst: TextStyleConst.mediumTextStyle(ColorConst.whiteColor, width * 0.05),
                                      onTap: () {
                                        if (logInController.emailController.text.isEmpty) {
                                          DisplaySnackBar.displaySnackBar(context, "Please enter email");
                                        } else if (logInController.emailController.text.isEmpty) {
                                          DisplaySnackBar.displaySnackBar(context, "Please enter password");
                                        } else {
                                          StringUtils.client.loginPatient({
                                            "email": logInController.emailController.text,
                                            "password": logInController.passwordController.text,
                                          })
                                            ..then((value) {
                                              logInController.loginModel = value;
                                              if (logInController.loginModel!.success == true) {
                                                PreferenceUtils.setStringValue("token", logInController.loginModel!.data!.token!);
                                                Get.offAll(() => const HomeScreen());
                                              } else {
                                                CommonError().showMaterialBanner(context, "${value.message}");
                                              }
                                            })
                                            ..onError((DioError error, stackTrace) {
                                              DisplaySnackBar.displaySnackBar(context, "${error.response!.data["message"]}");
                                              return logInController.loginModel!;
                                            });
                                        }
                                      },
                                      color: ColorConst.blueColor,
                                      text: StringUtils.login,
                                      width: width,
                                      height: 50,
                                    ),
                                    SizedBox(height: height * 0.04)
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
            ],
          ),
        ),
      ),
    );
  }
}
