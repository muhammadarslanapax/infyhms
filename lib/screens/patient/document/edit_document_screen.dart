import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infyhms_flutter/component/common_app_bar.dart';
import 'package:infyhms_flutter/component/common_button.dart';
import 'package:infyhms_flutter/component/common_dropdown_button.dart';
import 'package:infyhms_flutter/component/common_required_text.dart';
import 'package:infyhms_flutter/component/common_text_field.dart';
import 'package:infyhms_flutter/constant/color_const.dart';
import 'package:infyhms_flutter/constant/text_style_const.dart';
import 'package:infyhms_flutter/controller/patient/document_controller/edit_document_controller.dart';
import 'package:infyhms_flutter/utils/preference_utils.dart';
import 'package:infyhms_flutter/utils/string_utils.dart';

class EditDocumentScreen extends StatelessWidget {
  EditDocumentScreen({
    Key? key,
    required this.documentId,
  }) : super(key: key);
  final int documentId;

  final EditDocumentController editDocumentController = Get.put(EditDocumentController());

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: CommonAppBar(
            title: StringUtils.editDocument,
            leadOnTap: () {
              Get.back();
            },
            leadIcon: const Icon(
              Icons.arrow_back_rounded,
              color: ColorConst.blackColor,
            ),
          ),
          body: Obx(() {
            return editDocumentController.gotData.value == false
                ? const Center(child: CircularProgressIndicator())
                : Padding(
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
                            controller: editDocumentController.titleController,
                          ),
                          SizedBox(height: height * 0.02),
                          CommonRequiredText(width: width, text: StringUtils.documentType),
                          SizedBox(height: height * 0.01),
                          PreferenceUtils.getBoolValue("isDoctor")
                              ? CommonDropDown(
                                  value: editDocumentController.docTypeId,
                                  onChange: (value) {
                                    editDocumentController.docTypeId = value;
                                  },
                                  hintText: "Select Document Type",
                                  dropdownItems: editDocumentController.doctorDocumentsTypeModel!.data!.map((items) {
                                    return DropdownMenuItem(
                                      value: items.id.toString(),
                                      child: Text(items.name ?? ""),
                                    );
                                  }).toList(),
                                )
                              : CommonDropDown(
                                  value: editDocumentController.docTypeId,
                                  onChange: (value) {
                                    editDocumentController.docTypeId = value;
                                  },
                                  hintText: "Select Document Type",
                                  dropdownItems: editDocumentController.documentsTypeModel!.data!.map((items) {
                                    return DropdownMenuItem(
                                      value: items.id.toString(),
                                      child: Text(items.name ?? ""),
                                    );
                                  }).toList(),
                                ),
                          SizedBox(height: height * 0.02),
                          CommonRequiredText(width: width, text: StringUtils.attachment),
                          SizedBox(height: height * 0.01),
                          InkWell(
                            onTap: () {
                              editDocumentController.pickImage(context);
                            },
                            child: DottedBorder(
                              color: Colors.grey,
                              radius: const Radius.circular(10),
                              // strokeCap: StrokeCap.round,
                              strokeWidth: 2,
                              borderType: BorderType.RRect,
                              dashPattern: const [4],
                              child: Obx(() {
                                return Container(
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                    image: !editDocumentController.showFile.value
                                        ? DecorationImage(image: NetworkImage(editDocumentController.filePath))
                                        : DecorationImage(image: FileImage(File(editDocumentController.file!.path))),
                                  ),
                                );
                              }),
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
                            controller: editDocumentController.notesController,
                          ),
                          SizedBox(height: height * 0.02),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CommonButton(
                                textStyleConst: TextStyleConst.mediumTextStyle(ColorConst.whiteColor, width * 0.05),
                                onTap: () {
                                  editDocumentController.editDocuments(documentId);
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
                  );
          }),
        ),
      ),
    );
  }
}
