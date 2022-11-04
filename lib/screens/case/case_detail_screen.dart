import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infyhms_flutter/component/common_app_bar.dart';
import 'package:infyhms_flutter/component/common_detail_text.dart';
import 'package:infyhms_flutter/constant/color_const.dart';
import 'package:infyhms_flutter/constant/text_style_const.dart';
import 'package:infyhms_flutter/utils/image_utils.dart';
import 'package:infyhms_flutter/utils/string_utils.dart';

class CaseDetailScreen extends StatelessWidget {
  const CaseDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: CommonAppBar(
          title: "Case Details",
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
                          "Case - #2BVF5Q",
                          style: TextStyleConst.boldTextStyle(
                            ColorConst.blackColor,
                            width * 0.05,
                          ),
                        ),
                        SizedBox(height: height * 0.004),
                        Text(
                          "16th Sep, 2022 - 12:00 PM",
                          style: TextStyleConst.mediumTextStyle(ColorConst.hintGreyColor, width * 0.037),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Container(
                      height: 30,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: ColorConst.greenColor.withOpacity(0.15),
                      ),
                      child: Center(
                          child: Text(
                        "Active",
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
                  titleText: StringUtils.doctor,
                  descriptionText: "Bhuva Patel",
                ),
                SizedBox(height: height * 0.015),
                CommonDetailText(
                  width: width,
                  titleText: StringUtils.fee,
                  descriptionText: "\$ 500.00",
                ),
                SizedBox(height: height * 0.015),
                CommonDetailText(
                  width: width,
                  titleText: StringUtils.createOn,
                  descriptionText: "3 weeks ago",
                ),
                SizedBox(height: height * 0.015),
                CommonDetailText(
                  width: width,
                  titleText: StringUtils.description,
                  descriptionText: "N/A",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
