import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infyhms_flutter/constant/color_const.dart';
import 'package:infyhms_flutter/constant/text_style_const.dart';
import 'package:infyhms_flutter/controller/appointment_controller.dart';
import 'package:infyhms_flutter/utils/image_utils.dart';
import 'package:infyhms_flutter/utils/list_utils.dart';
import 'package:infyhms_flutter/utils/string_utils.dart';

class AppointmentScreen extends StatelessWidget {
  AppointmentScreen({Key? key}) : super(key: key);
  AppointmentController appointmentController = Get.put(AppointmentController());

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        key: appointmentController.scaffoldKey,
        drawer: Drawer(
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
                title: Text(
                  "Harsh rathod",
                  style: TextStyleConst.mediumTextStyle(
                    ColorConst.blackColor,
                    width * 0.045,
                  ),
                ),
                subtitle: Text(
                  "harsh@gmail.com",
                  style: TextStyleConst.mediumTextStyle(
                    ColorConst.hintGreyColor,
                    width * 0.04,
                  ),
                ),
                leading: Container(
                  height: 60,
                  width: 60,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQQ-YIPLhIBLVQKh_S4BNo18b03Ct5P_iYFeBBjDCYx&s"),
                    ),
                  ),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.arrow_forward_ios_rounded, size: 15),
                  onPressed: () {},
                ),
              ),
              SizedBox(height: height * 0.01),
              Container(height: 1.5, width: double.infinity, color: ColorConst.borderGreyColor),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: List.generate(11, (index) {
                      return Obx(() => ListTile(
                            onTap: () {
                              // Get.back();
                              switch (index) {
                                case 0:
                                  appointmentController.currentDrawerIndex.value = 0;
                                  // appointmentController.scaffoldKey.currentState!.closeDrawer();
                                  break;
                                case 1:
                                  appointmentController.currentDrawerIndex.value = 1;
                                  break;
                                case 2:
                                  appointmentController.currentDrawerIndex.value = 2;
                                  break;
                                case 3:
                                  appointmentController.currentDrawerIndex.value = 3;
                                  break;
                                case 4:
                                  appointmentController.currentDrawerIndex.value = 4;
                                  break;
                                case 5:
                                  appointmentController.currentDrawerIndex.value = 5;
                                  break;
                                case 6:
                                  appointmentController.currentDrawerIndex.value = 6;
                                  break;
                                case 7:
                                  appointmentController.currentDrawerIndex.value = 7;
                                  break;
                                case 8:
                                  appointmentController.currentDrawerIndex.value = 8;
                                  break;
                                case 9:
                                  appointmentController.currentDrawerIndex.value = 9;
                                  break;
                                case 10:
                                  appointmentController.currentDrawerIndex.value = 10;
                                  break;
                              }
                            },
                            title: Text(
                              ListUtils.drawerList[index]["title"],
                              style: TextStyleConst.mediumTextStyle(
                                ColorConst.blackColor,
                                width * 0.04,
                              ),
                            ),
                            leading: SizedBox(
                              height: 25,
                              width: 25,
                              child: ImageIcon(
                                AssetImage(ListUtils.drawerList[index]["icon"]),
                                color: index == appointmentController.currentDrawerIndex.value ? ColorConst.blueColor : ColorConst.hintGreyColor,
                              ),
                            ),
                          ));
                    }),
                  ),
                ),
              ),
              Container(height: 1.5, width: double.infinity, color: ColorConst.borderGreyColor),
              SizedBox(height: height * 0.002),
              Container(
                margin: const EdgeInsets.only(right: 15),
                child: ListTile(
                  onTap: () {},
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
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              appointmentController.scaffoldKey.currentState!.openDrawer();
            },
            icon: const Icon(
              Icons.menu,
              color: ColorConst.blackColor,
            ),
          ),
          backgroundColor: ColorConst.whiteColor,
          elevation: 3,
          shadowColor: ColorConst.greyShadowColor,
          centerTitle: true,
          title: Text(
            StringUtils.appointment,
            style: TextStyleConst.boldTextStyle(
              ColorConst.blackColor,
              width * 0.05,
            ),
          ),
        ),
        body: Column(
          children: [
            Container(
              height: 70,
              margin: EdgeInsets.only(top: height * 0.01, bottom: height * 0.015),
              width: double.infinity,
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: appointmentController.appointmentStatus.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Center(
                    child: Obx(
                      () => GestureDetector(
                        onTap: () {
                          switch (index) {
                            case 0:
                              appointmentController.currentIndex.value = 0;
                              break;
                            case 1:
                              appointmentController.currentIndex.value = 1;
                              break;
                            case 2:
                              appointmentController.currentIndex.value = 2;
                              break;
                            case 3:
                              appointmentController.currentIndex.value = 3;
                              break;
                          }
                        },
                        child: Container(
                          margin: EdgeInsets.only(left: width * 0.03, right: index == 3 ? 10 : 0),
                          height: 50,
                          decoration: index == appointmentController.currentIndex.value
                              ? BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: ColorConst.blueColor,
                                )
                              : BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    width: 2,
                                    color: ColorConst.borderGreyColor,
                                  ),
                                ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                appointmentController.appointmentStatus[index],
                                style: TextStyleConst.mediumTextStyle(
                                    index == appointmentController.currentIndex.value ? ColorConst.whiteColor : ColorConst.hintGreyColor,
                                    width * 0.04),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: 20,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      ListTile(
                        title: Text(
                          "Dr.Harsh rathod",
                          style: TextStyleConst.mediumTextStyle(
                            ColorConst.blackColor,
                            width * 0.045,
                          ),
                        ),
                        subtitle: Text(
                          "Code addict  |  10:00 AM - 9th Sep, 2022",
                          style: TextStyleConst.mediumTextStyle(
                            ColorConst.hintGreyColor,
                            width * 0.04,
                          ),
                        ),
                        leading: Container(
                          height: 60,
                          width: 60,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image:
                                  NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQQ-YIPLhIBLVQKh_S4BNo18b03Ct5P_iYFeBBjDCYx&s"),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.02),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
