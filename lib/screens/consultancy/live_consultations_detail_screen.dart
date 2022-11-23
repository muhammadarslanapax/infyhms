import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infyhms_flutter/component/common_app_bar.dart';
import 'package:infyhms_flutter/component/common_detail_text.dart';
import 'package:infyhms_flutter/constant/color_const.dart';
import 'package:infyhms_flutter/controller/live_consultancy_controller/live_consultancy_details_controller.dart';
import 'package:infyhms_flutter/utils/preference_utils.dart';
import 'package:infyhms_flutter/utils/string_utils.dart';

class LiveConsultationsDetailScreen extends StatelessWidget {
  LiveConsultationsDetailScreen({Key? key}) : super(key: key);

  final LiveConsultancyDetailsController liveConsultationsController = Get.put(LiveConsultancyDetailsController());

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        appBar: CommonAppBar(
          title: StringUtils.liveConsultationsDetails,
          leadOnTap: () {
            Get.back();
          },
          leadIcon: const Icon(
            Icons.arrow_back_rounded,
            color: ColorConst.blackColor,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Obx(() {
            return liveConsultationsController.gotDetailsOfConsultation.value == false
                ? const Center(child: CircularProgressIndicator(color: ColorConst.primaryColor))
                : SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        SizedBox(height: height * 0.02),
                        CommonDetailText(
                          width: width,
                          titleText: StringUtils.consultationTitle,
                          descriptionText: PreferenceUtils.getBoolValue("isDoctor")
                              ? liveConsultationsController.doctorLiveConsultationsDetailsModel?.data?.consultation_title ?? "N/A"
                              : liveConsultationsController.liveConsultationDetailsModel?.data?.consultation_title ?? "N/A",
                        ),
                        SizedBox(height: height * 0.015),
                        CommonDetailText(
                          width: width,
                          titleText: StringUtils.consultationDate,
                          descriptionText: PreferenceUtils.getBoolValue("isDoctor")
                              ? liveConsultationsController.doctorLiveConsultationsDetailsModel?.data?.consultation_date ?? "N/A"
                              : liveConsultationsController.liveConsultationDetailsModel?.data?.consultation_date ?? "N/A",
                        ),
                        SizedBox(height: height * 0.015),
                        CommonDetailText(
                          width: width,
                          titleText: StringUtils.durationMinute,
                          descriptionText: PreferenceUtils.getBoolValue("isDoctor")
                              ? liveConsultationsController.doctorLiveConsultationsDetailsModel?.data?.duration_minutes ?? "N/A"
                              : liveConsultationsController.liveConsultationDetailsModel?.data?.duration ?? "N/A",
                        ),
                        SizedBox(height: height * 0.015),
                        CommonDetailText(
                          width: width,
                          titleText: PreferenceUtils.getBoolValue("isDoctor") ? StringUtils.patientName : StringUtils.doctorName,
                          descriptionText: PreferenceUtils.getBoolValue("isDoctor")
                              ? liveConsultationsController.doctorLiveConsultationsDetailsModel?.data?.patient_name ?? "N/A"
                              : liveConsultationsController.liveConsultationDetailsModel?.data?.dostor_name ?? "N/A",
                        ),
                        SizedBox(height: height * 0.015),
                        CommonDetailText(
                          width: width,
                          titleText: StringUtils.type,
                          descriptionText: PreferenceUtils.getBoolValue("isDoctor")
                              ? liveConsultationsController.doctorLiveConsultationsDetailsModel?.data?.type ?? "N/A"
                              : liveConsultationsController.liveConsultationDetailsModel?.data?.type ?? "N/A",
                        ),
                        SizedBox(height: height * 0.015),
                        CommonDetailText(
                          width: width,
                          titleText: StringUtils.typeNumber,
                          descriptionText: PreferenceUtils.getBoolValue("isDoctor")
                              ? liveConsultationsController.doctorLiveConsultationsDetailsModel?.data?.type_number ?? "N/A"
                              : liveConsultationsController.liveConsultationDetailsModel?.data?.type_number ?? "N/A",
                        ),
                      ],
                    ),
                  );
          }),
        ),
      ),
    );
  }
}
