import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infyhms_flutter/component/common_app_bar.dart';
import 'package:infyhms_flutter/component/common_button.dart';
import 'package:infyhms_flutter/component/common_detail_text.dart';
import 'package:infyhms_flutter/component/common_text.dart';
import 'package:infyhms_flutter/constant/color_const.dart';
import 'package:infyhms_flutter/constant/text_style_const.dart';
import 'package:infyhms_flutter/controller/patient/prescription_controller/prescription_details_controller.dart';
import 'package:infyhms_flutter/utils/image_utils.dart';
import 'package:infyhms_flutter/utils/string_utils.dart';

class PrescriptionsDetailScreen extends StatelessWidget {
  PrescriptionsDetailScreen({super.key});
  final PrescriptionDetailsController prescriptionDetailsController = Get.put(PrescriptionDetailsController());

  @override
  Widget build(BuildContext context) {

    var id = ModalRoute.of(context)!.settings.arguments as int;
    prescriptionDetailsController.getPrescriptionDetails(id);

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: CommonAppBar(
            title: "Prescriptions Details",
            leadOnTap: () {
              Get.back();
            },
            leadIcon: const Icon(
              Icons.arrow_back_rounded,
              color: ColorConst.blackColor,
            ),
          ),
          body: Obx(
                () {
              return prescriptionDetailsController.isGotDetails.value != false
                  ? Padding(
                padding: const EdgeInsets.only(right: 15, left: 15),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: height * 0.03),
                      Row(
                        children: [
                          Container(
                            height: 60,
                            width: 60,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: AssetImage(
                                  ImageUtils.splashLogo
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: width * 0.04),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                prescriptionDetailsController.prescriptionDetailsModel?.data?.doctor_name ?? "N/A",
                                style: TextStyleConst.boldTextStyle(
                                  ColorConst.blackColor,
                                  width * 0.05,
                                ),
                              ),
                              Text(
                                prescriptionDetailsController.prescriptionDetailsModel?.data?.specialist ?? "N/A",
                                style: TextStyleConst.mediumTextStyle(ColorConst.hintGreyColor, width * 0.04),
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(height: height * 0.02),
                      Divider(
                        thickness: 1.5,
                        color: ColorConst.greyShadowColor,
                      ),
                      SizedBox(height: height * 0.01),
                      CommonText(
                        width: width,
                        text: StringUtils.overview,
                      ),
                      SizedBox(height: height * 0.025),
                      CommonDetailText(
                        width: width,
                        titleText: "Problem:",
                        descriptionText: prescriptionDetailsController.prescriptionDetailsModel?.data?.problem ?? "N/A",
                      ),
                      SizedBox(height: height * 0.015),
                      CommonDetailText(
                        width: width,
                        titleText: "Test:",
                        descriptionText: prescriptionDetailsController.prescriptionDetailsModel?.data?.test ?? "N/A",
                      ),
                      SizedBox(height: height * 0.015),
                      CommonDetailText(
                        width: width,
                        titleText: "Advice:",
                        descriptionText: prescriptionDetailsController.prescriptionDetailsModel?.data?.advice ?? "N/A",
                      ),
                      SizedBox(
                        height: prescriptionDetailsController.prescriptionDetailsModel!.data!.medicine!.isEmpty ? height * 0.04 : height * 0.02,
                      ),
                      prescriptionDetailsController.prescriptionDetailsModel!.data!.medicine!.isEmpty
                          ? Center(
                        child: CommonText(
                          width: width,
                          text: "No Medicine Available",
                          color: ColorConst.redColor,
                        ),
                      )
                          : Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: ColorConst.bgGreyColor,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 15, right: 15, left: 15),
                              child: Text(
                                StringUtils.rx,
                                style: TextStyleConst.mediumTextStyle(
                                  ColorConst.blackColor,
                                  width * 0.04,
                                ),
                              ),
                            ),
                            SizedBox(height: height * 0.01),
                            const Padding(
                              padding: EdgeInsets.only(right: 15, left: 15),
                              child: Divider(
                                color: ColorConst.dividerColor,
                                thickness: 1.5,
                              ),
                            ),
                            SizedBox(height: height * 0.01),
                            Padding(
                              padding: const EdgeInsets.only(right: 15, left: 15),
                              child: Column(
                                children: List.generate(
                                    prescriptionDetailsController.prescriptionDetailsModel?.data?.medicine?.length ?? 0, (index) {
                                  return Padding(
                                    padding: EdgeInsets.only(bottom: height * 0.01),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              prescriptionDetailsController.prescriptionDetailsModel?.data?.medicine?[index].name ??
                                                  "N/A",
                                              style: TextStyleConst.mediumTextStyle(
                                                ColorConst.blackColor,
                                                width * 0.045,
                                              ),
                                            ),
                                            SizedBox(height: height * 0.003),
                                            SizedBox(
                                              width: width * 0.60,
                                              child: Text(
                                                "${prescriptionDetailsController.prescriptionDetailsModel?.data?.medicine?[index].dosage ?? "N/A"}(${prescriptionDetailsController.prescriptionDetailsModel?.data?.medicine?[index].time ?? "N/A"})",
                                                style: TextStyleConst.mediumTextStyle(
                                                  ColorConst.hintGreyColor,
                                                  width * 0.04,
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: height * 0.01),
                                          ],
                                        ),
                                        Text(
                                          prescriptionDetailsController.prescriptionDetailsModel?.data?.medicine![index].days ?? "N/A",
                                          style: TextStyleConst.mediumTextStyle(
                                            ColorConst.blackColor,
                                            width * 0.045,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: height * 0.04),
                      Center(
                        child: Obx(() {
                          return prescriptionDetailsController.isDownloading.value == true
                              ? const Center(child: CircularProgressIndicator(color: ColorConst.primaryColor))
                              : CommonButton(
                            width: width / 1.45,
                            height: 50,
                            text: StringUtils.downloadPrescription,
                            color: ColorConst.blueColor,
                            onTap: () {
                              prescriptionDetailsController
                                  .downloadPDF(prescriptionDetailsController.prescriptionDetailsModel?.data?.download_prescription ?? "");
                            },
                            textStyleConst: TextStyleConst.mediumTextStyle(ColorConst.whiteColor, width * 0.05),
                          );
                        }),
                      ),
                      SizedBox(height: height * 0.02),
                    ],
                  ),
                ),
              )
                  : const Center(child: CircularProgressIndicator());
            },
          )),
    );
  }
}
