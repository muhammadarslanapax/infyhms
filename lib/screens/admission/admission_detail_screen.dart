import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infyhms_flutter/component/common_app_bar.dart';
import 'package:infyhms_flutter/component/common_detail_text.dart';
import 'package:infyhms_flutter/component/common_text.dart';
import 'package:infyhms_flutter/constant/color_const.dart';
import 'package:infyhms_flutter/utils/string_utils.dart';

class AdmissionDetailScreen extends StatelessWidget {
  final String? admissionId;
  final String? doctor;
  final String? admissionDate;
  final String? admissionTime;
  final String? dischargeDate;
  final String? dischargeTime;
  final String? bed;
  final String? guardianName;
  final String? guardianRelation;
  final String? guardianContact;
  final String? guardianAddress;
  final String? createOn;
  final String? packageName;
  final String? insuranceName;
  final String? agentName;
  final String? policyNo;
  const AdmissionDetailScreen({
    Key? key,
    required this.admissionDate,
    required this.dischargeTime,
    required this.admissionTime,
    required this.doctor,
    required this.createOn,
    required this.insuranceName,
    required this.packageName,
    required this.admissionId,
    required this.guardianContact,
    required this.guardianRelation,
    required this.agentName,
    required this.bed,
    required this.dischargeDate,
    required this.guardianAddress,
    required this.guardianName,
    required this.policyNo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConst.whiteColor,
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
                  descriptionText: admissionId!,
                ),
                SizedBox(height: height * 0.015),
                CommonDetailText(
                  width: width,
                  titleText: StringUtils.doctor,
                  descriptionText: doctor!,
                ),
                SizedBox(height: height * 0.015),
                CommonDetailText(
                  width: width,
                  titleText: StringUtils.admissionDate,
                  descriptionText: "${admissionDate!} - ${admissionTime!}",
                ),
                SizedBox(height: height * 0.015),
                CommonDetailText(
                  width: width,
                  titleText: StringUtils.dischargeDate,
                  descriptionText: "${dischargeDate!} - ${dischargeTime!}",
                ),
                SizedBox(height: height * 0.015),
                CommonDetailText(
                  width: width,
                  titleText: StringUtils.bed,
                  descriptionText: bed!,
                ),
                SizedBox(height: height * 0.015),
                CommonDetailText(
                  width: width,
                  titleText: StringUtils.guardianName,
                  descriptionText: guardianName!,
                ),
                SizedBox(height: height * 0.015),
                CommonDetailText(
                  width: width,
                  titleText: StringUtils.guardianRelation,
                  descriptionText: guardianRelation!,
                ),
                SizedBox(height: height * 0.015),
                CommonDetailText(
                  width: width,
                  titleText: StringUtils.guardianContact,
                  descriptionText: guardianContact!,
                ),
                SizedBox(height: height * 0.015),
                CommonDetailText(
                  width: width,
                  titleText: StringUtils.guardianAddress,
                  descriptionText: guardianAddress!,
                ),
                SizedBox(height: height * 0.015),
                CommonDetailText(
                  width: width,
                  titleText: StringUtils.createOn,
                  descriptionText: createOn!,
                ),
                SizedBox(height: height * 0.02),
                CommonText(width: width, text: StringUtils.insuranceDetails),
                SizedBox(height: height * 0.02),
                CommonDetailText(
                  width: width,
                  titleText: StringUtils.packageName,
                  descriptionText: packageName!,
                ),
                SizedBox(height: height * 0.015),
                CommonDetailText(
                  width: width,
                  titleText: StringUtils.insuranceName,
                  descriptionText: insuranceName!,
                ),
                SizedBox(height: height * 0.015),
                CommonDetailText(
                  width: width,
                  titleText: StringUtils.agentName,
                  descriptionText: agentName!,
                ),
                SizedBox(height: height * 0.015),
                CommonDetailText(
                  width: width,
                  titleText: StringUtils.policyNo,
                  descriptionText: policyNo!,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
