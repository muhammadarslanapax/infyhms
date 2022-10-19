import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infyhms_flutter/component/common_app_bar.dart';
import 'package:infyhms_flutter/component/common_detail_text.dart';
import 'package:infyhms_flutter/constant/color_const.dart';

class PrescriptionsDetailScreen extends StatelessWidget {
  const PrescriptionsDetailScreen({Key? key}) : super(key: key);

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
          padding: const EdgeInsets.only(right: 15, left: 15, top: 20),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                CommonDetailText(
                  width: width,
                  titleText: "Doctor:",
                  descriptionText: "Ann Joseph",
                ),
                SizedBox(height: height * 0.015),
                CommonDetailText(
                  width: width,
                  titleText: "Food Allergies::",
                  descriptionText: "No",
                ),
                SizedBox(height: height * 0.015),
                CommonDetailText(
                  width: width,
                  titleText: "Tendency Bleed:",
                  descriptionText: "No",
                ),
                SizedBox(height: height * 0.015),
                CommonDetailText(
                  width: width,
                  titleText: "Heart Disease:",
                  descriptionText: "Yes",
                ),
                SizedBox(height: height * 0.015),
                CommonDetailText(
                  width: width,
                  titleText: "High Blood Pressure:",
                  descriptionText: "Yes",
                ),
                SizedBox(height: height * 0.015),
                CommonDetailText(
                  width: width,
                  titleText: "Diabetic:",
                  descriptionText: "No",
                ),
                SizedBox(height: height * 0.015),
                CommonDetailText(
                  width: width,
                  titleText: "Surgery:",
                  descriptionText: "No",
                ),
                SizedBox(height: height * 0.015),
                CommonDetailText(
                  width: width,
                  titleText: "Accident:",
                  descriptionText: "No",
                ),
                SizedBox(height: height * 0.015),
                CommonDetailText(
                  width: width,
                  titleText: "Others:",
                  descriptionText: "No",
                ),
                SizedBox(height: height * 0.015),
                CommonDetailText(
                  width: width,
                  titleText: "Medical History:",
                  descriptionText: "Diabetes",
                ),
                SizedBox(height: height * 0.015),
                CommonDetailText(
                  width: width,
                  titleText: "Current Medication:",
                  descriptionText: "Dolo-650",
                ),
                SizedBox(height: height * 0.015),
                CommonDetailText(
                  width: width,
                  titleText: "Female Pregnancy:",
                  descriptionText: "No",
                ),
                SizedBox(height: height * 0.015),
                CommonDetailText(
                  width: width,
                  titleText: "Breast Feeding:",
                  descriptionText: "No",
                ),
                SizedBox(height: height * 0.015),
                CommonDetailText(
                  width: width,
                  titleText: "Health Insurance:",
                  descriptionText: "N/A ",
                ),
                SizedBox(height: height * 0.015),
                CommonDetailText(
                  width: width,
                  titleText: "Low Income:",
                  descriptionText: "Yes",
                ),
                SizedBox(height: height * 0.015),
                CommonDetailText(
                  width: width,
                  titleText: "Reference:",
                  descriptionText: "None",
                ),
                SizedBox(height: height * 0.015),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
