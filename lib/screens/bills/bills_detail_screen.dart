import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infyhms_flutter/component/common_app_bar.dart';
import 'package:infyhms_flutter/component/common_button.dart';
import 'package:infyhms_flutter/component/common_detail_text.dart';
import 'package:infyhms_flutter/component/common_text.dart';
import 'package:infyhms_flutter/constant/color_const.dart';
import 'package:infyhms_flutter/constant/text_style_const.dart';
import 'package:infyhms_flutter/controller/bills_controller/bill_details_controller.dart';
import 'package:infyhms_flutter/utils/image_utils.dart';
import 'package:infyhms_flutter/utils/string_utils.dart';

class BillDetailScreen extends StatelessWidget {
  BillDetailScreen({Key? key}) : super(key: key);
  final BillDetailsController billDetailsController = Get.put(BillDetailsController());

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
          body: Obx(
            () {
              return billDetailsController.isGetBillsDetails.value != false
                  ? Padding(
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
                                      "Bill #${billDetailsController.billDetailModel!.data!.bill_id}",
                                      style: TextStyleConst.boldTextStyle(
                                        ColorConst.blackColor,
                                        width * 0.05,
                                      ),
                                    ),
                                    Text(
                                      "Bill Date: ${billDetailsController.billDetailModel!.data!.bill_date} - ${billDetailsController.billDetailModel!.data!.bill_time}",
                                      style: TextStyleConst.mediumTextStyle(ColorConst.hintGreyColor, width * 0.04),
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
                              titleText: StringUtils.admissionId,
                              descriptionText: billDetailsController.billDetailModel!.data!.patient_admission_id!,
                            ),
                            SizedBox(height: height * 0.015),
                            CommonDetailText(
                              width: width,
                              titleText: StringUtils.patientCellNO,
                              descriptionText: billDetailsController.billDetailModel!.data!.admission_detail!.phone!,
                            ),
                            SizedBox(height: height * 0.015),
                            CommonDetailText(
                              width: width,
                              titleText: StringUtils.doctor,
                              descriptionText: billDetailsController.billDetailModel!.data!.admission_detail!.doctor!,
                            ),
                            SizedBox(height: height * 0.015),
                            CommonDetailText(
                              width: width,
                              titleText: StringUtils.admissionDate,
                              descriptionText:
                                  "${billDetailsController.billDetailModel!.data!.admission_detail!.admission_date!} - ${billDetailsController.billDetailModel!.data!.admission_detail!.admission_time!}",
                            ),
                            SizedBox(height: height * 0.015),
                            CommonDetailText(
                              width: width,
                              titleText: StringUtils.dischargeDate,
                              descriptionText:
                                  "${billDetailsController.billDetailModel!.data!.admission_detail!.discharge_date!} - ${billDetailsController.billDetailModel!.data!.admission_detail!.discharge_time!}",
                            ),
                            SizedBox(height: height * 0.015),
                            CommonDetailText(
                              width: width,
                              titleText: StringUtils.createOn,
                              descriptionText: billDetailsController.billDetailModel!.data!.admission_detail!.created_at!,
                            ),
                            SizedBox(height: height * 0.025),
                            CommonText(
                              width: width,
                              text: StringUtils.insuranceDetails,
                            ),
                            SizedBox(height: height * 0.025),
                            CommonDetailText(
                              width: width,
                              titleText: StringUtils.packageName,
                              descriptionText: billDetailsController.billDetailModel!.data!.insurance_detail!.package_name!,
                            ),
                            SizedBox(height: height * 0.015),
                            CommonDetailText(
                              width: width,
                              titleText: StringUtils.insuranceName,
                              descriptionText: billDetailsController.billDetailModel!.data!.insurance_detail!.insurance_name!,
                            ),
                            SizedBox(height: height * 0.015),
                            CommonDetailText(
                              width: width,
                              titleText: StringUtils.totalDays,
                              descriptionText: "${billDetailsController.billDetailModel!.data!.insurance_detail!.total_days!}",
                            ),
                            SizedBox(height: height * 0.015),
                            CommonDetailText(
                              width: width,
                              titleText: StringUtils.policyNo,
                              descriptionText: billDetailsController.billDetailModel!.data!.insurance_detail!.policy_no!,
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
                                      StringUtils.itemDetails,
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
                                      children: List.generate(billDetailsController.billDetailModel!.data!.item_details!.length, (index) {
                                        billDetailsController.totalPrice.value =
                                            billDetailsController.billDetailModel!.data!.item_details![index].total!;
                                        print(billDetailsController.totalPrice);
                                        return Padding(
                                          padding: EdgeInsets.only(bottom: height * 0.01),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    billDetailsController.billDetailModel!.data!.item_details![index].item_name!,
                                                    style: TextStyleConst.mediumTextStyle(
                                                      ColorConst.blackColor,
                                                      width * 0.045,
                                                    ),
                                                  ),
                                                  SizedBox(height: height * 0.003),
                                                  Text(
                                                    "QTY ${billDetailsController.billDetailModel!.data!.item_details![index].quantity!} x \$ ${billDetailsController.billDetailModel!.data!.item_details![index].price!}",
                                                    style: TextStyleConst.mediumTextStyle(
                                                      ColorConst.hintGreyColor,
                                                      width * 0.04,
                                                    ),
                                                  )
                                                ],
                                              ),
                                              Text(
                                                "\$ ${billDetailsController.billDetailModel!.data!.item_details![index].price!}",
                                                style: TextStyleConst.mediumTextStyle(
                                                  ColorConst.blackColor,
                                                  width * 0.045,
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      }),
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
                                          StringUtils.totalAmount,
                                          style: TextStyleConst.boldTextStyle(
                                            ColorConst.blackColor,
                                            width * 0.045,
                                          ),
                                        ),
                                        Text(
                                          "\$ ${billDetailsController.totalPrice}",
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
                                text: StringUtils.downloadBill,
                                color: ColorConst.blueColor,
                                onTap: () {},
                                textStyleConst: TextStyleConst.mediumTextStyle(ColorConst.whiteColor, width * 0.05),
                              ),
                            ),
                            SizedBox(height: height * 0.02),
                          ],
                        ),
                      ),
                    )
                  : const Center(child: CircularProgressIndicator());
            },
          )),
    );
  }
}
