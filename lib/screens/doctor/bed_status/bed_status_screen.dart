import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infyhms_flutter/component/common_loader.dart';
import 'package:infyhms_flutter/component/common_text.dart';
import 'package:infyhms_flutter/constant/color_const.dart';
import 'package:infyhms_flutter/constant/text_style_const.dart';
import 'package:infyhms_flutter/controller/doctor/bed_status_controller/bed_status_controller.dart';
import 'package:infyhms_flutter/utils/image_utils.dart';

class BedStatusScreen extends StatelessWidget {
  BedStatusScreen({Key? key}) : super(key: key);
  final BedStatusController bedStatusController = Get.put(BedStatusController());

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      color: ColorConst.whiteColor,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Obx(() {
        return bedStatusController.isStatusApiCalled.value == false
            ? const Center(child: CircularProgressIndicator(color: ColorConst.primaryColor))
            : bedStatusController.bedStatusModel?.data?.isEmpty ?? true
                ? Center(child: Text("No data found!", style: TextStyleConst.mediumTextStyle(ColorConst.blackColor, 18)))
                : ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: bedStatusController.bedStatusModel?.data?.length ?? 0,
                    itemBuilder: (context, mainIndex) {
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CommonText(
                                text: bedStatusController.bedStatusModel?.data?[mainIndex].bed_title ?? "",
                                width: width,
                              ),
                              IconButton(
                                onPressed: () {
                                  bedStatusController.changeIcon(mainIndex);
                                },
                                icon: Obx(() {
                                  return RotatedBox(
                                    quarterTurns: bedStatusController.turns[mainIndex].value,
                                    child: Image.asset(
                                      ImageUtils.dropDownIcon,
                                      width: 16,
                                      height: 8,
                                    ),
                                  );
                                }),
                              ),
                            ],
                          ),
                          Obx(() {
                            return Visibility(
                              visible: bedStatusController.showData[mainIndex].value,
                              child: Column(
                                children: List.generate(
                                  bedStatusController.bedStatusModel?.data?[mainIndex].bed?.length ?? 0,
                                  (subIndex) {
                                    return ListTile(
                                      onTap: () {
                                        CommonLoader.showLoader(context);
                                        bedStatusController.getBedDetails(
                                          "${bedStatusController.bedStatusModel?.data?[mainIndex].bed?[subIndex].id}",
                                          context,
                                          height,
                                          width,
                                        );
                                      },
                                      title: Text(
                                        bedStatusController.bedStatusModel?.data?[mainIndex].bed?[subIndex].name ?? "",
                                        style: const TextStyle(color: Colors.black),
                                      ),
                                      leading: Image.asset(
                                        bedStatusController.bedStatusModel?.data?[mainIndex].bed?[subIndex].status ?? false
                                            ? ImageUtils.bedStatusGreen
                                            : ImageUtils.bedStatusRed,
                                        height: 22,
                                        width: 30,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            );
                          }),
                          const Divider(
                            color: Colors.grey,
                            // color: Color(0xffE7E9EB),
                          ),
                        ],
                      );
                    },
                  );
      }),
    );
  }
}
