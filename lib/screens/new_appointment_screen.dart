import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infyhms_flutter/component/common_app_bar.dart';
import 'package:infyhms_flutter/component/common_button.dart';
import 'package:infyhms_flutter/component/common_dropdown_button.dart';
import 'package:infyhms_flutter/component/common_required_text.dart';
import 'package:infyhms_flutter/component/common_text_field.dart';
import 'package:infyhms_flutter/constant/color_const.dart';
import 'package:infyhms_flutter/constant/text_style_const.dart';
import 'package:infyhms_flutter/utils/string_utils.dart';

class NewAppointmentScreen extends StatelessWidget {
  NewAppointmentScreen({Key? key}) : super(key: key);
  final TextEditingController doctorController = TextEditingController();

  TextEditingController dateController = TextEditingController();

  var items = [
    'Doctor 1',
    'Doctor 2',
    'Doctor 3',
    'Doctor 4',
    'Doctor 5',
  ];
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
          centerTitle: true,
          leadIcon: const Icon(
            Icons.arrow_back_rounded,
            color: ColorConst.blackColor,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: SizedBox(
            height: height,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: height * 0.02),
                  CommonRequiredText(
                    width: width,
                    text: StringUtils.doctorDepartment,
                  ),
                  SizedBox(height: height * 0.01),
                  CommonDropDown(
                    onChange: (value) {},
                    hintText: "Select Department",
                    dropdownItems: items.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: height * 0.02),
                  CommonRequiredText(
                    width: width,
                    text: StringUtils.doctor,
                  ),
                  SizedBox(height: height * 0.01),
                  CommonDropDown(
                    onChange: (value) {},
                    hintText: "Select Doctor",
                    dropdownItems: items.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: height * 0.02),
                  CommonRequiredText(
                    width: width,
                    text: StringUtils.doctor,
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
                    controller: dateController,
                    hintText: "Select Date",
                    suffixIcon: const Icon(
                      Icons.calendar_month,
                      color: ColorConst.blueColor,
                    ),
                  ),
                  SizedBox(height: height * 0.02),
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
                    controller: dateController,
                    hintText: "Type here..",
                  ),
                  SizedBox(height: height * 0.02),
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
        ),
      ),
    );
  }
}
