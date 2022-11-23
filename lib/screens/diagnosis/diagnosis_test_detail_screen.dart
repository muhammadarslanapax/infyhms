import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infyhms_flutter/component/common_app_bar.dart';
import 'package:infyhms_flutter/component/common_button.dart';
import 'package:infyhms_flutter/component/common_detail_text.dart';
import 'package:infyhms_flutter/constant/color_const.dart';
import 'package:infyhms_flutter/constant/text_style_const.dart';
import 'package:infyhms_flutter/controller/diagnosis_controller/diagnosis_test_details_controller.dart';
import 'package:infyhms_flutter/utils/preference_utils.dart';
import 'package:infyhms_flutter/utils/string_utils.dart';

class DiagnosisTestDetailScreen extends StatelessWidget {
  DiagnosisTestDetailScreen({Key? key}) : super(key: key);
  final DiagnosisTestDetailsController diagnosisTestDetailsController = Get.put(DiagnosisTestDetailsController());

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConst.whiteColor,
        appBar: CommonAppBar(
          title: StringUtils.diagnosisTestsDetails,
          leadOnTap: () {
            Get.back();
          },
          leadIcon: const Icon(
            Icons.arrow_back_rounded,
            color: ColorConst.blackColor,
          ),
        ),
        body: Obx(
          () => diagnosisTestDetailsController.isDetailsGet.value == true
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        SizedBox(height: height * 0.02),
                        CommonDetailText(
                          width: width,
                          titleText: PreferenceUtils.getBoolValue("isDoctor") ? StringUtils.patient : StringUtils.doctor,
                          descriptionText: PreferenceUtils.getBoolValue("isDoctor")
                              ? diagnosisTestDetailsController.doctorDiagnosisTestDetailsModel!.data!.patient_name!
                              : diagnosisTestDetailsController.diagnosisTestDetailsModel!.data!.doctor_name!,
                        ),
                        SizedBox(height: height * 0.015),
                        CommonDetailText(
                          width: width,
                          titleText: StringUtils.diagnosisCategory,
                          descriptionText: PreferenceUtils.getBoolValue("isDoctor")
                              ? diagnosisTestDetailsController.doctorDiagnosisTestDetailsModel!.data!.category!
                              : diagnosisTestDetailsController.diagnosisTestDetailsModel!.data!.category!,
                        ),
                        SizedBox(height: height * 0.015),
                        PreferenceUtils.getBoolValue("isDoctor")
                            ? CommonDetailText(
                                width: width,
                                titleText: StringUtils.age,
                                descriptionText: diagnosisTestDetailsController.doctorDiagnosisTestDetailsModel!.data!.patient_diagnosis!.age!,
                              )
                            : const SizedBox(),
                        PreferenceUtils.getBoolValue("isDoctor") ? SizedBox(height: height * 0.015) : const SizedBox(),
                        CommonDetailText(
                          width: width,
                          titleText: StringUtils.height,
                          descriptionText: PreferenceUtils.getBoolValue("isDoctor")
                              ? diagnosisTestDetailsController.doctorDiagnosisTestDetailsModel!.data!.patient_diagnosis!.height!
                              : diagnosisTestDetailsController.diagnosisTestDetailsModel!.data!.patient_diagnosis!.height!,
                        ),
                        SizedBox(height: height * 0.015),
                        CommonDetailText(
                            width: width,
                            titleText: StringUtils.weight,
                            descriptionText: PreferenceUtils.getBoolValue("isDoctor")
                                ? diagnosisTestDetailsController.doctorDiagnosisTestDetailsModel!.data!.patient_diagnosis!.weight!
                                : diagnosisTestDetailsController.diagnosisTestDetailsModel!.data!.patient_diagnosis!.weight!),
                        SizedBox(height: height * 0.015),
                        CommonDetailText(
                          width: width,
                          titleText: StringUtils.reportNumber,
                          descriptionText: PreferenceUtils.getBoolValue("isDoctor")
                              ? diagnosisTestDetailsController.doctorDiagnosisTestDetailsModel!.data!.report_number!
                              : diagnosisTestDetailsController.diagnosisTestDetailsModel!.data!.report_number!,
                        ),
                        SizedBox(height: height * 0.015),
                        CommonDetailText(
                          width: width,
                          titleText: StringUtils.averageGlucose,
                          descriptionText: PreferenceUtils.getBoolValue("isDoctor")
                              ? diagnosisTestDetailsController.doctorDiagnosisTestDetailsModel!.data!.patient_diagnosis!.average_glucose!
                              : diagnosisTestDetailsController.diagnosisTestDetailsModel!.data!.patient_diagnosis!.average_glucose!,
                        ),
                        SizedBox(height: height * 0.015),
                        CommonDetailText(
                          width: width,
                          titleText: StringUtils.fastingBloodSugar,
                          descriptionText: PreferenceUtils.getBoolValue("isDoctor")
                              ? diagnosisTestDetailsController.doctorDiagnosisTestDetailsModel!.data!.patient_diagnosis!.fasting_blood_sugar!
                              : diagnosisTestDetailsController.diagnosisTestDetailsModel!.data!.patient_diagnosis!.fasting_blood_sugar!,
                        ),
                        SizedBox(height: height * 0.015),
                        CommonDetailText(
                          width: width,
                          titleText: StringUtils.urineSugar,
                          descriptionText: PreferenceUtils.getBoolValue("isDoctor")
                              ? diagnosisTestDetailsController.doctorDiagnosisTestDetailsModel!.data!.patient_diagnosis!.urine_sugar!
                              : diagnosisTestDetailsController.diagnosisTestDetailsModel!.data!.patient_diagnosis!.urine_sugar!,
                        ),
                        SizedBox(height: height * 0.015),
                        CommonDetailText(
                          width: width,
                          titleText: StringUtils.bloodPressure,
                          descriptionText: PreferenceUtils.getBoolValue("isDoctor")
                              ? diagnosisTestDetailsController.doctorDiagnosisTestDetailsModel!.data!.patient_diagnosis!.blood_pressure!
                              : diagnosisTestDetailsController.diagnosisTestDetailsModel!.data!.patient_diagnosis!.blood_pressure!,
                        ),
                        SizedBox(height: height * 0.015),
                        CommonDetailText(
                          width: width,
                          titleText: StringUtils.diabetes,
                          descriptionText: PreferenceUtils.getBoolValue("isDoctor")
                              ? diagnosisTestDetailsController.doctorDiagnosisTestDetailsModel!.data!.patient_diagnosis!.diabetes!
                              : diagnosisTestDetailsController.diagnosisTestDetailsModel!.data!.patient_diagnosis!.diabetes!,
                        ),
                        SizedBox(height: height * 0.015),
                        CommonDetailText(
                          width: width,
                          titleText: StringUtils.cholesterol,
                          descriptionText: PreferenceUtils.getBoolValue("isDoctor")
                              ? diagnosisTestDetailsController.doctorDiagnosisTestDetailsModel!.data!.patient_diagnosis!.cholesterol!
                              : diagnosisTestDetailsController.diagnosisTestDetailsModel!.data!.patient_diagnosis!.cholesterol!,
                        ),
                        SizedBox(height: height * 0.015),
                        CommonDetailText(
                          width: width,
                          titleText: StringUtils.createOn,
                          descriptionText: PreferenceUtils.getBoolValue("isDoctor")
                              ? diagnosisTestDetailsController.doctorDiagnosisTestDetailsModel!.data!.created_on!
                              : diagnosisTestDetailsController.diagnosisTestDetailsModel!.data!.created_on!,
                        ),
                        SizedBox(height: height * 0.04),
                        Center(
                          child: Obx(
                            () => diagnosisTestDetailsController.isDownloading.value == true
                                ? const Center(child: CircularProgressIndicator(color: ColorConst.primaryColor))
                                : CommonButton(
                                    width: width / 1.2,
                                    height: 50,
                                    text: StringUtils.downloadDiagnosisTest,
                                    color: ColorConst.blueColor,
                                    onTap: () {
                                      diagnosisTestDetailsController.downloadPDF(PreferenceUtils.getBoolValue("isDoctor")
                                          ? diagnosisTestDetailsController.doctorDiagnosisTestDetailsModel!.data!.pdf_url!
                                          : diagnosisTestDetailsController.diagnosisTestDetailsModel!.data!.pdf_url!);
                                    },
                                    textStyleConst: TextStyleConst.mediumTextStyle(
                                      ColorConst.whiteColor,
                                      width * 0.05,
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : const Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}
