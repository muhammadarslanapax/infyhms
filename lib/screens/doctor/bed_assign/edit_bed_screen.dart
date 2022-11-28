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

class EditBedScreen extends StatelessWidget {
  EditBedScreen({Key? key}) : super(key: key);
  final EditBedController editBedController = Get.put(EditBedController());

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
                            CommonDropDown(
                              enabled: false,
                              value:
                                  editBedController.patientCases?.data?.isEmpty ?? true ? null : editBedController.patientCases?.data?[0].patient_case,
                              color: ColorConst.bgGreyColor,
                              hintText: "Select case",
                              dropdownItems: List.generate(
                                editBedController.patientCases?.data?.length ?? 0,
                                (index) => DropdownMenuItem(
                                  value: editBedController.patientCases?.data?[index].patient_case,
                                  child: Text(
                                    editBedController.patientCases?.data?[index].patient_case ?? "",
                                    style: const TextStyle(color: ColorConst.hintGreyColor),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: height * 0.02),
                            CommonRequiredText(width: width, text: StringUtils.ipdPatient),
                            SizedBox(height: height * 0.01),

                            /// IPD Patient
                            CommonDropDown(
                              value: editBedController.ipdPatientId.toString(),
                              enabled: editBedController.ipdPatientsModel?.data?.isNotEmpty ?? false,
                              color: editBedController.ipdPatientsModel?.data?.isNotEmpty ?? false ? ColorConst.whiteColor : ColorConst.bgGreyColor,
                              hintText:
                                  editBedController.ipdPatientsModel?.data?.isNotEmpty ?? false ? "Please Select IPD Patient" : "No IPD Patient Found",
                              onChange: editBedController.ipdPatientsModel?.data?.isNotEmpty ?? false
                                  ? (value) {
                                      editBedController.ipdPatientId = value;
                                    }
                                  : null,
                              dropdownItems: editBedController.ipdPatientsModel?.data?.map((value) {
                                    return DropdownMenuItem(
                                      value: value.id.toString(),
                                      child: Text(
                                        value.ipd_number ?? "",
                                      ),
                                    );
                                  }).toList() ??
                                  [],
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
                                    editBedController.saveData();
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
