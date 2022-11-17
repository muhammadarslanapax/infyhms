import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infyhms_flutter/component/common_button.dart';
import 'package:infyhms_flutter/component/common_error.dart';
import 'package:infyhms_flutter/component/common_loader.dart';
import 'package:infyhms_flutter/component/common_snackbar.dart';
import 'package:infyhms_flutter/component/common_socket_exception.dart';
import 'package:infyhms_flutter/component/common_text_field.dart';
import 'package:infyhms_flutter/constant/color_const.dart';
import 'package:infyhms_flutter/constant/text_style_const.dart';
import 'package:infyhms_flutter/controller/auth_controller/login_controller.dart';
import 'package:infyhms_flutter/model/auth_model/login_model.dart';
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
          backgroundColor: ColorConst.bgGreyColor,
          body: ListView(
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
                                      if (logInController.emailController.text.isEmpty) {
                                        DisplaySnackBar.displaySnackBar("Please enter email");
                                      } else if (logInController.emailController.text.isEmpty) {
                                        DisplaySnackBar.displaySnackBar("Please enter password");
                                      } else {
                                        CommonLoader.showLoader(context);
                                        StringUtils.client.loginPatient({
                                          "email": logInController.emailController.text,
                                          "password": logInController.passwordController.text,
                                        })
                                          ..then((value) {
                                            logInController.loginModel = value;
                                            if (logInController.loginModel!.success == true) {
                                              PreferenceUtils.setStringValue("token", "Bearer ${logInController.loginModel!.data!.token!}");
                                              PreferenceUtils.setStringValue("first_name", logInController.loginModel!.data!.user!.first_name!);
                                              PreferenceUtils.setStringValue("last_name", logInController.loginModel!.data!.user!.last_name!);
                                              PreferenceUtils.setStringValue("email", logInController.loginModel!.data!.user!.email!);
                                              PreferenceUtils.setStringValue("phone_number", logInController.loginModel!.data!.user!.phone_number!);
                                              PreferenceUtils.setStringValue("image_url", logInController.loginModel!.data!.user!.image_url!);
                                              PreferenceUtils.setStringValue("password", logInController.passwordController.text);
                                              PreferenceUtils.setStringValue("patientId", "${logInController.loginModel!.data!.user!.id}");
                                              Get.offAll(() => const HomeScreen());
                                            } else {
                                              CommonError().showMaterialBanner(context, "${value.message}");
                                            }
                                          })
                                          ..onError((DioError error, stackTrace) {
                                            Navigator.pop(context);
                                            // DisplaySnackBar.displaySnackBar(context, "${error.response!.data["message"]}");
                                            CheckSocketException.checkSocketException(error);
                                            return LoginModel();
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
            ],
          ),
        ),
      ),
    );
  }
}
