import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infyhms_flutter/component/common_button.dart';
import 'package:infyhms_flutter/component/common_detail_text.dart';
import 'package:infyhms_flutter/constant/color_const.dart';
import 'package:infyhms_flutter/constant/text_style_const.dart';
import 'package:infyhms_flutter/controller/live_consultancy/live_consultations_controller.dart';
import 'package:infyhms_flutter/screens/consultancy/live_consultations_detail_screen.dart';
import 'package:infyhms_flutter/utils/image_utils.dart';
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
              return !liveConsultationsController.gotConsultationData.value
                  ? const Center(child: CircularProgressIndicator(color: ColorConst.primaryColor))
                  : ListView.builder(
                      itemCount: liveConsultationsController.liveConsultationFilter.value?.data?.length ?? 0,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return ListTile(
                          onTap: () {
                            liveConsultationsController
                                .getDetailsOfConsultation(liveConsultationsController.liveConsultationFilter.value?.data?[index].id ?? 0);

                            Get.to(() => LiveConsultationsDetailScreen(liveConsultationsController: liveConsultationsController),
                                transition: Transition.rightToLeft);
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
                                    liveConsultationsController.liveConsultationFilter.value?.data?[index].doctor_image?.replaceAll(" ", "") ?? ""),
                              ),
                            ),
                          ),
                          trailing: GestureDetector(
                            onTap: () {
                              liveConsultationsController
                                  .getDetailsOfConsultation(liveConsultationsController.liveConsultationFilter.value?.data?[index].id ?? 0);
                              showModalBottomSheet(
                                shape: const OutlineInputBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(50),
                                    topRight: Radius.circular(50),
                                  ),
                                ),
                                context: context,
                                builder: (context) {
                                  return Container(
                                    margin: const EdgeInsets.only(right: 25, top: 30, left: 25),
                                    height: height * 0.4,
                                    child: Obx(() {
                                      return !liveConsultationsController.gotDetailsOfConsultation.value
                                          ? const Center(child: CircularProgressIndicator(color: ColorConst.primaryColor))
                                          : SingleChildScrollView(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    liveConsultationsController.liveConsultationDetailsModel.value?.data?.consultation_title ?? "N/A",
                                                    style: TextStyleConst.boldTextStyle(
                                                      ColorConst.blackColor,
                                                      width * 0.045,
                                                    ),
                                                  ),
                                                  SizedBox(height: height * 0.01),
                                                  statusText(
                                                      liveConsultationsController.liveConsultationDetailsModel.value?.data?.status ?? "N/A", width),
                                                  SizedBox(height: height * 0.02),
                                                  CommonDetailText(
                                                    width: width,
                                                    titleText: "Host Video:",
                                                    descriptionText:
                                                        liveConsultationsController.liveConsultationDetailsModel.value?.data?.host_video ?? "N/A",
                                                  ),
                                                  SizedBox(height: height * 0.01),
                                                  CommonDetailText(
                                                    width: width,
                                                    titleText: "Consultation Date:",
                                                    descriptionText:
                                                        "${liveConsultationsController.liveConsultationDetailsModel.value?.data?.consultation_date ?? "N/A"}, ${liveConsultationsController.liveConsultationDetailsModel.value?.data?.consultation_time ?? "N/A"}",
                                                  ),
                                                  SizedBox(height: height * 0.01),
                                                  CommonDetailText(
                                                    width: width,
                                                    titleText: "Duration:",
                                                    descriptionText:
                                                        "${liveConsultationsController.liveConsultationDetailsModel.value?.data?.duration ?? "N/A"} minutes",
                                                  ),
                                                  SizedBox(height: height * 0.03),
                                                  Center(
                                                    child: CommonButton(
                                                      isIcon: true,
                                                      width: width / 2,
                                                      height: 50,
                                                      text: "Join now",
                                                      color: ColorConst.blueColor,
                                                      onTap: () {
                                                        liveConsultationsController.launchConsultationURL(context,
                                                            liveConsultationsController.liveConsultationDetailsModel.value?.data?.join_url ?? "N/A");
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
                                            );
                                    }),
                                  );
                                },
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
                            liveConsultationsController.liveConsultationFilter.value?.data?[index].consultation_title ?? "",
                            style: TextStyleConst.mediumTextStyle(
                              ColorConst.blackColor,
                              width * 0.045,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: height * 0.002),
                              statusText(liveConsultationsController.liveConsultationFilter.value?.data?[index].status ?? "", width),
                              SizedBox(height: height * 0.004),
                              Text(
                                "${liveConsultationsController.liveConsultationFilter.value?.data?[index].consultation_time ?? ""} - ${liveConsultationsController.liveConsultationFilter.value?.data?[index].consultation_date ?? ""}",
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
            }),
          ),
        ],
      ),
    );
  }
}
