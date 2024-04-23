import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infyhms_flutter/component/common_app_bar.dart';
import 'package:infyhms_flutter/component/common_detail_text.dart';
import 'package:infyhms_flutter/constant/color_const.dart';
import 'package:infyhms_flutter/controller/doctor/bed_assign_controller/bed_details_controller.dart';

class BedDetails extends StatelessWidget {
  const BedDetails({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    BedDetailsController bedDetailsController = Get.put(BedDetailsController());
    return SafeArea(
      child: Scaffold(
        appBar: CommonAppBar(
          title: "Bed Details",
          leadOnTap: () {
            Get.back();
          },
          leadIcon: const Icon(
            Icons.arrow_back_rounded,
            color: ColorConst.blackColor,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Obx(() {
            return bedDetailsController.isBedDetailsApiCalled.value == false
                ? const Center(child: CircularProgressIndicator())
                : bedDetailsController.bedDetailsModel?.data == null
                    ? const Center(child: Text("No Data Found!"))
                    : Column(
                        children: [
                          CommonDetailText(
                            width: width,
                            titleText: "Bed :",
                            descriptionText: bedDetailsController.bedDetailsModel?.data?.bed ?? "",
                          ),
                          SizedBox(height: height * 0.015),
                          CommonDetailText(
                            width: width,
                            titleText: "Bed Type :",
                            descriptionText: bedDetailsController.bedDetailsModel?.data?.bed_type ?? "",
                          ),
                          SizedBox(height: height * 0.015),
                          CommonDetailText(
                            width: width,
                            titleText: "Bed ID :",
                            descriptionText: bedDetailsController.bedDetailsModel?.data?.bed_id ?? "",
                          ),
                          SizedBox(height: height * 0.015),
                          CommonDetailText(
                            width: width,
                            titleText: "Charge :",
                            descriptionText: "\$ ${bedDetailsController.bedDetailsModel?.data?.charge ?? ""}",
                          ),
                          SizedBox(height: height * 0.015),
                          CommonDetailText(
                            width: width,
                            titleText: "Available :",
                            descriptionText: bedDetailsController.bedDetailsModel?.data?.is_available == 0 ? "No" : "Yes",
                          ),
                          SizedBox(height: height * 0.015),
                          CommonDetailText(
                            width: width,
                            titleText: "Created on :",
                            descriptionText: bedDetailsController.bedDetailsModel?.data?.created_on ?? "",
                          ),
                          SizedBox(height: height * 0.015),
                          CommonDetailText(
                            width: width,
                            titleText: "Description :",
                            descriptionText: bedDetailsController.bedDetailsModel?.data?.description ?? "N/A",
                          ),
                          SizedBox(height: height * 0.015),
                        ],
                      );
          }),
        ),
      ),
    );
  }
}
