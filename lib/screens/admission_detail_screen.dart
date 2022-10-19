import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infyhms_flutter/component/common_app_bar.dart';
import 'package:infyhms_flutter/component/common_detail_text.dart';
import 'package:infyhms_flutter/component/common_text.dart';
import 'package:infyhms_flutter/constant/color_const.dart';

class AdmissionDetailScreen extends StatelessWidget {
  const AdmissionDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: CommonAppBar(
          title: "Admission Details",
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
                CommonText(width: width, text: "Admission Details"),
                SizedBox(height: height * 0.02),
                CommonDetailText(
                  width: width,
                  titleText: "Admission Id:",
                  descriptionText: "ED2WRTUW",
                ),
                SizedBox(height: height * 0.015),
                CommonDetailText(
                  width: width,
                  titleText: "Doctor:",
                  descriptionText: "Brendan Hatfield",
                ),
                SizedBox(height: height * 0.015),
                CommonDetailText(
                  width: width,
                  titleText: "Admission Date:",
                  descriptionText: "14th Jun, 2022 - 12:00 PM",
                ),
                SizedBox(height: height * 0.015),
                CommonDetailText(
                  width: width,
                  titleText: "Discharge Date:",
                  descriptionText: "17th Jun, 2022 - 9:06 AM",
                ),
                SizedBox(height: height * 0.015),
                CommonDetailText(
                  width: width,
                  titleText: "Bed:",
                  descriptionText: "N/A",
                ),
                SizedBox(height: height * 0.015),
                CommonDetailText(
                  width: width,
                  titleText: "Guardian Name:",
                  descriptionText: "N/A",
                ),
                SizedBox(height: height * 0.015),
                CommonDetailText(
                  width: width,
                  titleText: "Guardian Relation:",
                  descriptionText: "N/A",
                ),
                SizedBox(height: height * 0.015),
                CommonDetailText(
                  width: width,
                  titleText: "Guardian Contact:",
                  descriptionText: "N/A",
                ),
                SizedBox(height: height * 0.015),
                CommonDetailText(
                  width: width,
                  titleText: "Guardian Address:",
                  descriptionText: "N/A",
                ),
                SizedBox(height: height * 0.015),
                CommonDetailText(
                  width: width,
                  titleText: "Package Name:",
                  descriptionText: "4 months ago",
                ),
                SizedBox(height: height * 0.02),
                CommonText(width: width, text: "Insurance Details"),
                SizedBox(height: height * 0.02),
                CommonDetailText(
                  width: width,
                  titleText: "Package Name:",
                  descriptionText: "All in One Package",
                ),
                SizedBox(height: height * 0.015),
                CommonDetailText(
                  width: width,
                  titleText: "Insurance Name:",
                  descriptionText: "Accidental Insurance",
                ),
                SizedBox(height: height * 0.015),
                CommonDetailText(
                  width: width,
                  titleText: "Agent Name:",
                  descriptionText: "sddfdvdfd",
                ),
                SizedBox(height: height * 0.015),
                CommonDetailText(
                  width: width,
                  titleText: "Policy No:",
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
