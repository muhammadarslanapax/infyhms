import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infyhms_flutter/component/common_app_bar.dart';
import 'package:infyhms_flutter/component/common_button.dart';
import 'package:infyhms_flutter/constant/color_const.dart';
import 'package:infyhms_flutter/constant/text_style_const.dart';
import 'package:infyhms_flutter/controller/home_controller.dart';
import 'package:infyhms_flutter/screens/patient/account/my_account_screen.dart';
import 'package:infyhms_flutter/utils/image_utils.dart';
import 'package:infyhms_flutter/utils/list_utils.dart';
import 'package:infyhms_flutter/utils/preference_utils.dart';
import 'package:infyhms_flutter/utils/string_utils.dart';
import 'package:infyhms_flutter/utils/variable_utils.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: GetBuilder<HomeController>(
        init: HomeController(),
        builder: (controller) {
          return Scaffold(
            key: controller.scaffoldKey,
            appBar: CommonAppBar(
              title: controller.appBarTitle.value,
              leadOnTap: () {
                VariableUtils.firstName.value = PreferenceUtils.getStringValue("first_name");
                VariableUtils.lastName.value = PreferenceUtils.getStringValue("last_name");
                VariableUtils.email.value = PreferenceUtils.getStringValue("email");
                VariableUtils.phoneNo.value = PreferenceUtils.getStringValue("phone_number");
                VariableUtils.imageUrl.value = PreferenceUtils.getStringValue("image_url");
                VariableUtils.patientId.value = PreferenceUtils.getStringValue("patientId");
                controller.scaffoldKey.currentState?.openDrawer();
              },
              leadIcon: const Icon(Icons.menu, color: ColorConst.blackColor),
            ),
            drawer: Drawer(
              width: width / 1.2,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  SizedBox(height: height * 0.02),
                  ListTile(
                    title: Obx(
                      () => Text(
                        "${VariableUtils.firstName.value} ${VariableUtils.lastName.value}",
                        style: TextStyleConst.mediumTextStyle(
                          ColorConst.blackColor,
                          width * 0.045,
                        ),
                      ),
                    ),
                    subtitle: Obx(
                      () => Text(
                        VariableUtils.email.value,
                        style: TextStyleConst.mediumTextStyle(
                          ColorConst.hintGreyColor,
                          width * 0.035,
                        ),
                      ),
                    ),
                    leading: Obx(
                      () => Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(VariableUtils.imageUrl.replaceAll(" ", "")),
                          ),
                        ),
                      ),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.arrow_forward_ios_rounded, size: 15),
                      onPressed: () {
                        Get.back();
                        Get.to(() => MyAccountScreen());
                      },
                    ),
                  ),
                  SizedBox(height: height * 0.01),
                  Container(height: 1.5, width: double.infinity, color: ColorConst.borderGreyColor),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: List.generate(
                            PreferenceUtils.getBoolValue("isDoctor") ? ListUtils.doctorDrawerList.length : ListUtils.drawerList.length, (index) {
                          return ListTile(
                            onTap: () {
                              PreferenceUtils.getBoolValue("isDoctor") ? controller.changeDoctorWidget(index) : controller.changeWidget(index);
                            },
                            title: Text(
                              PreferenceUtils.getBoolValue("isDoctor")
                                  ? ListUtils.doctorDrawerList[index]["title"]
                                  : ListUtils.drawerList[index]["title"],
                              style: TextStyleConst.mediumTextStyle(
                                ColorConst.blackColor,
                                width * 0.04,
                              ),
                            ),
                            leading: SizedBox(
                              height: 25,
                              width: 25,
                              child: ImageIcon(
                                AssetImage(PreferenceUtils.getBoolValue("isDoctor")
                                    ? ListUtils.doctorDrawerList[index]["icon"]
                                    : ListUtils.drawerList[index]["icon"]),
                                color: index == controller.currentDrawerIndex.value ? ColorConst.blueColor : ColorConst.hintGreyColor,
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                  Container(height: 1.5, width: double.infinity, color: ColorConst.borderGreyColor),
                  SizedBox(height: height * 0.002),
                  Container(
                    margin: const EdgeInsets.only(right: 15),
                    child: ListTile(
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
                                              controller.logOut(context);
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
                      title: const Text(StringUtils.logOut),
                      leading: const SizedBox(
                        height: 25,
                        width: 25,
                        child: ImageIcon(
                          AssetImage(ImageUtils.logOutIcon),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: height * 0.01),
                ],
              ),
            ),
            body: controller.currentWidget,
          );
        },
      ),
    );
  }
}
