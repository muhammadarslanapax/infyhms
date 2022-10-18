import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infyhms_flutter/component/common_app_bar.dart';
import 'package:infyhms_flutter/component/common_button.dart';
import 'package:infyhms_flutter/component/common_detail_text.dart';
import 'package:infyhms_flutter/component/common_text.dart';
import 'package:infyhms_flutter/constant/color_const.dart';
import 'package:infyhms_flutter/constant/text_style_const.dart';
import 'package:infyhms_flutter/utils/image_utils.dart';
import 'package:infyhms_flutter/utils/string_utils.dart';

class BillDetailScreen extends StatelessWidget {
  const BillDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: CommonAppBar(
          title: "Bill Details",
          leadOnTap: () {
            Get.back();
          },
          leadIcon: const Icon(
            Icons.arrow_back_rounded,
            color: ColorConst.blackColor,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(right: 15, left: 15),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: height * 0.03),
                Row(
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
                          "Bill #2BVF5Q",
                          style: TextStyleConst.boldTextStyle(
                            ColorConst.blackColor,
                            width * 0.05,
                          ),
                        ),
                        Text(
                          "Bill Date: 16th Jun, 2022 - 3:59 PM",
                          style: TextStyleConst.hintTextStyle(ColorConst.hintGreyColor),
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(height: height * 0.02),
                Divider(
                  thickness: 1.5,
                  color: ColorConst.greyShadowColor,
                ),
                SizedBox(height: height * 0.01),
                CommonText(
                  width: width,
                  text: StringUtils.admissionDetails,
                ),
                SizedBox(height: height * 0.025),
                CommonDetailText(
                  width: width,
                  titleText: "Admission Id:",
                  descriptionText: "ED2WRTUW",
                ),
                SizedBox(height: height * 0.015),
                CommonDetailText(
                  width: width,
                  titleText: "Patient Cell No:",
                  descriptionText: "+917878987844",
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
                  titleText: "Discharge Date:",
                  descriptionText: "14th Jun, 2022 - 12:00 PM",
                ),
                SizedBox(height: height * 0.015),
                CommonDetailText(
                  width: width,
                  titleText: "Created On:",
                  descriptionText: "3 months ago",
                ),
                SizedBox(height: height * 0.025),
                CommonText(
                  width: width,
                  text: StringUtils.insuranceDetails,
                ),
                SizedBox(height: height * 0.025),
                CommonDetailText(
                  width: width,
                  titleText: "Package Name:",
                  descriptionText: "Healthcare Package",
                ),
                SizedBox(height: height * 0.015),
                CommonDetailText(
                  width: width,
                  titleText: "Insurance Name:",
                  descriptionText: "Senior Citizen Health Insurance",
                ),
                SizedBox(height: height * 0.015),
                CommonDetailText(
                  width: width,
                  titleText: "Total Days:",
                  descriptionText: "4",
                ),
                SizedBox(height: height * 0.015),
                CommonDetailText(
                  width: width,
                  titleText: "Policy No:",
                  descriptionText: "N/A",
                ),
                SizedBox(height: height * 0.02),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: ColorConst.greyShadowColor,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 15, right: 15, left: 15),
                        child: Text(
                          "Item Details",
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
                          color: ColorConst.hintGreyColor,
                          thickness: 1.5,
                        ),
                      ),
                      SizedBox(height: height * 0.01),
                      Padding(
                        padding: const EdgeInsets.only(right: 15, left: 15),
                        child: Column(
                          children: List.generate(
                            3,
                            (index) => Padding(
                              padding: EdgeInsets.only(bottom: height * 0.01),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Cleanings",
                                        style: TextStyleConst.mediumTextStyle(
                                          ColorConst.blackColor,
                                          width * 0.045,
                                        ),
                                      ),
                                      SizedBox(height: height * 0.003),
                                      Text(
                                        "QTY 1 x \$ 250",
                                        style: TextStyleConst.mediumTextStyle(
                                          ColorConst.hintGreyColor,
                                          width * 0.04,
                                        ),
                                      )
                                    ],
                                  ),
                                  Text(
                                    "\$ 250",
                                    style: TextStyleConst.mediumTextStyle(
                                      ColorConst.blackColor,
                                      width * 0.045,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.01),
                      Container(
                        height: 50,
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15),
                          ),
                          color: ColorConst.lifhtBlueColor,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total Amount:",
                              style: TextStyleConst.boldTextStyle(
                                ColorConst.blackColor,
                                width * 0.045,
                              ),
                            ),
                            Text(
                              "\$ 870",
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
                Center(
                  child: CommonButton(
                    width: width / 2,
                    height: 50,
                    text: "Download Bill",
                    color: ColorConst.blueColor,
                    onTap: () {},
                    textStyleConst: TextStyleConst.mediumTextStyle(ColorConst.whiteColor, width * 0.05),
                  ),
                ),
                SizedBox(height: height * 0.02),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
