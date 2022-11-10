import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infyhms_flutter/constant/color_const.dart';
import 'package:infyhms_flutter/constant/text_style_const.dart';
import 'package:infyhms_flutter/controller/admission_controller/admission_controller.dart';
import 'package:infyhms_flutter/screens/admission/admission_detail_screen.dart';

class AdmissionScreen extends StatelessWidget {
  AdmissionScreen({Key? key}) : super(key: key);
  final AdmissionController admissionController = Get.put(AdmissionController());

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Obx(
      () => admissionController.isGetAdmission.value == true
          ? admissionController.admissionModel!.data!.isEmpty
              ? Center(
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
                  color: Colors.white,
                  child: ListView.builder(
                    itemCount: admissionController.admissionModel!.data!.length,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          ListTile(
                            contentPadding: EdgeInsets.only(top: index == 0 ? 15 : 10, left: 15, right: 15),
                            onTap: () {
                              Get.to(
                                () => AdmissionDetailScreen(
                                  dischargeTime: admissionController.admissionModel!.data![index].discharge_time!,
                                  admissionTime: admissionController.admissionModel!.data![index].admission_time!,
                                  admissionDate: admissionController.admissionModel!.data![index].admission_date!,
                                  admissionId: admissionController.admissionModel!.data![index].patient_admission_id!,
                                  agentName: admissionController.admissionModel!.data![index].insurance_detail!.agent_name!,
                                  bed: admissionController.admissionModel!.data![index].bed_id!,
                                  createOn: admissionController.admissionModel!.data![index].created_on!,
                                  dischargeDate: admissionController.admissionModel!.data![index].discharge_time!,
                                  doctor: admissionController.admissionModel!.data![index].doctor_name!,
                                  guardianAddress: admissionController.admissionModel!.data![index].guardian_address!,
                                  guardianContact: admissionController.admissionModel!.data![index].guardian_contact!,
                                  guardianName: admissionController.admissionModel!.data![index].guardian_name!,
                                  guardianRelation: admissionController.admissionModel!.data![index].guardian_relation!,
                                  insuranceName: admissionController.admissionModel!.data![index].insurance_detail!.insurance_name!,
                                  packageName: admissionController.admissionModel!.data![index].insurance_detail!.package_name!,
                                  policyNo: admissionController.admissionModel!.data![index].insurance_detail!.policy_no!,
                                ),
                                transition: Transition.rightToLeft,
                              );
                            },
                            title: Padding(
                              padding: const EdgeInsets.only(bottom: 3),
                              child: Text(
                                admissionController.admissionModel!.data![index].doctor_name!,
                                style: TextStyleConst.mediumTextStyle(
                                  ColorConst.blackColor,
                                  width * 0.045,
                                ),
                              ),
                            ),
                            subtitle: Text(
                              "${admissionController.admissionModel!.data![index].patient_admission_id!}  |  ${admissionController.admissionModel!.data![index].admission_time!} - ${admissionController.admissionModel!.data![index].admission_date!}",
                              style: TextStyleConst.mediumTextStyle(
                                ColorConst.hintGreyColor,
                                width * 0.037,
                              ),
                            ),
                            leading: Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(admissionController.admissionModel!.data![index].doctor_image!),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
