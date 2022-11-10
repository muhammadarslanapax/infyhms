import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infyhms_flutter/component/common_app_bar.dart';
import 'package:infyhms_flutter/component/common_detail_text.dart';
import 'package:infyhms_flutter/constant/color_const.dart';
import 'package:infyhms_flutter/utils/string_utils.dart';

class PrescriptionsDetailScreen extends StatelessWidget {
  final String? doctorName;
  final String? foodAllergies;
  final String? tendencyBleed;
  final String? heartDisease;
  final String? highBloodPressure;
  final String? diabetes;
  final String? surgery;
  final String? accident;
  final String? others;
  final String? medicalHistory;
  final String? currentMedication;
  final String? femalePregnancy;
  final String? breastFeeding;
  final String? healthInsurance;
  final String? lowIncome;
  final String? reference;

  const PrescriptionsDetailScreen({
    Key? key,
    required this.diabetes,
    required this.breastFeeding,
    required this.femalePregnancy,
    required this.others,
    required this.accident,
    required this.currentMedication,
    required this.doctorName,
    required this.foodAllergies,
    required this.healthInsurance,
    required this.heartDisease,
    required this.highBloodPressure,
    required this.lowIncome,
    required this.medicalHistory,
    required this.reference,
    required this.surgery,
    required this.tendencyBleed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
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
        body: Padding(
          padding: const EdgeInsets.only(right: 15, left: 15, top: 20),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                CommonDetailText(
                  width: width,
                  titleText: StringUtils.doctor,
                  descriptionText: doctorName!,
                ),
                SizedBox(height: height * 0.015),
                CommonDetailText(
                  width: width,
                  titleText: StringUtils.foodAllergies,
                  descriptionText: foodAllergies!,
                ),
                SizedBox(height: height * 0.015),
                CommonDetailText(
                  width: width,
                  titleText: StringUtils.tendencyBleed,
                  descriptionText: tendencyBleed!,
                ),
                SizedBox(height: height * 0.015),
                CommonDetailText(
                  width: width,
                  titleText: StringUtils.heartDisease,
                  descriptionText: heartDisease!,
                ),
                SizedBox(height: height * 0.015),
                CommonDetailText(
                  width: width,
                  titleText: StringUtils.highBloodPressure,
                  descriptionText: highBloodPressure!,
                ),
                SizedBox(height: height * 0.015),
                CommonDetailText(
                  width: width,
                  titleText: StringUtils.diabetes,
                  descriptionText: diabetes!,
                ),
                SizedBox(height: height * 0.015),
                CommonDetailText(
                  width: width,
                  titleText: StringUtils.surgery,
                  descriptionText: surgery!,
                ),
                SizedBox(height: height * 0.015),
                CommonDetailText(
                  width: width,
                  titleText: StringUtils.accident,
                  descriptionText: accident!,
                ),
                SizedBox(height: height * 0.015),
                CommonDetailText(
                  width: width,
                  titleText: StringUtils.others,
                  descriptionText: others!,
                ),
                SizedBox(height: height * 0.015),
                CommonDetailText(
                  width: width,
                  titleText: StringUtils.medicalHistory,
                  descriptionText: medicalHistory!,
                ),
                SizedBox(height: height * 0.015),
                CommonDetailText(
                  width: width,
                  titleText: StringUtils.currentMedication,
                  descriptionText: currentMedication!,
                ),
                SizedBox(height: height * 0.015),
                CommonDetailText(
                  width: width,
                  titleText: StringUtils.femalePregnancy,
                  descriptionText: femalePregnancy!,
                ),
                SizedBox(height: height * 0.015),
                CommonDetailText(
                  width: width,
                  titleText: StringUtils.breastFeeding,
                  descriptionText: breastFeeding!,
                ),
                SizedBox(height: height * 0.015),
                CommonDetailText(
                  width: width,
                  titleText: StringUtils.healthInsurance,
                  descriptionText: healthInsurance!,
                ),
                SizedBox(height: height * 0.015),
                CommonDetailText(
                  width: width,
                  titleText: StringUtils.lowIncome,
                  descriptionText: lowIncome!,
                ),
                SizedBox(height: height * 0.015),
                CommonDetailText(
                  width: width,
                  titleText: StringUtils.reference,
                  descriptionText: reference!,
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
