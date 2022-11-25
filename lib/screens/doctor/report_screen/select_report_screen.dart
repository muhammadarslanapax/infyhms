import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infyhms_flutter/component/common_account_button.dart';
import 'package:infyhms_flutter/constant/color_const.dart';
import 'package:infyhms_flutter/screens/doctor/report_screen/reports_screen.dart';
import 'package:infyhms_flutter/utils/string_utils.dart';

class SelectReportScreen extends StatelessWidget {
  const SelectReportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      color: ColorConst.whiteColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: height * 0.02),
          CommonAccountButton(
            width: width,
            onTap: () async {
              Get.to(
                () => ReportScreen(title: StringUtils.birthReport),
                transition: Transition.rightToLeft,
                arguments: StringUtils.birthReport,
              );
            },
            text: StringUtils.birthReport,
          ),
          SizedBox(height: height * 0.02),
          CommonAccountButton(
            width: width,
            onTap: () {
              Get.to(
                () => ReportScreen(title: StringUtils.deathReport),
                transition: Transition.rightToLeft,
                arguments: StringUtils.deathReport,
              );
            },
            text: StringUtils.deathReport,
          ),
          SizedBox(height: height * 0.02),
          CommonAccountButton(
            width: width,
            onTap: () {
              Get.to(
                () => ReportScreen(title: StringUtils.investigationReport),
                transition: Transition.rightToLeft,
                arguments: StringUtils.investigationReport,
              );
            },
            text: StringUtils.investigationReport,
          ),
          SizedBox(height: height * 0.02),
          CommonAccountButton(
            width: width,
            onTap: () {
              Get.to(
                () => ReportScreen(title: StringUtils.operationReport),
                transition: Transition.rightToLeft,
                arguments: StringUtils.operationReport,
              );
            },
            text: StringUtils.operationReport,
          ),
        ],
      ),
    );
  }
}
