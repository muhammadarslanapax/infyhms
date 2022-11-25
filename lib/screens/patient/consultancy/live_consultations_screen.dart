import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infyhms_flutter/constant/color_const.dart';
import 'package:infyhms_flutter/constant/text_style_const.dart';
import 'package:infyhms_flutter/controller/patient/live_consultancy_controller/live_consultations_controller.dart';
import 'package:infyhms_flutter/screens/patient/consultancy/live_consultations_detail_screen.dart';
import 'package:infyhms_flutter/utils/image_utils.dart';
import 'package:infyhms_flutter/utils/preference_utils.dart';
import 'package:infyhms_flutter/widget/live_consul_status.dart';

class LiveConsultationsScreen extends StatelessWidget {
  LiveConsultationsScreen({Key? key}) : super(key: key);
  final LiveConsultationsController liveConsultationsController = Get.put(LiveConsultationsController());

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      color: ColorConst.whiteColor,
      child: Column(
        children: [
          Container(
            height: 70,
            margin: EdgeInsets.only(top: height * 0.01),
            width: double.infinity,
            child: ListView.builder(
              itemCount: liveConsultationsController.consultationsStatus.length,
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Center(child: Obx(() {
                  return GestureDetector(
                    onTap: () {
                      liveConsultationsController.changeIndex(index);
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: width * 0.03, right: index == 3 ? 10 : 0),
                      height: 45,
                      decoration: index == liveConsultationsController.currentIndex.value
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
                            liveConsultationsController.consultationsStatus[index],
                            style: TextStyleConst.mediumTextStyle(
                              index == liveConsultationsController.currentIndex.value ? ColorConst.whiteColor : ColorConst.hintGreyColor,
                              width * 0.04,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }));
              },
            ),
          ),
          Expanded(
            child: Obx(() {
              if (PreferenceUtils.getBoolValue("isDoctor")) {
                return !liveConsultationsController.gotConsultationData.value
                    ? const Center(child: CircularProgressIndicator(color: ColorConst.primaryColor))
                    : liveConsultationsController.doctorLiveConsultationsModel?.data?.isEmpty ?? true
                        ? Center(
                            child: Text(
                              "No consultations found",
                              style: TextStyleConst.mediumTextStyle(
                                ColorConst.blackColor,
                                width * 0.04,
                              ),
                            ),
                          )
                        : ListView.builder(
                            itemCount: liveConsultationsController.doctorLiveConsultationsModel?.data?.length ?? 0,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return ListTile(
                                onTap: () {
                                  Get.to(
                                    () => LiveConsultationsDetailScreen(),
                                    transition: Transition.rightToLeft,
                                    arguments: liveConsultationsController.doctorLiveConsultationsModel!.data![index].id,
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
                                      image: NetworkImage(
                                          liveConsultationsController.doctorLiveConsultationsModel?.data?[index].patient_image?.replaceAll(" ", "") ??
                                              ""),
                                    ),
                                  ),
                                ),
                                trailing: GestureDetector(
                                  onTap: () {
                                    liveConsultationsController.getDoctorLiveMeeting(
                                      liveConsultationsController.doctorLiveConsultationsModel!.data![index].id!,
                                      context,
                                      height,
                                      width,
                                    );
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(right: 10),
                                    width: 30,
                                    height: 30,
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(ImageUtils.videoIcon),
                                      ),
                                    ),
                                  ),
                                ),
                                title: Text(
                                  liveConsultationsController.doctorLiveConsultationsModel?.data?[index].consultation_title ?? "",
                                  style: TextStyleConst.mediumTextStyle(
                                    ColorConst.blackColor,
                                    width * 0.045,
                                  ),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: height * 0.002),
                                    statusText("${liveConsultationsController.doctorLiveConsultationsModel!.data![index].status}", width),
                                    SizedBox(height: height * 0.004),
                                    Text(
                                      "${liveConsultationsController.doctorLiveConsultationsModel?.data?[index].consultation_time ?? ""} - ${liveConsultationsController.doctorLiveConsultationsModel?.data?[index].consultation_date ?? ""}",
                                      style: TextStyleConst.mediumTextStyle(
                                        ColorConst.hintGreyColor,
                                        width * 0.036,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
              } else {
                print("object1");
                return !liveConsultationsController.gotConsultationData.value
                    ? const Center(child: CircularProgressIndicator(color: ColorConst.primaryColor))
                    : liveConsultationsController.liveConsultationFilter?.data?.isEmpty ?? true
                        ? Center(
                            child: Text(
                              "No consultations found",
                              style: TextStyleConst.mediumTextStyle(
                                ColorConst.blackColor,
                                width * 0.04,
                              ),
                            ),
                          )
                        : ListView.builder(
                            itemCount: liveConsultationsController.liveConsultationFilter?.data?.length ?? 0,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return ListTile(
                                onTap: () {
                                  Get.to(
                                    () => LiveConsultationsDetailScreen(),
                                    transition: Transition.rightToLeft,
                                    arguments: liveConsultationsController.liveConsultationFilter!.data![index].id,
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
                                      image: NetworkImage(
                                          liveConsultationsController.liveConsultationFilter?.data?[index].doctor_image?.replaceAll(" ", "") ?? ""),
                                    ),
                                  ),
                                ),
                                trailing: GestureDetector(
                                  onTap: () {
                                    liveConsultationsController.getLiveMeeting(
                                      liveConsultationsController.liveConsultationFilter!.data![index].id!,
                                      context,
                                      height,
                                      width,
                                    );
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(right: 10),
                                    width: 30,
                                    height: 30,
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(ImageUtils.videoIcon),
                                      ),
                                    ),
                                  ),
                                ),
                                title: Text(
                                  liveConsultationsController.liveConsultationFilter?.data?[index].consultation_title ?? "",
                                  style: TextStyleConst.mediumTextStyle(
                                    ColorConst.blackColor,
                                    width * 0.045,
                                  ),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: height * 0.002),
                                    statusText(liveConsultationsController.liveConsultationFilter?.data?[index].status ?? "", width),
                                    SizedBox(height: height * 0.004),
                                    Text(
                                      "${liveConsultationsController.liveConsultationFilter?.data?[index].consultation_time ?? ""} - ${liveConsultationsController.liveConsultationFilter?.data?[index].consultation_date ?? ""}",
                                      style: TextStyleConst.mediumTextStyle(
                                        ColorConst.hintGreyColor,
                                        width * 0.036,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
              }
            }),
          ),
        ],
      ),
    );
  }
}
