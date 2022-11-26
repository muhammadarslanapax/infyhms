import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:infyhms_flutter/component/common_alert_box.dart';
import 'package:infyhms_flutter/component/common_app_bar.dart';
import 'package:infyhms_flutter/component/common_button.dart';
import 'package:infyhms_flutter/constant/color_const.dart';
import 'package:infyhms_flutter/constant/text_style_const.dart';
import 'package:infyhms_flutter/controller/doctor/report_controller/report_screen_controller.dart';
import 'package:infyhms_flutter/screens/doctor/report_screen/doctor_case_details_screen.dart';
import 'package:infyhms_flutter/utils/image_utils.dart';
import 'package:infyhms_flutter/utils/string_utils.dart';

class ReportScreen extends StatelessWidget {
  ReportScreen({Key? key, required this.title}) : super(key: key);
  final String title;
  final ReportScreenController reportScreenController = Get.put(ReportScreenController());

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: CommonAppBar(
          title: title,
          leadOnTap: () {
            Get.back();
          },
          leadIcon: const Icon(
            Icons.arrow_back_rounded,
            color: ColorConst.blackColor,
          ),
        ),
        body: Obx(() {
          if (title == StringUtils.investigationReport) {
            return reportScreenController.isGotReport.value == false
                ? const Center(child: CircularProgressIndicator())
                : reportScreenController.investigationReportModel!.data!.isEmpty
                    ? Container(
                        color: ColorConst.whiteColor,
                        child: Center(
                          child: Text(
                            "No report found",
                            style: TextStyleConst.mediumTextStyle(
                              ColorConst.blackColor,
                              width * 0.04,
                            ),
                          ),
                        ),
                      )
                    : ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: reportScreenController.investigationReportModel!.data!.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Slidable(
                                endActionPane: ActionPane(
                                  extentRatio: 0.25,
                                  motion: const ScrollMotion(),
                                  children: [
                                    SlidableAction(
                                      onPressed: (context) {
                                        ContentOfDialog contentOfDialog = ContentOfDialog(
                                          height: height,
                                          width: width,
                                          image: ImageUtils.deleteIcon,
                                          title: "Delete",
                                          description: "Are you sure want to delete this\nappointment?",
                                          leftText: StringUtils.delete,
                                          rightText: StringUtils.cancel,
                                          leftTapEvent: () {
                                            reportScreenController.deleteReport(reportScreenController.investigationReportModel!.data![index].id!);
                                          },
                                          rightTapEvent: () {
                                            Get.back();
                                          },
                                        );
                                        CommonAlertDialog.commonAlertDialog(context, contentOfDialog);
                                      },
                                      backgroundColor: const Color(0xFFFCE5E5),
                                      foregroundColor: ColorConst.redColor,
                                      label: StringUtils.delete,
                                    ),
                                  ],
                                ),
                                child: ListTile(
                                  contentPadding: EdgeInsets.only(top: index == 0 ? 10 : 0, left: 10, right: 10),
                                  onTap: () {
                                    Get.to(
                                      () => DoctorCaseDetailsScreen(),
                                      transition: Transition.rightToLeft,
                                      arguments: reportScreenController.commonReportModel!.data![index].case_id!,
                                    );
                                  },
                                  leading: Container(
                                    height: 60,
                                    width: 60,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(reportScreenController.investigationReportModel!.data![index].patient_image!),
                                      ),
                                    ),
                                  ),
                                  title: Text(
                                    reportScreenController.investigationReportModel!.data![index].patient_name!,
                                    style: TextStyleConst.mediumTextStyle(
                                      ColorConst.blackColor,
                                      width * 0.045,
                                    ),
                                  ),
                                  subtitle: Row(
                                    children: [
                                      Text(
                                        reportScreenController.investigationReportModel!.data![index].title!,
                                        style: TextStyleConst.mediumTextStyle(
                                          ColorConst.hintGreyColor,
                                          width * 0.036,
                                        ),
                                      ),
                                      Text(
                                        " | ",
                                        style: TextStyleConst.mediumTextStyle(
                                          ColorConst.primaryColor,
                                          width * 0.036,
                                        ),
                                      ),
                                      Flexible(
                                        child: Text(
                                          "${reportScreenController.investigationReportModel!.data![index].time!} - ${reportScreenController.investigationReportModel!.data![index].date!}",
                                          style: TextStyleConst.mediumTextStyle(
                                            ColorConst.hintGreyColor,
                                            width * 0.036,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
          } else {
            return reportScreenController.isGotReport.value == false
                ? const Center(child: CircularProgressIndicator())
                : reportScreenController.commonReportModel!.data!.isEmpty
                    ? Container(
                        color: ColorConst.whiteColor,
                        child: Center(
                          child: Text(
                            "No report found",
                            style: TextStyleConst.mediumTextStyle(
                              ColorConst.blackColor,
                              width * 0.04,
                            ),
                          ),
                        ),
                      )
                    : ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: reportScreenController.commonReportModel!.data!.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Slidable(
                                endActionPane: ActionPane(
                                  extentRatio: 0.25,
                                  motion: const ScrollMotion(),
                                  children: [
                                    SlidableAction(
                                      onPressed: (context) {
                                        showDialog(
                                          barrierDismissible: false,
                                          context: context,
                                          builder: (context) {
                                            return Center(
                                              child: Container(
                                                height: height / 2.7,
                                                width: width / 1.12,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(15),
                                                  color: Colors.white,
                                                ),
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      height: 60,
                                                      width: 60,
                                                      decoration: const BoxDecoration(
                                                        image: DecorationImage(
                                                          image: AssetImage(ImageUtils.deleteIcon),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(height: height * 0.03),
                                                    Text(
                                                      "Delete",
                                                      style: TextStyleConst.boldTextStyle(
                                                        ColorConst.blackColor,
                                                        width * 0.05,
                                                      ),
                                                    ),
                                                    SizedBox(height: height * 0.01),
                                                    Text(
                                                      "Are you sure want to delete this\n appointment?",
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
                                                            reportScreenController
                                                                .deleteReport(reportScreenController.commonReportModel!.data![index].id!);
                                                          },
                                                          color: ColorConst.blueColor,
                                                          text: StringUtils.delete,
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
                                            );
                                          },
                                        );
                                      },
                                      backgroundColor: const Color(0xFFFCE5E5),
                                      foregroundColor: ColorConst.redColor,
                                      label: StringUtils.delete,
                                    ),
                                  ],
                                ),
                                child: ListTile(
                                  contentPadding: EdgeInsets.only(top: index == 0 ? 10 : 0, left: 10, right: 10),
                                  onTap: () {
                                    if (title != StringUtils.investigationReport) {
                                      Get.to(
                                        () => DoctorCaseDetailsScreen(),
                                        transition: Transition.rightToLeft,
                                        arguments: reportScreenController.commonReportModel!.data![index].case_id!,
                                      );
                                    }
                                  },
                                  leading: Container(
                                    height: 60,
                                    width: 60,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(reportScreenController.commonReportModel!.data![index].patient_image!),
                                      ),
                                    ),
                                  ),
                                  title: Text(
                                    reportScreenController.commonReportModel!.data![index].patient_name!,
                                    style: TextStyleConst.mediumTextStyle(
                                      ColorConst.blackColor,
                                      width * 0.045,
                                    ),
                                  ),
                                  subtitle: Row(
                                    children: [
                                      Text(
                                        reportScreenController.commonReportModel!.data![index].case_id!,
                                        style: TextStyleConst.mediumTextStyle(
                                          ColorConst.hintGreyColor,
                                          width * 0.036,
                                        ),
                                      ),
                                      Text(
                                        " | ",
                                        style: TextStyleConst.mediumTextStyle(
                                          ColorConst.primaryColor,
                                          width * 0.036,
                                        ),
                                      ),
                                      Flexible(
                                        child: Text(
                                          "${reportScreenController.commonReportModel!.data![index].time!} - ${reportScreenController.commonReportModel!.data![index].date!}",
                                          style: TextStyleConst.mediumTextStyle(
                                            ColorConst.hintGreyColor,
                                            width * 0.036,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
          }
        }),
      ),
    );
  }
}
