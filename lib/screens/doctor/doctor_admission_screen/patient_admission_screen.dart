import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:infyhms_flutter/component/common_button.dart';
import 'package:infyhms_flutter/constant/color_const.dart';
import 'package:infyhms_flutter/constant/text_style_const.dart';
import 'package:infyhms_flutter/controller/doctor/patient_admission_controller/patient_admission_controller.dart';
import 'package:infyhms_flutter/screens/doctor/doctor_admission_screen/patient_details.dart';
import 'package:infyhms_flutter/utils/image_utils.dart';
import 'package:infyhms_flutter/utils/string_utils.dart';

class PatientAdmission extends StatelessWidget {
  PatientAdmission({Key? key}) : super(key: key);
  final PatientAdmissionController patientAdmissionController = Get.put(PatientAdmissionController());
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Obx(() {
      return patientAdmissionController.isGotAdmission.value == false
          ? const Center(child: CircularProgressIndicator())
          : patientAdmissionController.patientAdmissionModel!.data!.isEmpty
              ? Container(
                  color: ColorConst.whiteColor,
                  child: Center(
                    child: Text(
                      "No admission found",
                      style: TextStyleConst.mediumTextStyle(
                        ColorConst.blackColor,
                        width * 0.04,
                      ),
                    ),
                  ),
                )
              : Container(
                  color: ColorConst.whiteColor,
                  child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: patientAdmissionController.patientAdmissionModel!.data!.length,
                      itemBuilder: (context, index) {
                        return Slidable(
                          endActionPane: ActionPane(
                            extentRatio: 0.25,
                            motion: const ScrollMotion(),
                            children: [
                              SlidableAction(
                                onPressed: (context) {
                                  showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (context) {
                                      return Center(
                                        child: Container(
                                          height: height / 2.7,
                                          width: width / 1.12,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(15),
                                            color: Colors.white,
                                          ),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                height: 60,
                                                width: 60,
                                                decoration: const BoxDecoration(
                                                  image: DecorationImage(
                                                    image: AssetImage(ImageUtils.deleteIcon),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: height * 0.03),
                                              Text(
                                                "Delete",
                                                style: TextStyleConst.boldTextStyle(
                                                  ColorConst.blackColor,
                                                  width * 0.05,
                                                ),
                                              ),
                                              SizedBox(height: height * 0.01),
                                              Text(
                                                "Are you sure want to delete this\n appointment?",
                                                textAlign: TextAlign.center,
                                                style: TextStyleConst.mediumTextStyle(
                                                  ColorConst.hintGreyColor,
                                                  width * 0.042,
                                                ),
                                              ),
                                              SizedBox(height: height * 0.03),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  CommonButton(
                                                    textStyleConst: TextStyleConst.mediumTextStyle(
                                                      ColorConst.whiteColor,
                                                      width * 0.05,
                                                    ),
                                                    onTap: () {
                                                      Get.back();
                                                      patientAdmissionController.deleteAdmission(
                                                        patientAdmissionController.patientAdmissionModel!.data![index].id!,
                                                      );
                                                    },
                                                    color: ColorConst.blueColor,
                                                    text: StringUtils.delete,
                                                    width: width / 2.5,
                                                    height: 50,
                                                  ),
                                                  CommonButton(
                                                    textStyleConst: TextStyleConst.mediumTextStyle(
                                                      ColorConst.hintGreyColor,
                                                      width * 0.05,
                                                    ),
                                                    onTap: () {
                                                      Get.back();
                                                    },
                                                    color: ColorConst.borderGreyColor,
                                                    text: StringUtils.cancel,
                                                    width: width / 2.5,
                                                    height: 50,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                backgroundColor: const Color(0xFFFCE5E5),
                                foregroundColor: ColorConst.redColor,
                                label: StringUtils.delete,
                              ),
                            ],
                          ),
                          child: ListTile(
                            onTap: () {
                              Get.to(
                                () => PatientAdmissionDetailsScreen(),
                                transition: Transition.rightToLeft,
                                arguments: patientAdmissionController.patientAdmissionModel!.data![index].id!,
                              );
                            },
                            contentPadding: EdgeInsets.only(top: index == 0 ? 10 : 0, right: 15, left: 15),
                            leading: Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(patientAdmissionController.patientAdmissionModel!.data![index].patient_image!),
                                ),
                              ),
                            ),
                            title: Text(
                              patientAdmissionController.patientAdmissionModel!.data![index].patient_name!,
                              style: TextStyleConst.mediumTextStyle(
                                ColorConst.blackColor,
                                width * 0.045,
                              ),
                            ),
                            subtitle: Row(
                              children: [
                                Text(
                                  patientAdmissionController.patientAdmissionModel!.data![index].admission_id!,
                                  style: TextStyleConst.mediumTextStyle(
                                    ColorConst.hintGreyColor,
                                    width * 0.036,
                                  ),
                                ),
                                Text(
                                  " | ",
                                  style: TextStyleConst.mediumTextStyle(
                                    ColorConst.primaryColor,
                                    width * 0.036,
                                  ),
                                ),
                                Flexible(
                                  child: Text(
                                    "${patientAdmissionController.patientAdmissionModel!.data![index].admission_time!} ${patientAdmissionController.patientAdmissionModel!.data![index].admission_date!}",
                                    style: TextStyleConst.mediumTextStyle(
                                      ColorConst.hintGreyColor,
                                      width * 0.036,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                );
    });
  }
}
