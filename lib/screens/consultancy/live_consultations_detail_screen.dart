import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infyhms_flutter/component/common_app_bar.dart';
import 'package:infyhms_flutter/component/common_detail_text.dart';
import 'package:infyhms_flutter/constant/color_const.dart';
import 'package:infyhms_flutter/utils/string_utils.dart';

class LiveConsultationsDetailScreen extends StatelessWidget {
  const LiveConsultationsDetailScreen({Key? key}) : super(key: key);

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
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(height: height * 0.02),
                CommonDetailText(
                  width: width,
                  titleText: StringUtils.consultationTitle,
                  descriptionText: "Regular Checkup",
                ),
                SizedBox(height: height * 0.015),
                CommonDetailText(
                  width: width,
                  titleText: StringUtils.consultationDate,
                  descriptionText: "14th Jun, 2022 - 11:45 AM",
                ),
                SizedBox(height: height * 0.015),
                CommonDetailText(
                  width: width,
                  titleText: StringUtils.durationMinute,
                  descriptionText: "120",
                ),
                SizedBox(height: height * 0.015),
                CommonDetailText(
                  width: width,
                  titleText: StringUtils.doctorName,
                  descriptionText: "Jenil Shah",
                ),
                SizedBox(height: height * 0.015),
                CommonDetailText(
                  width: width,
                  titleText: StringUtils.type,
                  descriptionText: "IPD",
                ),
                SizedBox(height: height * 0.015),
                CommonDetailText(
                  width: width,
                  titleText: StringUtils.typeNumber,
                  descriptionText: "NDPL1J6N",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
