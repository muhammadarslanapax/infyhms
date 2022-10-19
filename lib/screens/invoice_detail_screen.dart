import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infyhms_flutter/component/common_app_bar.dart';
import 'package:infyhms_flutter/component/common_button.dart';
import 'package:infyhms_flutter/component/common_detail_text.dart';
import 'package:infyhms_flutter/constant/color_const.dart';
import 'package:infyhms_flutter/constant/text_style_const.dart';
import 'package:infyhms_flutter/utils/image_utils.dart';

class InvoiceDetailScreen extends StatelessWidget {
  const InvoiceDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: CommonAppBar(
          title: "Invoice Details",
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
                          "Invoice #2BVF5Q",
                          style: TextStyleConst.boldTextStyle(
                            ColorConst.blackColor,
                            width * 0.05,
                          ),
                        ),
                        SizedBox(height: height * 0.004),
                        Text(
                          "Invoice Date: 13th Jul, 2022",
                          style: TextStyleConst.mediumTextStyle(ColorConst.hintGreyColor, width * 0.037),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Container(
                      height: 30,
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: ColorConst.greenColor.withOpacity(0.15),
                      ),
                      child: Center(
                          child: Text(
                        "Paid",
                        style: TextStyleConst.mediumTextStyle(
                          ColorConst.greenColor,
                          width * 0.035,
                        ),
                      )),
                    )
                  ],
                ),
                SizedBox(height: height * 0.02),
                Divider(
                  thickness: 1.5,
                  color: ColorConst.greyShadowColor,
                ),
                SizedBox(height: height * 0.025),
                CommonDetailText(
                  width: width,
                  titleText: "Issue For:",
                  descriptionText: "Mahesh Kaushik #298/6, Block A Adarsh Nagar, Naya Gaon, Mohali 160103",
                ),
                SizedBox(height: height * 0.015),
                CommonDetailText(
                  width: width,
                  titleText: "Issue By:",
                  descriptionText: "HMS Ashok Vihar, New Delhi",
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
                      const Padding(
                        padding: EdgeInsets.only(right: 15, left: 15),
                        child: Divider(
                          color: ColorConst.hintGreyColor,
                          thickness: 1.5,
                        ),
                      ),
                      SizedBox(height: height * 0.01),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Sub Total:",
                              style: TextStyleConst.mediumTextStyle(
                                ColorConst.blackColor,
                                width * 0.045,
                              ),
                            ),
                            Text(
                              "\$ 1200",
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
                            Text(
                              "Discount:",
                              style: TextStyleConst.mediumTextStyle(
                                ColorConst.orangeColor,
                                width * 0.045,
                              ),
                            ),
                            Text(
                              "\$ 12",
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
                    text: "Download Invoice",
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
