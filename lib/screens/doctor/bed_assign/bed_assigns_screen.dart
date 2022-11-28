import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:infyhms_flutter/component/common_alert_box.dart';
import 'package:infyhms_flutter/constant/color_const.dart';
import 'package:infyhms_flutter/constant/text_style_const.dart';
import 'package:infyhms_flutter/controller/doctor/bed_assign_controller/bed_assign_controller.dart';
import 'package:infyhms_flutter/screens/doctor/bed_assign/bed_details.dart';
import 'package:infyhms_flutter/screens/doctor/bed_assign/edit_bed_screen.dart';
import 'package:infyhms_flutter/screens/doctor/bed_assign/new_bed_screen.dart';
import 'package:infyhms_flutter/utils/image_utils.dart';
import 'package:infyhms_flutter/utils/string_utils.dart';

class BedAssignsScreen extends StatelessWidget {
  BedAssignsScreen({Key? key}) : super(key: key);
  final BedAssignController bedAssignController = Get.put(BedAssignController());

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      color: ColorConst.whiteColor,
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                height: 70,
                margin: EdgeInsets.only(top: height * 0.01),
                width: double.infinity,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: bedAssignController.appointmentStatus.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Center(
                      child: Obx(
                        () => GestureDetector(
                          onTap: () {
                            bedAssignController.changeIndex(index);
                          },
                          child: Container(
                            margin: EdgeInsets.only(left: width * 0.03, right: index == 3 ? 10 : 0),
                            height: 50,
                            decoration: index == bedAssignController.currentIndex.value
                                ? BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: ColorConst.blueColor,
                                  )
                                : BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      width: 2,
                                      color: ColorConst.borderGreyColor,
                                    ),
                                  ),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                child: Text(
                                  bedAssignController.appointmentStatus[index],
                                  style: TextStyleConst.mediumTextStyle(
                                    index == bedAssignController.currentIndex.value ? ColorConst.whiteColor : ColorConst.hintGreyColor,
                                    width * 0.04,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                child: Obx(() {
                  return bedAssignController.isBedAssignDataCalled.value == false
                      ? const Center(child: CircularProgressIndicator())
                      : bedAssignController.bedAssignFilterModel?.data?.isEmpty ?? true
                          ? const Center(child: Text("No data found!"))
                          : ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemCount: bedAssignController.bedAssignFilterModel?.data?.length ?? 3,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    Slidable(
                                      startActionPane: ActionPane(
                                        extentRatio: 0.25,
                                        motion: const ScrollMotion(),
                                        children: [
                                          SlidableAction(
                                            onPressed: (context) async {
                                              var data = {
                                                "bed": "${bedAssignController.bedAssignFilterModel?.data?[index].bed}",
                                                "bedId": "${bedAssignController.bedAssignFilterModel?.data?[index].bed_id}",
                                                "assignDate": "${bedAssignController.bedAssignFilterModel?.data?[index].assign_date}",
                                                "assignId": "${bedAssignController.bedAssignFilterModel?.data?[index].id}",
                                              };
                                              final result = await Get.to(
                                                () => EditBedScreen(),
                                                arguments: data,
                                              );
                                              if (result == "Call API") {
                                                bedAssignController.getBedAssignData();
                                              }
                                            },
                                            backgroundColor: ColorConst.orangeColor.withOpacity(0.15),
                                            label: StringUtils.edit,
                                            foregroundColor: ColorConst.orangeColor,
                                            // lableColor: ColorConst.hintGreyColor,
                                          ),
                                        ],
                                      ),
                                      endActionPane: ActionPane(
                                        extentRatio: 0.25,
                                        motion: const ScrollMotion(),
                                        children: [
                                          SlidableAction(
                                            onPressed: (context) {
                                              ContentOfDialog contentOfDialog = ContentOfDialog(
                                                height: height,
                                                width: width,
                                                image: ImageUtils.deleteIcon,
                                                title: "Delete",
                                                description: "Are you sure want to delete this bed",
                                                leftText: "Delete",
                                                rightText: "Cancel",
                                                leftTapEvent: () {
                                                  Get.back();
                                                  bedAssignController.deleteBedAssign(
                                                    context,
                                                    "${bedAssignController.bedAssignFilterModel?.data?[index].id ?? 0}",
                                                    bedAssignController.currentIndex.value,
                                                  );
                                                },
                                                rightTapEvent: () {
                                                  Get.back();
                                                },
                                              );
                                              CommonAlertDialog.commonAlertDialog(context, contentOfDialog);
                                            },
                                            backgroundColor: const Color(0xFFFCE5E5),
                                            foregroundColor: ColorConst.redColor,
                                            label: StringUtils.delete,
                                            // lableColor: ColorConst.redColor,
                                          ),
                                        ],
                                      ),
                                      child: ListTile(
                                        onTap: () {
                                          Get.to(
                                            () => const BedDetails(),
                                            arguments: bedAssignController.bedAssignFilterModel?.data?[index].id ?? 0,
                                          );
                                        },
                                        title: Text(
                                          bedAssignController.bedAssignFilterModel?.data?[index].patient_name ?? "",
                                          style: TextStyleConst.mediumTextStyle(
                                            ColorConst.blackColor,
                                            width * 0.045,
                                          ),
                                        ),
                                        subtitle: RichText(
                                          text: TextSpan(
                                            text: bedAssignController.bedAssignFilterModel?.data?[index].bed ?? "",
                                            style: TextStyleConst.mediumTextStyle(
                                              ColorConst.hintGreyColor,
                                              width * 0.036,
                                            ),
                                            children: [
                                              const TextSpan(text: " | ", style: TextStyle(color: ColorConst.primaryColor)),
                                              TextSpan(
                                                  text: bedAssignController.bedAssignFilterModel?.data?[index].case_id ?? "",
                                                  style: TextStyleConst.mediumTextStyle(ColorConst.hintGreyColor, width * 0.036)),
                                              const TextSpan(text: " | ", style: TextStyle(color: ColorConst.primaryColor)),
                                              TextSpan(
                                                text: bedAssignController.bedAssignFilterModel?.data?[index].assign_date ?? "",
                                                style: TextStyleConst.mediumTextStyle(
                                                  ColorConst.hintGreyColor,
                                                  width * 0.036,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        leading: Container(
                                          height: 60,
                                          width: 60,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                bedAssignController.bedAssignFilterModel?.data?[index].patient_image ??
                                                    "https://i.pinimg.com/originals/d7/be/ca/d7beca2c21d4600d065b8331775aa1f5.jpg",
                                              ),
                                            ),
                                          ),
                                          // child: CachedNetworkImage(
                                          //   imageUrl:
                                          //       appointmentModel!.data![index].doctor_image_url!,
                                          //   placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                                          //   errorWidget: (context, url, error) => const Icon(Icons.error),
                                          // ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: height * 0.01),
                                  ],
                                );
                              },
                            );
                }),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: GestureDetector(
                onTap: () async {
                  final result = await Get.to(() => NewBedScreen());
                  if (result == "Call API") {
                    bedAssignController.getBedAssignData();
                  }
                },
                child: Container(
                  height: 55,
                  width: 55,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: ColorConst.blueColor,
                  ),
                  child: const Icon(Icons.add, color: ColorConst.whiteColor),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
