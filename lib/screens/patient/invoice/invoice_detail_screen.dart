import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infyhms_flutter/component/common_app_bar.dart';
import 'package:infyhms_flutter/component/common_button.dart';
import 'package:infyhms_flutter/component/common_detail_text.dart';
import 'package:infyhms_flutter/constant/color_const.dart';
import 'package:infyhms_flutter/constant/text_style_const.dart';
import 'package:infyhms_flutter/controller/patient/invoice_controller/invoice_details_controller.dart';
import 'package:infyhms_flutter/utils/image_utils.dart';
import 'package:infyhms_flutter/utils/string_utils.dart';

class InvoiceDetailScreen extends StatelessWidget {
  InvoiceDetailScreen({Key? key, required this.status}) : super(key: key);
  final bool status;
  final InvoiceDetailsController invoiceDetailsController = Get.put(InvoiceDetailsController());

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    int invoiceId = ModalRoute.of(context)!.settings.arguments as int;
    invoiceDetailsController.getInvoiceDetails(invoiceId);

    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConst.whiteColor,
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
        body: Obx(
          () => invoiceDetailsController.isApiCall.value == false
              ? const Center(child: CircularProgressIndicator(color: ColorConst.primaryColor))
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
                                  "Invoice ${invoiceDetailsController.invoiceDetailsModel?.data?.invoice_id ?? "N/A"}",
                                  style: TextStyleConst.boldTextStyle(
                                    ColorConst.blackColor,
                                    width * 0.05,
                                  ),
                                ),
                                SizedBox(height: height * 0.004),
                                Text(
                                  "Invoice Date: ${invoiceDetailsController.invoiceDetailsModel?.data?.invoice_date ?? "N/A"}",
                                  style: TextStyleConst.mediumTextStyle(ColorConst.hintGreyColor, width * 0.037),
                                ),
                              ],
                            ),
                            const Spacer(),
                            status
                                ? Container(
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
                                        "Pending",
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
                        CommonDetailText(
                          width: width,
                          titleText: StringUtils.issueFor,
                          descriptionText:
                              "${invoiceDetailsController.invoiceDetailsModel?.data?.patient_name ?? "N/A"}\n${invoiceDetailsController.invoiceDetailsModel?.data?.address} ${invoiceDetailsController.invoiceDetailsModel?.data?.city} ${invoiceDetailsController.invoiceDetailsModel?.data?.zip}",
                        ),
                        SizedBox(height: height * 0.015),
                        CommonDetailText(
                          width: width,
                          titleText: StringUtils.issueBy,
                          descriptionText:
                              "${invoiceDetailsController.invoiceDetailsModel?.data?.issued_by ?? "N/A"}\n${invoiceDetailsController.invoiceDetailsModel?.data?.hospital_address}",
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
                                  children: List.generate(
                                    invoiceDetailsController.invoiceDetailsModel?.data?.invoice_items?.length ?? 0,
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
                                                invoiceDetailsController.invoiceDetailsModel?.data?.invoice_items?[index].account_name ?? "N/A",
                                                style: TextStyleConst.mediumTextStyle(
                                                  ColorConst.blackColor,
                                                  width * 0.045,
                                                ),
                                              ),
                                              SizedBox(height: height * 0.003),
                                              Text(
                                                "QTY ${invoiceDetailsController.invoiceDetailsModel?.data?.invoice_items?[index].quantity ?? "N/A"} x ${invoiceDetailsController.invoiceDetailsModel?.data?.currencySymbol ?? "N/A"} ${invoiceDetailsController.invoiceDetailsModel?.data?.invoice_items?[index].price ?? "N/A"}",
                                                style: TextStyleConst.mediumTextStyle(
                                                  ColorConst.hintGreyColor,
                                                  width * 0.04,
                                                ),
                                              ),
                                              SizedBox(height: height * 0.003),
                                              Text(
                                                invoiceDetailsController.invoiceDetailsModel?.data?.invoice_items?[index].description ?? "N/A",
                                                style: TextStyleConst.mediumTextStyle(
                                                  ColorConst.hintGreyColor,
                                                  width * 0.04,
                                                ),
                                              )
                                            ],
                                          ),
                                          Text(
                                            "${invoiceDetailsController.invoiceDetailsModel?.data?.currencySymbol ?? "N/A"} ${invoiceDetailsController.invoiceDetailsModel?.data?.invoice_items?[index].total ?? "N/A"}",
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
                                      StringUtils.subTotal,
                                      style: TextStyleConst.mediumTextStyle(
                                        ColorConst.blackColor,
                                        width * 0.045,
                                      ),
                                    ),
                                    Text(
                                      "${invoiceDetailsController.invoiceDetailsModel?.data?.currencySymbol} ${invoiceDetailsController.invoiceDetailsModel?.data?.sub_total ?? "N/A"}",
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
                                      StringUtils.discount,
                                      style: TextStyleConst.mediumTextStyle(
                                        ColorConst.orangeColor,
                                        width * 0.045,
                                      ),
                                    ),
                                    Text(
                                      "${invoiceDetailsController.invoiceDetailsModel?.data?.currencySymbol ?? "N/A"} ${invoiceDetailsController.invoiceDetailsModel?.data?.discount ?? "N/A"}",
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
                                      StringUtils.totalAmount,
                                      style: TextStyleConst.boldTextStyle(
                                        ColorConst.blackColor,
                                        width * 0.045,
                                      ),
                                    ),
                                    Text(
                                      "${invoiceDetailsController.invoiceDetailsModel?.data?.currencySymbol ?? "N/A"} ${invoiceDetailsController.invoiceDetailsModel?.data?.total_amount ?? "N/A"}",
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
                          child: Obx(
                            () => invoiceDetailsController.isDownloading.value == true
                                ? const Center(child: CircularProgressIndicator(color: ColorConst.primaryColor))
                                : CommonButton(
                                    width: width * 0.6,
                                    height: 50,
                                    text: StringUtils.downInvoice,
                                    color: ColorConst.blueColor,
                                    onTap: () {
                                      invoiceDetailsController
                                          .downloadPDF(invoiceDetailsController.invoiceDetailsModel?.data?.invoice_download ?? "");
                                    },
                                    textStyleConst: TextStyleConst.mediumTextStyle(ColorConst.whiteColor, width * 0.047),
                                  ),
                          ),
                        ),
                        SizedBox(height: height * 0.02),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
