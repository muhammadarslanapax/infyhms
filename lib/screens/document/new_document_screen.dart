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

class NewDocumentScreen extends StatelessWidget {
  NewDocumentScreen({Key? key}) : super(key: key);
  final TextEditingController titleController = TextEditingController();
  final TextEditingController notesController = TextEditingController();
  final List<String> items = [
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
        backgroundColor: Colors.white,
        appBar: CommonAppBar(
          title: StringUtils.newDocument,
          leadOnTap: () {
            Get.back();
          },
          leadIcon: const Icon(
            Icons.arrow_back_rounded,
            color: ColorConst.blackColor,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonRequiredText(width: width, text: StringUtils.title),
                SizedBox(height: height * 0.01),
                CommonTextField(
                  validator: (value) {
                    return null;
                  },
                  controller: titleController,
                ),
                SizedBox(height: height * 0.02),
                CommonRequiredText(width: width, text: StringUtils.documentType),
                SizedBox(height: height * 0.01),
                CommonDropDown(
                  onChange: (value) {},
                  hintText: StringUtils.selectDoctor,
                  dropdownItems: items.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                ),
                SizedBox(height: height * 0.02),
                CommonRequiredText(width: width, text: StringUtils.attachment),
                SizedBox(height: height * 0.01),
                Container(
                  height: 100,
                  width: 100,
                  color: Colors.red,
                ),
                SizedBox(height: height * 0.02),
                CommonRequiredText(width: width, text: StringUtils.note),
                SizedBox(height: height * 0.01),
                CommonTextField(
                  hintText: StringUtils.typeHere,
                  maxLine: 4,
                  validator: (value) {
                    return null;
                  },
                  controller: notesController,
                ),
                SizedBox(height: height * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CommonButton(
                      textStyleConst: TextStyleConst.mediumTextStyle(ColorConst.whiteColor, width * 0.05),
                      onTap: () {

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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
