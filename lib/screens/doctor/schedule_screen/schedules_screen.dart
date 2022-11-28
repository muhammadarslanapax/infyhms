import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infyhms_flutter/component/common_button.dart';
import 'package:infyhms_flutter/component/common_required_text.dart';
import 'package:infyhms_flutter/component/common_text.dart';
import 'package:infyhms_flutter/component/common_text_field.dart';
import 'package:infyhms_flutter/constant/color_const.dart';
import 'package:infyhms_flutter/constant/text_style_const.dart';
import 'package:infyhms_flutter/controller/doctor/schedule_controller/schedule_controller.dart';
import 'package:infyhms_flutter/utils/string_utils.dart';

class SchedulesScreen extends StatelessWidget {
  SchedulesScreen({Key? key}) : super(key: key);
  final SchedulesController schedulesController = Get.put(SchedulesController());

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      color: ColorConst.whiteColor,
      padding: const EdgeInsets.only(right: 15, left: 15, top: 15),
      child: Obx(() {
        return schedulesController.gotData.value == false
            ? const Center(child: CircularProgressIndicator())
            : schedulesController.doctorScheduleModel?.data?.schedule?.isEmpty ?? true
                ? Center(child: Text("Doctor schedules not found", style: TextStyleConst.mediumTextStyle(ColorConst.blackColor, width * 0.04)))
                : SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonRequiredText(width: width, text: "Per Patient Time:"),
                        const SizedBox(height: 10),
                        CommonTextField(
                          onTap: () {
                            schedulesController.showTimePickerDialog(context, null, schedulesController.perPatientTimeController.text);
                          },
                          readOnly: true,
                          validator: (validator) {
                            return null;
                          },
                          controller: schedulesController.perPatientTimeController,
                          hintText: "02:00:00",
                        ),
                        const SizedBox(height: 20),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: schedulesController.doctorScheduleModel?.data?.schedule?.length ?? 0,
                          itemBuilder: (context, index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CommonText(width: width, text: schedulesController.doctorScheduleModel?.data?.schedule?[index].available_on ?? ""),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    Expanded(
                                      child: CommonTextField(
                                        onTap: () {
                                          schedulesController.showTimePickerDialog(
                                              context, index * 2, schedulesController.controllerList[index * 2].text);
                                        },
                                        readOnly: true,
                                        validator: (validator) {
                                          return null;
                                        },
                                        controller: schedulesController.controllerList[index * 2],
                                        hintText: "02:00:00",
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(left: 10, right: 10),
                                      child: Text(
                                        "to",
                                        style: TextStyle(
                                          color: ColorConst.blackColor,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: CommonTextField(
                                        readOnly: true,
                                        onTap: () {
                                          schedulesController.showTimePickerDialog(
                                              context, ((index * 2) + 1), schedulesController.controllerList[(index * 2) + 1].text);
                                        },
                                        validator: (validator) {
                                          return null;
                                        },
                                        controller: schedulesController.controllerList[(index * 2) + 1],
                                        hintText: "02:00:00",
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                              ],
                            );
                          },
                        ),
                        Center(
                          child: CommonButton(
                            textStyleConst: TextStyleConst.mediumTextStyle(ColorConst.whiteColor, width * 0.05),
                            onTap: () {
                              schedulesController.updateSchedules();
                            },
                            color: ColorConst.blueColor,
                            text: StringUtils.save,
                            width: width / 2.3,
                            height: 50,
                          ),
                        ),
                        const SizedBox(height: 25),
                      ],
                    ),
                  );
      }),
    );
  }
}
