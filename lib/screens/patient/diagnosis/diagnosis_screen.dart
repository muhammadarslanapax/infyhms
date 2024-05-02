import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:infyhms_flutter/component/common_button.dart';
import 'package:infyhms_flutter/constant/color_const.dart';
import 'package:infyhms_flutter/constant/text_style_const.dart';
import 'package:infyhms_flutter/controller/patient/diagnosis_controller/diagnosis_test_controller.dart';
import 'package:infyhms_flutter/screens/patient/diagnosis/diagnosis_test_detail_screen.dart';
import 'package:infyhms_flutter/utils/image_utils.dart';
import 'package:infyhms_flutter/utils/preference_utils.dart';
import 'package:infyhms_flutter/utils/string_utils.dart';

class DiagnosisScreen extends StatelessWidget {
  DiagnosisScreen({Key? key}) : super(key: key);
  final DiagnosisTestController diagnosisTestController = Get.put(DiagnosisTestController());

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Obx(
      () => PreferenceUtils.getBoolValue("isDoctor")
          ? diagnosisTestController.isDiagnosisTestApiCall.value == true
              ? diagnosisTestController.doctorDiagnosisTestModel!.data!.isEmpty
                  ? Container(
                      color: ColorConst.whiteColor,
                      child: Center(
                        child: Text(
                          "No diagnosis test found",
                          style: TextStyleConst.mediumTextStyle(
                            ColorConst.blackColor,
                            width * 0.04,
                          ),
                        ),
                      ),
                    )
                  : Container(
                      color: Colors.white,
                      child: ListView.builder(
                        itemCount: diagnosisTestController.doctorDiagnosisTestModel!.data!.length,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Slidable(
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
                                                        Get.back();
                                                        diagnosisTestController
                                                            .deleteTest(diagnosisTestController.doctorDiagnosisTestModel!.data![index].id!);
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
                              onTap: () {
                                Get.to(
                                  () => DiagnosisTestDetailScreen(),
                                  transition: Transition.rightToLeft,
                                  arguments: diagnosisTestController.doctorDiagnosisTestModel!.data![index].id,
                                );
                              },
                              contentPadding: EdgeInsets.only(top: index == 0 ? 15 : 10, left: 15, right: 15),
                              leading: Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(diagnosisTestController.doctorDiagnosisTestModel!.data![index].patient_image!),
                                  ),
                                ),
                              ),
                              trailing: Obx(() => (diagnosisTestController
                                      .isCurrentDownloading[index].value)
                                  ? const CircularProgressIndicator(
                                      color: ColorConst.primaryColor)
                                  : InkWell(
                                      onTap: () {
                                        diagnosisTestController
                                            .downloadDiagnosis(context, index);
                                      },
                                      child: Container(
                                        margin:
                                            const EdgeInsets.only(right: 10),
                                        width: 25,
                                        height: 25,
                                        decoration: const BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(
                                                ImageUtils.downloadIcon),
                                          ),
                                        ),
                                      ),
                                    )),
                              title: Text(
                                diagnosisTestController.doctorDiagnosisTestModel!.data![index].patient_name!,
                                style: TextStyleConst.mediumTextStyle(
                                  ColorConst.blackColor,
                                  width * 0.045,
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: height * 0.002),
                                  Text(
                                    diagnosisTestController.doctorDiagnosisTestModel!.data![index].category!,
                                    style: TextStyleConst.mediumTextStyle(
                                      ColorConst.hintGreyColor,
                                      width * 0.035,
                                    ),
                                  ),
                                  Text(
                                    "${diagnosisTestController.doctorDiagnosisTestModel!.data![index].report_number!} | ${diagnosisTestController.doctorDiagnosisTestModel!.data![index].created_at}",
                                    style: TextStyleConst.mediumTextStyle(
                                      ColorConst.hintGreyColor,
                                      width * 0.036,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    )
              : const Center(child: CircularProgressIndicator())
          : diagnosisTestController.isDiagnosisTestApiCall.value == true
              ? diagnosisTestController.diagnosisTestModel!.data!.isEmpty
                  ? Container(
                      color: ColorConst.whiteColor,
                      child: Center(
                        child: Text(
                          "No diagnosis test found",
                          style: TextStyleConst.mediumTextStyle(
                            ColorConst.blackColor,
                            width * 0.04,
                          ),
                        ),
                      ),
                    )
                  : Container(
                      color: Colors.white,
                      child: ListView.builder(
                        itemCount: diagnosisTestController.diagnosisTestModel!.data!.length,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return ListTile(
                            onTap: () {
                              Get.to(
                                () => DiagnosisTestDetailScreen(),
                                transition: Transition.rightToLeft,
                                arguments: diagnosisTestController.diagnosisTestModel!.data![index].id,
                              );
                            },
                            contentPadding: EdgeInsets.only(top: index == 0 ? 15 : 10, left: 15, right: 15),
                            leading: Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(diagnosisTestController.diagnosisTestModel!.data![index].doctor_image!),
                                ),
                              ),
                            ),
                            trailing: Obx(
                              () => (diagnosisTestController
                                      .isCurrentDownloading[index].value)
                                  ? const CircularProgressIndicator(
                                      color: ColorConst.primaryColor)
                                  : InkWell(
                                      onTap: () {
                                        diagnosisTestController
                                            .downloadDiagnosis(context, index);
                                      },
                                      child: Container(
                                        margin:
                                            const EdgeInsets.only(right: 10),
                                        width: 25,
                                        height: 25,
                                        decoration: const BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(
                                                ImageUtils.downloadIcon),
                                          ),
                                        ),
                                      ),
                                    ),
                            ),
                            title: Text(
                              diagnosisTestController.diagnosisTestModel!.data![index].doctor_name ?? "N/A",
                              style: TextStyleConst.mediumTextStyle(
                                ColorConst.blackColor,
                                width * 0.045,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: height * 0.002),
                                Text(
                                  diagnosisTestController.diagnosisTestModel!.data![index].category ?? "N/A",
                                  style: TextStyleConst.mediumTextStyle(
                                    ColorConst.hintGreyColor,
                                    width * 0.035,
                                  ),
                                ),
                                Text(
                                  "${diagnosisTestController.diagnosisTestModel!.data![index].report_number!} | ${diagnosisTestController.diagnosisTestModel!.data![index].created_at}",
                                  style: TextStyleConst.mediumTextStyle(
                                    ColorConst.hintGreyColor,
                                    width * 0.036,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    )
              : const Center(child: CircularProgressIndicator()),
    );
  }
}
