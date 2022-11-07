import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infyhms_flutter/component/common_app_bar.dart';
import 'package:infyhms_flutter/constant/color_const.dart';
import 'package:infyhms_flutter/constant/text_style_const.dart';
import 'package:infyhms_flutter/controller/home_controller.dart';
import 'package:infyhms_flutter/screens/account/my_account_screen.dart';
import 'package:infyhms_flutter/screens/admission/admissions_screen.dart';
import 'package:infyhms_flutter/screens/appointment/appointment_screen.dart';
import 'package:infyhms_flutter/screens/bills/bills_screen.dart';
import 'package:infyhms_flutter/screens/case/case_screen.dart';
import 'package:infyhms_flutter/screens/consultancy/live_consultations_screen.dart';
import 'package:infyhms_flutter/screens/diagnosis/diagnosis_screen.dart';
import 'package:infyhms_flutter/screens/document/document_screen.dart';
import 'package:infyhms_flutter/screens/invoice/invoice_screen.dart';
import 'package:infyhms_flutter/screens/notice/notice_board_screen.dart';
import 'package:infyhms_flutter/screens/prescription/prescriptions_screen.dart';
import 'package:infyhms_flutter/screens/vaccination/vaccination_screen.dart';
import 'package:infyhms_flutter/utils/image_utils.dart';
import 'package:infyhms_flutter/utils/list_utils.dart';
import 'package:infyhms_flutter/utils/string_utils.dart';

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
                    title: Text(
                      "Harsh Rathod",
                      style: TextStyleConst.mediumTextStyle(
                        ColorConst.blackColor,
                        width * 0.045,
                      ),
                    ),
                    subtitle: Text(
                      "harsh@gmail.com",
                      style: TextStyleConst.mediumTextStyle(
                        ColorConst.hintGreyColor,
                        width * 0.035,
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
                      onPressed: () {
                        Get.back();
                        Get.to(() => const MyAccountScreen());
                      },
                    ),
                  ),
                  SizedBox(height: height * 0.01),
                  Container(height: 1.5, width: double.infinity, color: ColorConst.borderGreyColor),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: List.generate(11, (index) {
                          return ListTile(
                            onTap: () {
                              Get.back();
                              controller.update();
                              switch (index) {
                                case 0:
                                  controller.currentWidget = AppointmentScreen();
                                  controller.appBarTitle.value = StringUtils.appointment;
                                  controller.currentDrawerIndex.value = 0;
                                  break;
                                case 1:
                                  controller.currentWidget = BillScreen();
                                  controller.appBarTitle.value = StringUtils.bills;
                                  controller.currentDrawerIndex.value = 1;
                                  break;
                                case 2:
                                  controller.currentWidget = DiagnosisScreen();
                                  controller.appBarTitle.value = StringUtils.diagnosisTests;
                                  controller.currentDrawerIndex.value = 2;
                                  break;
                                case 3:
                                  controller.currentWidget = const DocumentScreen();
                                  controller.appBarTitle.value = StringUtils.documents;
                                  controller.currentDrawerIndex.value = 3;
                                  break;
                                case 4:
                                  controller.currentWidget = const NoticeBoardScreen();
                                  controller.appBarTitle.value = StringUtils.noticeBoards;
                                  controller.currentDrawerIndex.value = 4;
                                  break;
                                case 5:
                                  controller.currentWidget = const InvoiceScreen();
                                  controller.appBarTitle.value = StringUtils.invoices;
                                  controller.currentDrawerIndex.value = 5;
                                  break;
                                case 6:
                                  controller.currentWidget = LiveConsultationsScreen();
                                  controller.appBarTitle.value = StringUtils.liveConsultations;
                                  controller.currentDrawerIndex.value = 6;
                                  break;
                                case 7:
                                  controller.currentWidget = CaseScreen();
                                  controller.appBarTitle.value = StringUtils.myCases;
                                  controller.currentDrawerIndex.value = 7;
                                  break;
                                case 8:
                                  controller.currentWidget = const AdmissionScreen();
                                  controller.appBarTitle.value = StringUtils.myAdmissions;
                                  controller.currentDrawerIndex.value = 8;
                                  break;
                                case 9:
                                  controller.currentWidget = const PrescriptionsScreen();
                                  controller.appBarTitle.value = StringUtils.prescriptions;
                                  controller.currentDrawerIndex.value = 9;
                                  break;
                                case 10:
                                  controller.currentWidget = const VaccinationScreen();
                                  controller.appBarTitle.value = StringUtils.vaccinatedPatients;
                                  controller.currentDrawerIndex.value = 10;
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
            body: controller.currentWidget,
          );
        },
      ),
    );
  }
}
