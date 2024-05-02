import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infyhms_flutter/component/common_button.dart';
import 'package:infyhms_flutter/component/common_detail_text.dart';
import 'package:infyhms_flutter/component/common_loader.dart';
import 'package:infyhms_flutter/component/common_snackbar.dart';
import 'package:infyhms_flutter/component/common_socket_exception.dart';
import 'package:infyhms_flutter/constant/color_const.dart';
import 'package:infyhms_flutter/constant/text_style_const.dart';
import 'package:infyhms_flutter/model/doctor/doctor_live_consultations_model/doctor_live_consultations_meeting_model.dart';
import 'package:infyhms_flutter/model/doctor/doctor_live_consultations_model/doctor_live_consultations_model.dart';
import 'package:infyhms_flutter/model/patient/live_consultancy/live_consultation_filter.dart';
import 'package:infyhms_flutter/model/patient/live_consultancy/live_consultation_meeting_model.dart';
import 'package:infyhms_flutter/utils/preference_utils.dart';
import 'package:infyhms_flutter/utils/string_utils.dart';
import 'package:infyhms_flutter/widget/live_consul_status.dart';
import 'package:url_launcher/url_launcher.dart';

class LiveConsultationsController extends GetxController {
  LiveConsultationMeetingModel? liveConsultationMeetingModel;
  LiveConsultationFilter? liveConsultationFilter;
  DoctorLiveConsultationsModel? doctorLiveConsultationsModel;
  DoctorLiveConsultationsMeetingModel? doctorLiveConsultationsMeetingModel;
  RxList consultationsStatus = ["All", "Awaited", "Cancelled", "Finished"].obs;
  RxInt currentIndex = 0.obs;

  RxBool gotConsultationData = false.obs;
  RxBool gotMeetingData = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    PreferenceUtils.getBoolValue("isDoctor")
        ? getDoctorConsultancy("all")
        : getConsultancy("all");
  }

  void changeIndex(int index) {
    gotConsultationData.value = false;
    switch (index) {
      case 0:
        currentIndex.value = 0;
        PreferenceUtils.getBoolValue("isDoctor")
            ? getDoctorConsultancy("all")
            : getConsultancy("all");
        break;
      case 1:
        currentIndex.value = 1;
        PreferenceUtils.getBoolValue("isDoctor")
            ? getDoctorConsultancy("awaited")
            : getConsultancy("awaited");
        break;
      case 2:
        currentIndex.value = 2;
        PreferenceUtils.getBoolValue("isDoctor")
            ? getDoctorConsultancy("cancelled")
            : getConsultancy("cancelled");
        break;
      case 3:
        currentIndex.value = 3;
        PreferenceUtils.getBoolValue("isDoctor")
            ? getDoctorConsultancy("finished")
            : getConsultancy("finished");
        break;
    }
  }

  void getConsultancy(String status) {
    StringUtils.client
        .liveConsultationFilter(PreferenceUtils.getStringValue("token"), status)
      ..then((value) {
        liveConsultationFilter = value;
        gotConsultationData.value = true;
      })
      ..onError((DioError error, stackTrace) {
        // gotConsultationData.value = true;
        CheckSocketException.checkSocketException(error);
        return LiveConsultationFilter();
      });
  }

  void getDoctorConsultancy(String status) {
    StringUtils.client.liveDoctorConsultationFilter(
        PreferenceUtils.getStringValue("token"), status)
      ..then((value) {
        doctorLiveConsultationsModel = value;
        gotConsultationData.value = true;
      })
      ..onError((DioError error, stackTrace) {
        gotConsultationData.value = true;
        CheckSocketException.checkSocketException(error);

        return DoctorLiveConsultationsModel();
      });
  }

  void launchConsultationURL(String url) {
    try {
      launchUrl(Uri.parse(url));
    } catch (e) {
      DisplaySnackBar.displaySnackBar("Can't launch URL");
    }
  }

  void getLiveMeeting(
      int consultationId, BuildContext context, double height, double width) {
    CommonLoader.showLoader();
    StringUtils.client.liveConsultationMeetingData(
        PreferenceUtils.getStringValue("token"), consultationId)
      ..then((value) {
        liveConsultationMeetingModel = value;
        Get.back();
        if (liveConsultationMeetingModel!.success == true) {
          gotMeetingData.value = true;
          showModalBottomSheet(
            backgroundColor: ColorConst.whiteColor,
            shape: const OutlineInputBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50),
              ),
              borderSide: BorderSide.none,
            ),
            context: context,
            builder: (context) {
              return Container(
                color: ColorConst.whiteColor,
                margin: const EdgeInsets.only(right: 25, top: 20, left: 25),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          height: 5,
                          width: 60,
                          decoration: BoxDecoration(
                            color: const Color(0xffE7E9EB),
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.03),
                      Text(
                        "${liveConsultationMeetingModel!.data!.consultation_title}",
                        style: TextStyleConst.boldTextStyle(
                          ColorConst.blackColor,
                          width * 0.045,
                        ),
                      ),
                      SizedBox(height: height * 0.01),
                      statusText("${liveConsultationMeetingModel!.data!.status}", width),
                      SizedBox(height: height * 0.02),
                      CommonDetailText(
                        width: width,
                        titleText: "Host Video:",
                        descriptionText: "${liveConsultationMeetingModel!.data!.host_video}",
                      ),
                      SizedBox(height: height * 0.01),
                      CommonDetailText(
                        width: width,
                        titleText: "Consultation Date:",
                        descriptionText: "${liveConsultationMeetingModel!.data!.consultation_date}",
                      ),
                      SizedBox(height: height * 0.01),
                      CommonDetailText(
                        width: width,
                        titleText: "Duration:",
                        descriptionText: "${liveConsultationMeetingModel!.data!.duration_minutes} Minutes",
                      ),
                      SizedBox(height: height * 0.03),
                      Center(
                        child: liveConsultationMeetingModel!.data!.meta! == "N/A"
                            ? ElevatedButton.icon(
                                icon: const Icon(
                                  Icons.videocam_rounded,
                                  color: ColorConst.whiteColor,
                                ),
                                style: ElevatedButton.styleFrom(
                                  splashFactory: NoSplash.splashFactory,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  elevation: 0,
                                  disabledBackgroundColor:
                                      ColorConst.blueColor.withOpacity(0.5),
                                  fixedSize: Size(width / 2, 50),
                                ),
                                onPressed: null,
                                onLongPress: null,
                                label: Text(
                                  "Join Now",
                                  textAlign: TextAlign.center,
                                  style: TextStyleConst.mediumTextStyle(
                                    ColorConst.whiteColor,
                                    width * 0.05,
                                  ),
                                ),
                              )
                            : CommonButton(
                                isIcon: true,
                                width: width / 2,
                                height: 50,
                                text: "Join Now",
                                color: ColorConst.blueColor,
                                onTap: () {
                                  launchConsultationURL(liveConsultationMeetingModel!.data!.meta!);
                                },
                                textStyleConst: TextStyleConst.mediumTextStyle(
                                  ColorConst.whiteColor,
                                  width * 0.05,
                                ),
                              ),
                      ),
                      SizedBox(height: height * 0.02),
                    ],
                  ),
                ),
              );
            },
          );
        }

      })
      ..onError((DioError error, stackTrace) {
        Get.back();
        gotMeetingData.value = true;
        CheckSocketException.checkSocketException(error);
        return LiveConsultationMeetingModel();
      });
  }

  void getDoctorLiveMeeting(
      int consultationId, BuildContext context, double height, double width) {
    CommonLoader.showLoader();
    StringUtils.client.liveDoctorConsultationMeetingData(
        PreferenceUtils.getStringValue("token"), consultationId)
      ..then((value) {
        doctorLiveConsultationsMeetingModel = value;
        Get.back();
        if (doctorLiveConsultationsMeetingModel!.success == true) {
          gotMeetingData.value = true;
          showModalBottomSheet(
            backgroundColor: ColorConst.whiteColor,
            shape: const OutlineInputBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50),
              ),
              borderSide: BorderSide.none,
            ),
            context: context,
            builder: (context) {
              return Container(
                color: ColorConst.whiteColor,
                margin: const EdgeInsets.only(right: 25, top: 20, left: 25),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          height: 5,
                          width: 60,
                          decoration: BoxDecoration(
                            color: const Color(0xffE7E9EB),
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.03),
                      Text(
                        "${doctorLiveConsultationsMeetingModel!.data!.consultation_title}",
                        style: TextStyleConst.boldTextStyle(
                          ColorConst.blackColor,
                          width * 0.045,
                        ),
                      ),
                      SizedBox(height: height * 0.01),
                      statusText(
                          "${doctorLiveConsultationsMeetingModel!.data!.status}",
                          width),
                      SizedBox(height: height * 0.02),
                      CommonDetailText(
                        width: width,
                        titleText: "Host Video:",
                        descriptionText:
                            "${doctorLiveConsultationsMeetingModel!.data!.host_video}",
                      ),
                      SizedBox(height: height * 0.01),
                      CommonDetailText(
                        width: width,
                        titleText: "Consultation Date:",
                        descriptionText:
                            "${doctorLiveConsultationsMeetingModel!.data!.consultation_date}",
                      ),
                      SizedBox(height: height * 0.01),
                      CommonDetailText(
                        width: width,
                        titleText: "Duration:",
                        descriptionText:
                            "${doctorLiveConsultationsMeetingModel!.data!.duration_minutes} Minutes",
                      ),
                      SizedBox(height: height * 0.03),
                      Center(
                        child: doctorLiveConsultationsMeetingModel!.data!.meta! == "N/A"
                            ? ElevatedButton.icon(
                                icon: const Icon(
                                  Icons.videocam_rounded,
                                  color: ColorConst.whiteColor,
                                ),
                                style: ElevatedButton.styleFrom(
                                  splashFactory: NoSplash.splashFactory,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  elevation: 0,
                                  disabledBackgroundColor: ColorConst.blueColor.withOpacity(0.5),
                                  fixedSize: Size(width / 2, 50),
                                ),
                                onPressed: null,
                                onLongPress: null,
                                label: Text(
                                  "Start Now",
                                  textAlign: TextAlign.center,
                                  style: TextStyleConst.mediumTextStyle(
                                    ColorConst.whiteColor,
                                    width * 0.05,
                                  ),
                                ),
                              )
                            : CommonButton(
                                isIcon: true,
                                width: width / 2,
                                height: 50,
                                text: "Start Now",
                                color: ColorConst.blueColor,
                                onTap: () {
                                  launchConsultationURL(doctorLiveConsultationsMeetingModel!.data!.meta!);
                                },
                                textStyleConst: TextStyleConst.mediumTextStyle(
                                  ColorConst.whiteColor,
                                  width * 0.05,
                                ),
                              ),
                      ),
                      SizedBox(height: height * 0.02),
                    ],
                  ),
                ),
              );
            },
          );
        }
      })
      ..onError((DioError error, stackTrace) {
        Get.back();
        gotMeetingData.value = true;
        CheckSocketException.checkSocketException(error);
        return DoctorLiveConsultationsMeetingModel();
      });
  }
}
