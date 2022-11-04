import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infyhms_flutter/component/common_app_bar.dart';
import 'package:infyhms_flutter/component/common_detail_text.dart';
import 'package:infyhms_flutter/constant/color_const.dart';
import 'package:infyhms_flutter/utils/string_utils.dart';

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
                  titleText: StringUtils.doctor,
                  descriptionText: "Ann Joseph",
                ),
                SizedBox(height: height * 0.015),
                CommonDetailText(
                  width: width,
                  titleText: StringUtils.foodAllergies,
                  descriptionText: "No",
                ),
                SizedBox(height: height * 0.015),
                CommonDetailText(
                  width: width,
                  titleText: StringUtils.tendencyBleed,
                  descriptionText: "No",
                ),
                SizedBox(height: height * 0.015),
                CommonDetailText(
                  width: width,
                  titleText: StringUtils.heartDisease,
                  descriptionText: "Yes",
                ),
                SizedBox(height: height * 0.015),
                CommonDetailText(
                  width: width,
                  titleText: StringUtils.highBloodPressure,
                  descriptionText: "Yes",
                ),
                SizedBox(height: height * 0.015),
                CommonDetailText(
                  width: width,
                  titleText: StringUtils.diabetes,
                  descriptionText: "No",
                ),
                SizedBox(height: height * 0.015),
                CommonDetailText(
                  width: width,
                  titleText: StringUtils.surgery,
                  descriptionText: "No",
                ),
                SizedBox(height: height * 0.015),
                CommonDetailText(
                  width: width,
                  titleText: StringUtils.accident,
                  descriptionText: "No",
                ),
                SizedBox(height: height * 0.015),
                CommonDetailText(
                  width: width,
                  titleText: StringUtils.others,
                  descriptionText: "No",
                ),
                SizedBox(height: height * 0.015),
                CommonDetailText(
                  width: width,
                  titleText: StringUtils.medicalHistory,
                  descriptionText: "Diabetes",
                ),
                SizedBox(height: height * 0.015),
                CommonDetailText(
                  width: width,
                  titleText: StringUtils.currentMedication,
                  descriptionText: "Dolo-650",
                ),
                SizedBox(height: height * 0.015),
                CommonDetailText(
                  width: width,
                  titleText: StringUtils.femalePregnancy,
                  descriptionText: "No",
                ),
                SizedBox(height: height * 0.015),
                CommonDetailText(
                  width: width,
                  titleText: StringUtils.breastFeeding,
                  descriptionText: "No",
                ),
                SizedBox(height: height * 0.015),
                CommonDetailText(
                  width: width,
                  titleText: StringUtils.healthInsurance,
                  descriptionText: "N/A ",
                ),
                SizedBox(height: height * 0.015),
                CommonDetailText(
                  width: width,
                  titleText: StringUtils.lowIncome,
                  descriptionText: "Yes",
                ),
                SizedBox(height: height * 0.015),
                CommonDetailText(
                  width: width,
                  titleText: StringUtils.reference,
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
