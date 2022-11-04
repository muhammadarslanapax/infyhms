import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infyhms_flutter/component/common_app_bar.dart';
import 'package:infyhms_flutter/component/common_detail_text.dart';
import 'package:infyhms_flutter/component/common_text.dart';
import 'package:infyhms_flutter/constant/color_const.dart';
import 'package:infyhms_flutter/utils/string_utils.dart';

class AdmissionDetailScreen extends StatelessWidget {
  const AdmissionDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: CommonAppBar(
          title: StringUtils.admissionDetails,
          leadOnTap: () {
            Get.back();
          },
          leadIcon: const Icon(
            Icons.arrow_back_rounded,
            color: ColorConst.blackColor,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonText(width: width, text: StringUtils.admissionDetails),
                SizedBox(height: height * 0.02),
                CommonDetailText(
                  width: width,
                  titleText: StringUtils.admissionId,
                  descriptionText: "ED2WRTUW",
                ),
                SizedBox(height: height * 0.015),
                CommonDetailText(
                  width: width,
                  titleText: StringUtils.doctor,
                  descriptionText: "Brendan Hatfield",
                ),
                SizedBox(height: height * 0.015),
                CommonDetailText(
                  width: width,
                  titleText: StringUtils.admissionDate,
                  descriptionText: "14th Jun, 2022 - 12:00 PM",
                ),
                SizedBox(height: height * 0.015),
                CommonDetailText(
                  width: width,
                  titleText: StringUtils.dischargeDate,
                  descriptionText: "17th Jun, 2022 - 9:06 AM",
                ),
                SizedBox(height: height * 0.015),
                CommonDetailText(
                  width: width,
                  titleText: StringUtils.bed,
                  descriptionText: "N/A",
                ),
                SizedBox(height: height * 0.015),
                CommonDetailText(
                  width: width,
                  titleText: StringUtils.guardianName,
                  descriptionText: "N/A",
                ),
                SizedBox(height: height * 0.015),
                CommonDetailText(
                  width: width,
                  titleText: StringUtils.guardianRelation,
                  descriptionText: "N/A",
                ),
                SizedBox(height: height * 0.015),
                CommonDetailText(
                  width: width,
                  titleText: StringUtils.guardianContact,
                  descriptionText: "N/A",
                ),
                SizedBox(height: height * 0.015),
                CommonDetailText(
                  width: width,
                  titleText: StringUtils.guardianAddress,
                  descriptionText: "N/A",
                ),
                SizedBox(height: height * 0.015),
                CommonDetailText(
                  width: width,
                  titleText: StringUtils.createOn,
                  descriptionText: "4 months ago",
                ),
                SizedBox(height: height * 0.02),
                CommonText(width: width, text: StringUtils.insuranceDetails),
                SizedBox(height: height * 0.02),
                CommonDetailText(
                  width: width,
                  titleText: StringUtils.packageName,
                  descriptionText: "All in One Package",
                ),
                SizedBox(height: height * 0.015),
                CommonDetailText(
                  width: width,
                  titleText: StringUtils.insuranceName,
                  descriptionText: "Accidental Insurance",
                ),
                SizedBox(height: height * 0.015),
                CommonDetailText(
                  width: width,
                  titleText: StringUtils.agentName,
                  descriptionText: "sddfdvdfd",
                ),
                SizedBox(height: height * 0.015),
                CommonDetailText(
                  width: width,
                  titleText: StringUtils.policyNo,
                  descriptionText: "N/A",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
