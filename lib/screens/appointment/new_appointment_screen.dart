import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infyhms_flutter/component/common_app_bar.dart';
import 'package:infyhms_flutter/component/common_button.dart';
import 'package:infyhms_flutter/component/common_dropdown_button.dart';
import 'package:infyhms_flutter/component/common_required_text.dart';
import 'package:infyhms_flutter/component/common_text_field.dart';
import 'package:infyhms_flutter/constant/color_const.dart';
import 'package:infyhms_flutter/constant/text_style_const.dart';
import 'package:infyhms_flutter/controller/appointment_controller/new_appointment_controller.dart';
import 'package:infyhms_flutter/utils/string_utils.dart';

class NewAppointmentScreen extends StatelessWidget {
  const NewAppointmentScreen({Key? key}) : super(key: key);

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
                              onChange: (value) {
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
                              onTap: () {
                                showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1999),
                                  lastDate: DateTime(2025),
                                );
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
                            CommonRequiredText(
                              width: width,
                              text: StringUtils.timer,
                            ),
                            SizedBox(height: height * 0.01),
                            GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: 9,
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                childAspectRatio: 2.5,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                              ),
                              itemBuilder: (context, index) {
                                return Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: ColorConst.borderGreyColor,
                                      width: 1.5,
                                    ),
                                  ),
                                  height: 50,
                                  child: Center(
                                    child: Text(
                                      "8:00 AM",
                                      style: TextStyleConst.hintTextStyle(
                                        ColorConst.hintGreyColor,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                            SizedBox(height: height * 0.02),

                            /// Description
                            CommonRequiredText(
                              width: width,
                              text: StringUtils.description,
                            ),
                            SizedBox(height: height * 0.02),
                            CommonTextField(
                              keyBoardType: TextInputType.multiline,
                              maxLine: 5,
                              onTap: () {},
                              validator: (value) {
                                return null;
                              },
                              controller: controller.dateController,
                              hintText: StringUtils.typeHere,
                            ),
                            SizedBox(height: height * 0.02),

                            /// Button
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CommonButton(
                                  textStyleConst: TextStyleConst.mediumTextStyle(ColorConst.whiteColor, width * 0.05),
                                  onTap: () {},
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
