import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infyhms_flutter/component/common_app_bar.dart';
import 'package:infyhms_flutter/component/common_button.dart';
import 'package:infyhms_flutter/component/common_detail_text.dart';
import 'package:infyhms_flutter/constant/color_const.dart';
import 'package:infyhms_flutter/constant/text_style_const.dart';
import 'package:infyhms_flutter/utils/string_utils.dart';

class DiagnosisTestDetailScreen extends StatelessWidget {
  const DiagnosisTestDetailScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: CommonAppBar(
          title: StringUtils.diagnosisTests,
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
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(height: height * 0.02),
                CommonDetailText(
                  width: width,
                  titleText: StringUtils.doctor,
                  descriptionText: "Chintan Patel",
                ),
                SizedBox(height: height * 0.015),
                CommonDetailText(
                  width: width,
                  titleText: StringUtils.diagnosisCategory,
                  descriptionText: "Chintan Patel",
                ),
                SizedBox(height: height * 0.015),
                CommonDetailText(
                  width: width,
                  titleText: StringUtils.reportNumber,
                  descriptionText: "K2TUWFVE",
                ),
                SizedBox(height: height * 0.015),
                CommonDetailText(
                  width: width,
                  titleText: StringUtils.averageGlucose,
                  descriptionText: "N/A",
                ),
                SizedBox(height: height * 0.015),
                CommonDetailText(
                  width: width,
                  titleText: StringUtils.fastingBloodSugar,
                  descriptionText: "N/A",
                ),
                SizedBox(height: height * 0.015),
                CommonDetailText(
                  width: width,
                  titleText: StringUtils.urineSugar,
                  descriptionText: "N/A",
                ),
                SizedBox(height: height * 0.015),
                CommonDetailText(
                  width: width,
                  titleText: StringUtils.bloodPressure,
                  descriptionText: "N/A",
                ),
                SizedBox(height: height * 0.015),
                CommonDetailText(
                  width: width,
                  titleText: StringUtils.diabetes,
                  descriptionText: "N/A",
                ),
                SizedBox(height: height * 0.015),
                CommonDetailText(
                  width: width,
                  titleText: StringUtils.cholesterol,
                  descriptionText: "N/A",
                ),
                SizedBox(height: height * 0.015),
                CommonDetailText(
                  width: width,
                  titleText: StringUtils.createOn,
                  descriptionText: "3 months ago",
                ),
                SizedBox(height: height * 0.04),
                Center(
                  child: CommonButton(
                    width: width / 1.3,
                    height: 50,
                    text: StringUtils.downloadDiagnosisTest,
                    color: ColorConst.blueColor,
                    onTap: () {},
                    textStyleConst: TextStyleConst.mediumTextStyle(
                      ColorConst.whiteColor,
                      width * 0.05,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
