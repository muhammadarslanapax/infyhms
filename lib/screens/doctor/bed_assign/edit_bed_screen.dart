import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infyhms_flutter/component/common_app_bar.dart';
import 'package:infyhms_flutter/component/common_button.dart';
import 'package:infyhms_flutter/component/common_dropdown_button.dart';
import 'package:infyhms_flutter/component/common_required_text.dart';
import 'package:infyhms_flutter/component/common_text_field.dart';
import 'package:infyhms_flutter/constant/color_const.dart';
import 'package:infyhms_flutter/constant/text_style_const.dart';
import 'package:infyhms_flutter/controller/doctor/bed_assign_controller/bed_edit_controller.dart';
import 'package:infyhms_flutter/utils/string_utils.dart';

class EditBedScreen extends StatefulWidget {
  EditBedScreen({Key? key}) : super(key: key);

  @override
  State<EditBedScreen> createState() => _EditBedScreenState();
}

class _EditBedScreenState extends State<EditBedScreen> {
  final EditBedController editBedController = Get.put(EditBedController());
  late Map<String, dynamic> bedAssignData;


  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      editBedController.assignValue(bedAssignData);
      editBedController.getEditBedDetails(int.parse(bedAssignData['assignId']));
    });
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bedAssignData = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: GestureDetector(
        onTap: (){
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Scaffold(
          backgroundColor: ColorConst.whiteColor,
          appBar: CommonAppBar(
            title: "Edit Bed Assign",
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
              return editBedController.isCasesApiCalled.value == false
                  ? const Center(child: CircularProgressIndicator())
                  : SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonRequiredText(width: width, text: StringUtils.myCases),
                            const SizedBox(height: 10),

                            /// My Cases
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: ColorConst.greyShadowColor,
                              ),
                              child: CommonTextField(
                                readOnly: true,
                                validator: (value) {
                                  return null;
                                },
                                controller: editBedController.myCaseController,
                                suffixIcon: const Icon(Icons.arrow_drop_down, color: ColorConst.blackColor),
                              ),
                            ),
                            SizedBox(height: height * 0.02),
                            CommonRequiredText(width: width, text: StringUtils.ipdPatient),
                            SizedBox(height: height * 0.01),

                            /// IPD Patient
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: ColorConst.greyShadowColor,
                              ),
                              child: CommonTextField(
                                readOnly: true,
                                suffixIcon: const Icon(Icons.arrow_drop_down, color: ColorConst.blackColor),
                                validator: (value) {
                                  return null;
                                },
                                controller: editBedController.ipdPatientController,
                              ),
                            ),
                            SizedBox(height: height * 0.02),
                            CommonRequiredText(width: width, text: StringUtils.bedInEditBed),
                            SizedBox(height: height * 0.01),

                            /// Bed
                            CommonDropDown(
                              value: editBedController.bedId,
                              onChange: (value) {
                                editBedController.bedId = value;
                              },
                              dropdownItems: editBedController.bedsModel?.data?.map((value) {
                                    return DropdownMenuItem(
                                      value: value.id.toString(),
                                      child: Text(
                                        value.name ?? "",
                                      ),
                                    );
                                  }).toList() ??
                                  [],
                            ),
                            SizedBox(height: height * 0.02),
                            CommonRequiredText(width: width, text: StringUtils.assignDate),
                            SizedBox(height: height * 0.01),
                            CommonTextField(
                              readOnly: true,
                              onTap: () {
                                editBedController.selectAssignDate(context);
                              },
                              validator: (value) {
                                return null;
                              },
                              controller: editBedController.selectedBedAssignController,
                              hintText: StringUtils.selectDate,
                              suffixIcon: const Icon(
                                Icons.calendar_month,
                                color: ColorConst.blueColor,
                              ),
                            ),
                            SizedBox(height: height * 0.02),
                            CommonRequiredText(width: width, text: StringUtils.disChargeDate),
                            SizedBox(height: height * 0.01),
                            CommonTextField(
                              readOnly: true,
                              onTap: () {
                                editBedController.selectDischargeDate(context);
                              },
                              validator: (value) {
                                return null;
                              },
                              controller: editBedController.selectedDischargeController,
                              hintText: StringUtils.selectDate,
                              suffixIcon: const Icon(
                                Icons.calendar_month,
                                color: ColorConst.blueColor,
                              ),
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
                              controller: editBedController.notesController,
                            ),
                            SizedBox(height: height * 0.03),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CommonButton(
                                  textStyleConst: TextStyleConst.mediumTextStyle(ColorConst.whiteColor, width * 0.05),
                                  onTap: () {
                                    editBedController.saveData(bedAssignData['assignId']);
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
                            SizedBox(height: height * 0.03),
                          ],
                        ),
                      ),
                    );
            },
          ),
        ),
      ),
    );
  }
}
