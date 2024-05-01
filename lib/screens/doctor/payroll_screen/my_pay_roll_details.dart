import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infyhms_flutter/component/common_app_bar.dart';
import 'package:infyhms_flutter/component/common_detail_text.dart';
import 'package:infyhms_flutter/constant/color_const.dart';
import 'package:infyhms_flutter/constant/text_style_const.dart';
import 'package:infyhms_flutter/controller/doctor/doctor_payroll_controller/payroll_details_controller.dart';
import 'package:infyhms_flutter/utils/image_utils.dart';
import 'package:infyhms_flutter/utils/string_utils.dart';

class MyPayRollDetailsScreen extends StatelessWidget {
  MyPayRollDetailsScreen({Key? key}) : super(key: key);
  final PayrollDetailsController payrollDetailsController = Get.put(PayrollDetailsController());

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var id = ModalRoute.of(context)!.settings.arguments as int;
    payrollDetailsController.getPayrollDetails(id);
    return SafeArea(
      child: Scaffold(
          backgroundColor: ColorConst.whiteColor,
          appBar: CommonAppBar(
            title: StringUtils.payrollsDetails,
            leadOnTap: () {
              Get.back();
            },
            leadIcon: const Icon(
              Icons.arrow_back_rounded,
              color: ColorConst.blackColor,
            ),
          ),
          body: Obx(() {
            return payrollDetailsController.isGetDetails.value == false
                ? const Center(child: CircularProgressIndicator())
                : Padding(
                    padding: const EdgeInsets.only(right: 15, left: 15),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          SizedBox(height: height * 0.03),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 50,
                                width: 50,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                      ImageUtils.splashLogo,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: width * 0.04),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Payroll #${payrollDetailsController.payrollDetailsModel!.data!.payroll_id}",
                                    style: TextStyleConst.boldTextStyle(
                                      ColorConst.blackColor,
                                      width * 0.05,
                                    ),
                                  ),
                                  SizedBox(height: height * 0.004),
                                  Text(
                                    "${payrollDetailsController.payrollDetailsModel!.data!.month}  ${payrollDetailsController.payrollDetailsModel!.data!.year}",
                                    style: TextStyleConst.mediumTextStyle(ColorConst.hintGreyColor, width * 0.037),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              payrollDetailsController.payrollDetailsModel!.data!.status == "Paid"
                                  ? Container(
                                      height: 30,
                                      padding: const EdgeInsets.symmetric(horizontal: 15),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: ColorConst.greenColor.withOpacity(0.15),
                                      ),
                                      child: Center(
                                        child: Text(
                                          payrollDetailsController.payrollDetailsModel!.data!.status!,
                                          style: TextStyleConst.mediumTextStyle(
                                            ColorConst.greenColor,
                                            width * 0.035,
                                          ),
                                        ),
                                      ),
                                    )
                                  : Container(
                                      height: 30,
                                      padding: const EdgeInsets.symmetric(horizontal: 15),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.red.withOpacity(0.15),
                                      ),
                                      child: Center(
                                        child: Text(
                                          payrollDetailsController.payrollDetailsModel!.data!.status!,
                                          style: TextStyleConst.mediumTextStyle(
                                            Colors.red,
                                            width * 0.035,
                                          ),
                                        ),
                                      ),
                                    ),
                            ],
                          ),
                          SizedBox(height: height * 0.02),
                          Divider(
                            thickness: 1.5,
                            color: ColorConst.greyShadowColor,
                          ),
                          SizedBox(height: height * 0.025),

                          /// Sr No:
                          CommonDetailText(
                            width: width,
                            titleText: StringUtils.srNo,
                            descriptionText: "${payrollDetailsController.payrollDetailsModel!.data!.sr_no}",
                          ),
                          SizedBox(height: height * 0.015),

                          /// Created On
                          CommonDetailText(
                            width: width,
                            titleText: StringUtils.createOn,
                            descriptionText: "${payrollDetailsController.payrollDetailsModel!.data!.created_on}",
                          ),
                          SizedBox(height: height * 0.02),
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: ColorConst.bgGreyColor,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                /// Salary Details
                                Padding(
                                  padding: const EdgeInsets.only(top: 15, right: 15, left: 15),
                                  child: Text(
                                    StringUtils.salaryDetails,
                                    style: TextStyleConst.mediumTextStyle(
                                      ColorConst.blackColor,
                                      width * 0.04,
                                    ),
                                  ),
                                ),
                                SizedBox(height: height * 0.01),
                                const Padding(
                                  padding: EdgeInsets.only(right: 15, left: 15),
                                  child: Divider(
                                    color: ColorConst.borderGreyColor,
                                    thickness: 1.5,
                                  ),
                                ),
                                SizedBox(height: height * 0.01),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 15),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      /// Basic Salary
                                      Text(
                                        StringUtils.basicSalary,
                                        style: TextStyleConst.mediumTextStyle(
                                          ColorConst.blackColor,
                                          width * 0.045,
                                        ),
                                      ),
                                      Text(
                                        "${payrollDetailsController.payrollDetailsModel!.data!.currency_symbol} ${payrollDetailsController.payrollDetailsModel!.data!.basic_salary}",
                                        style: TextStyleConst.mediumTextStyle(
                                          ColorConst.blackColor,
                                          width * 0.045,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: height * 0.01),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 15),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      /// Allowance
                                      Text(
                                        StringUtils.allowance,
                                        style: TextStyleConst.mediumTextStyle(
                                          ColorConst.blackColor,
                                          width * 0.045,
                                        ),
                                      ),
                                      Text(
                                        "${payrollDetailsController.payrollDetailsModel!.data!.currency_symbol} ${payrollDetailsController.payrollDetailsModel!.data!.allowance}",
                                        style: TextStyleConst.mediumTextStyle(
                                          ColorConst.blackColor,
                                          width * 0.045,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: height * 0.01),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 15),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      /// Deductions
                                      Text(
                                        StringUtils.deductions,
                                        style: TextStyleConst.mediumTextStyle(
                                          ColorConst.orangeColor,
                                          width * 0.045,
                                        ),
                                      ),
                                      Text(
                                        "${payrollDetailsController.payrollDetailsModel!.data!.currency_symbol} ${payrollDetailsController.payrollDetailsModel!.data!.deductions}",
                                        style: TextStyleConst.mediumTextStyle(
                                          ColorConst.orangeColor,
                                          width * 0.045,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: height * 0.01),
                                Container(
                                  height: 50,
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(horizontal: 15),
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(15),
                                      bottomRight: Radius.circular(15),
                                    ),
                                    color: ColorConst.lightBlueColor,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      /// Net Salary
                                      Text(
                                        StringUtils.netSalary,
                                        style: TextStyleConst.boldTextStyle(
                                          ColorConst.blackColor,
                                          width * 0.045,
                                        ),
                                      ),
                                      Text(
                                        "${payrollDetailsController.payrollDetailsModel!.data!.currency_symbol} ${payrollDetailsController.payrollDetailsModel!.data!.net_salary}",
                                        style: TextStyleConst.boldTextStyle(
                                          ColorConst.blackColor,
                                          width * 0.045,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: height * 0.02),
                        ],
                      ),
                    ),
                  );
          })),
    );
  }
}
