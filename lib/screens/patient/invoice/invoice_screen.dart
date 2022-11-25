import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infyhms_flutter/constant/color_const.dart';
import 'package:infyhms_flutter/constant/text_style_const.dart';
import 'package:infyhms_flutter/controller/patient/invoice_controller/invoice_list_controller.dart';
import 'package:infyhms_flutter/screens/patient/invoice/invoice_detail_screen.dart';

class InvoiceScreen extends StatelessWidget {
  InvoiceScreen({Key? key}) : super(key: key);
  final InvoiceListController invoiceListController = Get.put(InvoiceListController());

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
        color: Colors.white,
        child: Obx(
          () => invoiceListController.isGotInvoice.value == false
              ? const Center(child: CircularProgressIndicator(color: ColorConst.primaryColor))
              : invoiceListController.invoiceModel?.data?.isEmpty ?? true
                  ? Center(
                      child: Text(
                        "No invoice found",
                        style: TextStyleConst.mediumTextStyle(
                          ColorConst.blackColor,
                          width * 0.04,
                        ),
                      ),
                    )
                  : ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: invoiceListController.invoiceModel?.data?.length ?? 0,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Get.to(
                              () => InvoiceDetailScreen(status: invoiceListController.invoiceModel?.data?[index].status ?? false),
                              transition: Transition.rightToLeft,
                              arguments: invoiceListController.invoiceModel?.data?[index].id ?? 0,
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.only(left: 15, right: 15, top: index == 0 ? 15 : 5),
                            height: 60,
                            color: Colors.transparent,
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      invoiceListController.invoiceModel?.data?[index].invoice_id ?? "N/A",
                                      style: TextStyleConst.boldTextStyle(
                                        ColorConst.blueColor,
                                        width * 0.045,
                                      ),
                                    ),
                                    SizedBox(height: height * 0.004),
                                    RichText(
                                      text: TextSpan(
                                        text: invoiceListController.invoiceModel?.data?[index].status == true ? "Paid " : "Pending ",
                                        style: TextStyleConst.mediumTextStyle(
                                          invoiceListController.invoiceModel?.data?[index].status == true ? Colors.green : Colors.red,
                                          width * 0.037,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: "| ${invoiceListController.invoiceModel?.data?[index].invoice_date ?? "N/A"}",
                                            style: TextStyleConst.mediumTextStyle(
                                              ColorConst.hintGreyColor,
                                              width * 0.037,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 15),
                                  height: 45,
                                  decoration: BoxDecoration(
                                    color: ColorConst.bgGreyColor,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "${invoiceListController.invoiceModel?.data?[index].currency ?? ""} ${invoiceListController.invoiceModel?.data?[index].amount ?? "N/A"}",
                                      style: TextStyleConst.boldTextStyle(ColorConst.blackColor, width * 0.04),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
        ));
  }
}
