import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infyhms_flutter/component/common_account_button.dart';
import 'package:infyhms_flutter/component/common_app_bar.dart';
import 'package:infyhms_flutter/component/common_button.dart';
import 'package:infyhms_flutter/constant/color_const.dart';
import 'package:infyhms_flutter/constant/text_style_const.dart';
import 'package:infyhms_flutter/controller/patient/my_account_controller/my_account_controller.dart';
import 'package:infyhms_flutter/screens/patient/account/change_password_screen.dart';
import 'package:infyhms_flutter/screens/patient/account/edit_profile_screen.dart';
import 'package:infyhms_flutter/utils/string_utils.dart';
import 'package:infyhms_flutter/utils/variable_utils.dart';

class MyAccountScreen extends StatelessWidget {
  MyAccountScreen({Key? key}) : super(key: key);
  final MyAccountController myAccountController = Get.put(MyAccountController());

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConst.whiteColor,
        appBar: CommonAppBar(
          title: StringUtils.myAccount,
          leadOnTap: () {
            Get.back();
          },
          leadIcon: const Icon(
            Icons.arrow_back_rounded,
            color: ColorConst.blackColor,
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: height * 0.05),
            Center(
              child: Obx(
                () => Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: ColorConst.borderGreyColor,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(VariableUtils.imageUrl.value),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: height * 0.03),
            Obx(
              () => Text(
                "${VariableUtils.firstName.value} ${VariableUtils.lastName.value}",
                style: TextStyleConst.mediumTextStyle(
                  ColorConst.blackColor,
                  width * 0.045,
                ),
              ),
            ),
            SizedBox(height: height * 0.005),
            Obx(
              () => Text(
                VariableUtils.email.value,
                style: TextStyleConst.mediumTextStyle(
                  ColorConst.hintGreyColor,
                  width * 0.04,
                ),
              ),
            ),
            SizedBox(height: height * 0.03),
            CommonAccountButton(
              width: width,
              onTap: () async {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EditProfileScreen(),
                    ));

                // Get.to(() => EditProfileScreen(), transition: Transition.rightToLeft);
              },
              text: StringUtils.editProfile,
            ),
            SizedBox(height: height * 0.02),
            CommonAccountButton(
              width: width,
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChangePasswordScreen(),
                    ));
                // Get.to(() => ChangePasswordScreen(), transition: Transition.rightToLeft);
              },
              text: StringUtils.changePassword,
            ),
            const Spacer(),
            CommonButton(
              width: width / 1.1,
              height: 50,
              text: StringUtils.logOut,
              color: ColorConst.blueColor,
              onTap: () {
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) {
                    return Center(
                      child: Material(
                        borderRadius: BorderRadius.circular(15),
                        child: Container(
                          height: height / 4,
                          width: width / 1.12,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(height: height * 0.03),
                              Text(
                                "Log Out",
                                style: TextStyleConst.boldTextStyle(
                                  ColorConst.blackColor,
                                  width * 0.05,
                                ),
                              ),
                              SizedBox(height: height * 0.01),
                              Text(
                                "Are you sure to logout?",
                                textAlign: TextAlign.center,
                                style: TextStyleConst.mediumTextStyle(
                                  ColorConst.hintGreyColor,
                                  width * 0.042,
                                ),
                              ),
                              SizedBox(height: height * 0.03),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  CommonButton(
                                    textStyleConst: TextStyleConst.mediumTextStyle(
                                      ColorConst.whiteColor,
                                      width * 0.05,
                                    ),
                                    onTap: () {
                                      myAccountController.logout(context);
                                    },
                                    color: ColorConst.blueColor,
                                    text: StringUtils.logOut,
                                    width: width / 2.5,
                                    height: 50,
                                  ),
                                  CommonButton(
                                    textStyleConst: TextStyleConst.mediumTextStyle(
                                      ColorConst.hintGreyColor,
                                      width * 0.05,
                                    ),
                                    onTap: () {
                                      Get.back();
                                    },
                                    color: ColorConst.borderGreyColor,
                                    text: StringUtils.cancel,
                                    width: width / 2.5,
                                    height: 50,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
              textStyleConst: TextStyleConst.mediumTextStyle(Colors.white, width * 0.045),
            ),
            SizedBox(height: height * 0.02),
          ],
        ),
      ),
    );
  }
}
