import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infyhms_flutter/component/common_app_bar.dart';
import 'package:infyhms_flutter/component/common_button.dart';
import 'package:infyhms_flutter/component/common_dropdown_button.dart';
import 'package:infyhms_flutter/component/common_required_text.dart';
import 'package:infyhms_flutter/component/common_snackbar.dart';
import 'package:infyhms_flutter/component/common_text_field.dart';
import 'package:infyhms_flutter/constant/color_const.dart';
import 'package:infyhms_flutter/constant/text_style_const.dart';
import 'package:infyhms_flutter/controller/appointment_controller/new_appointment_controller.dart';
import 'package:infyhms_flutter/utils/preference_utils.dart';
import 'package:infyhms_flutter/utils/string_utils.dart';

class NewAppointmentScreen extends StatefulWidget {
  const NewAppointmentScreen({Key? key}) : super(key: key);

  @override
  State<NewAppointmentScreen> createState() => _NewAppointmentScreenState();
}

class _NewAppointmentScreenState extends State<NewAppointmentScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConst.whiteColor,
        appBar: CommonAppBar(
          title: StringUtils.newAppointment,
          leadOnTap: () {
            Get.back();
          },
          leadIcon: const Icon(
            Icons.arrow_back_rounded,
            color: ColorConst.blackColor,
          ),
        ),
        body: GetBuilder(
          init: NewAppointmentController(),
          builder: (controller) {
            return controller.doctorDepartmentModel != null
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: SizedBox(
                      height: height,
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: height * 0.02),

                            /// Doctor department
                            CommonRequiredText(
                              width: width,
                              text: StringUtils.doctorDepartment,
                            ),
                            SizedBox(height: height * 0.01),
                            CommonDropDown(
                              onChange: (value) {
                                print(value);
                                controller.dateController.clear();
                                controller.departmentId = value;
                                controller.getDoctorName(int.parse(value!)).then((value) {
                                  controller.isSelectDoctorDepartment = true;
                                });
                              },
                              hintText: StringUtils.selectDepartment,
                              dropdownItems: controller.doctorDepartmentModel!.data!.map((value) {
                                return DropdownMenuItem(
                                  value: value.id.toString(),
                                  child: Text(
                                    value.title!,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyleConst.mediumTextStyle(
                                      ColorConst.blackColor,
                                      width * 0.04,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                            SizedBox(height: height * 0.02),

                            /// Select doctor
                            CommonRequiredText(
                              width: width,
                              text: StringUtils.doctor,
                            ),
                            SizedBox(height: height * 0.01),
                            CommonDropDown(
                              value: controller.doctorId,
                              onChange: (value) {
                                controller.doctorId = value!;
                                controller.dateController.clear();
                                controller.update();

                                print(value);
                              },
                              hintText: StringUtils.selectDoctor,
                              dropdownItems: controller.isSelectDoctorDepartment != false
                                  ? controller.getDoctorModel!.data!.map((value) {
                                      return DropdownMenuItem(
                                        value: value.id.toString(),
                                        child: Text(
                                          value.title!,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyleConst.mediumTextStyle(
                                            ColorConst.blackColor,
                                            width * 0.04,
                                          ),
                                        ),
                                      );
                                    }).toList()
                                  : [],
                            ),
                            SizedBox(height: height * 0.02),

                            /// Select date
                            CommonRequiredText(
                              width: width,
                              text: StringUtils.date,
                            ),
                            SizedBox(height: height * 0.01),
                            CommonTextField(
                              readOnly: true,
                              onTap: () {
                                controller.selectDate(context).then((value) async {
                                  await StringUtils.client
                                      .getBookingSlotDate(
                                          "Bearer ${PreferenceUtils.getStringValue("token")}", controller.selectedDate!, controller.doctorId)
                                      .then((value) {
                                    controller.slotBookingModel = value;
                                    controller.isSelectDate = true;
                                    controller.selectedTime = controller.slotBookingModel!.data!.bookingSlotArr![0];

                                    controller.update();
                                  });
                                });
                              },
                              validator: (value) {
                                return null;
                              },
                              controller: controller.dateController,
                              hintText: StringUtils.selectDate,
                              suffixIcon: const Icon(
                                Icons.calendar_month,
                                color: ColorConst.blueColor,
                              ),
                            ),
                            SizedBox(height: height * 0.02),

                            /// Booking slot
                            controller.isSelectDate != false
                                ? CommonRequiredText(
                                    width: width,
                                    text: StringUtils.timer,
                                  )
                                : const SizedBox(),
                            controller.isSelectDate != false ? SizedBox(height: height * 0.01) : const SizedBox(),
                            controller.isSelectDate != false
                                ? controller.slotBookingModel!.data!.bookingSlotArr!.isNotEmpty
                                    ? GridView.builder(
                                        shrinkWrap: true,
                                        physics: const NeverScrollableScrollPhysics(),
                                        itemCount: controller.slotBookingModel!.data!.bookingSlotArr!.length,
                                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3,
                                          childAspectRatio: 2.5,
                                          crossAxisSpacing: 10,
                                          mainAxisSpacing: 10,
                                        ),
                                        itemBuilder: (context, index) {
                                          return GestureDetector(
                                            onTap: () {
                                              controller.currentIndex = index;
                                              controller.selectedTime = controller.slotBookingModel!.data!.bookingSlotArr![index];
                                              controller.update();
                                            },
                                            child: Container(
                                              decoration: controller.currentIndex != index
                                                  ? BoxDecoration(
                                                      borderRadius: BorderRadius.circular(10),
                                                      border: Border.all(
                                                        color: ColorConst.borderGreyColor,
                                                        width: 1.5,
                                                      ),
                                                    )
                                                  : BoxDecoration(
                                                      borderRadius: BorderRadius.circular(10),
                                                      color: ColorConst.blueColor,
                                                    ),
                                              height: 50,
                                              child: Center(
                                                child: Text(
                                                  controller.slotBookingModel!.data!.bookingSlotArr![index],
                                                  style: controller.currentIndex != index
                                                      ? TextStyleConst.hintTextStyle(
                                                          ColorConst.hintGreyColor,
                                                        )
                                                      : TextStyleConst.hintTextStyle(
                                                          ColorConst.whiteColor,
                                                        ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      )
                                    : Center(
                                        child: Text(
                                          "No slot available",
                                          style: TextStyleConst.mediumTextStyle(
                                            ColorConst.redColor,
                                            width * 0.04,
                                          ),
                                        ),
                                      )
                                : const SizedBox(),
                            controller.isSelectDate != false ? SizedBox(height: height * 0.02) : const SizedBox(),

                            /// Description
                            CommonRequiredText(
                              width: width,
                              text: StringUtils.description,
                            ),
                            SizedBox(height: height * 0.02),
                            CommonTextField(
                              keyBoardType: TextInputType.multiline,
                              maxLine: 4,
                              onTap: () {},
                              validator: (value) {
                                return null;
                              },
                              controller: controller.descriptionController,
                              hintText: StringUtils.typeHere,
                            ),
                            SizedBox(height: height * 0.02),

                            /// Button
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CommonButton(
                                  textStyleConst: TextStyleConst.mediumTextStyle(ColorConst.whiteColor, width * 0.05),
                                  onTap: () {
                                    StringUtils.client
                                        .createAppointment("Bearer ${PreferenceUtils.getStringValue("token")}", controller.departmentId!,
                                            controller.doctorId, controller.selectedDate!, controller.selectedTime!)
                                        .then((value) {
                                      controller.createAppointmentModel = value;
                                      if (value.success == true) {
                                        DisplaySnackBar.displaySnackBar(context, value.message!);
                                        Get.back();
                                      }
                                    });
                                  },
                                  color: ColorConst.blueColor,
                                  text: StringUtils.save,
                                  width: width / 2.3,
                                  height: 50,
                                ),
                                CommonButton(
                                  textStyleConst: TextStyleConst.mediumTextStyle(ColorConst.hintGreyColor, width * 0.05),
                                  onTap: () {
                                    Get.back();
                                  },
                                  color: ColorConst.borderGreyColor,
                                  text: StringUtils.cancel,
                                  width: width / 2.3,
                                  height: 50,
                                ),
                              ],
                            ),
                            SizedBox(height: height * 0.02),
                          ],
                        ),
                      ),
                    ),
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  );
          },
        ),
      ),
    );
  }
}
