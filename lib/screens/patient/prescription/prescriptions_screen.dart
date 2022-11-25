import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infyhms_flutter/constant/color_const.dart';
import 'package:infyhms_flutter/constant/text_style_const.dart';
import 'package:infyhms_flutter/controller/patient/prescription_controller/prescription_controller.dart';
import 'package:infyhms_flutter/screens/patient/prescription/prescription_detail_screen.dart';

class PrescriptionsScreen extends StatelessWidget {
  PrescriptionsScreen({Key? key}) : super(key: key);
  final PrescriptionController prescriptionController = Get.put(PrescriptionController());

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Obx(
      () => prescriptionController.isGetPrescription.value == true
          ? prescriptionController.prescriptionsModel!.data!.isEmpty
              ? Container(
                  color: ColorConst.whiteColor,
                  child: Center(
                    child: Text(
                      "No prescription found",
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
                    itemCount: prescriptionController.prescriptionsModel!.data!.length,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          ListTile(
                            contentPadding: EdgeInsets.only(top: index == 0 ? 15 : 10, left: 15, right: 15),
                            onTap: () {
                              Get.to(
                                () => PrescriptionsDetailScreen(
                                  accident: prescriptionController.prescriptionsModel!.data![index].accident!,
                                  breastFeeding: prescriptionController.prescriptionsModel!.data![index].breast_feeding!,
                                  currentMedication: prescriptionController.prescriptionsModel!.data![index].current_medication!,
                                  diabetes: prescriptionController.prescriptionsModel!.data![index].diabetic!,
                                  doctorName: prescriptionController.prescriptionsModel!.data![index].doctor_name!,
                                  femalePregnancy: prescriptionController.prescriptionsModel!.data![index].female_pregnancy!,
                                  foodAllergies: prescriptionController.prescriptionsModel!.data![index].food_allergies!,
                                  healthInsurance: prescriptionController.prescriptionsModel!.data![index].health_insurance!,
                                  heartDisease: prescriptionController.prescriptionsModel!.data![index].heart_disease!,
                                  highBloodPressure: prescriptionController.prescriptionsModel!.data![index].high_blood_pressure!,
                                  lowIncome: prescriptionController.prescriptionsModel!.data![index].low_income!,
                                  medicalHistory: prescriptionController.prescriptionsModel!.data![index].medical_history!,
                                  others: prescriptionController.prescriptionsModel!.data![index].others!,
                                  reference: prescriptionController.prescriptionsModel!.data![index].reference!,
                                  surgery: prescriptionController.prescriptionsModel!.data![index].surgery!,
                                  tendencyBleed: prescriptionController.prescriptionsModel!.data![index].tendency_bleed!,
                                ),
                                transition: Transition.rightToLeft,
                              );
                            },
                            title: Padding(
                              padding: const EdgeInsets.only(bottom: 3),
                              child: Text(
                                prescriptionController.prescriptionsModel!.data![index].doctor_name!,
                                style: TextStyleConst.mediumTextStyle(
                                  ColorConst.blackColor,
                                  width * 0.045,
                                ),
                              ),
                            ),
                            subtitle: Text(
                              "${prescriptionController.prescriptionsModel!.data![index].created_time!} - ${prescriptionController.prescriptionsModel!.data![index].created_date!}",
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
                                  image: NetworkImage(prescriptionController.prescriptionsModel!.data![index].doctor_image!),
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
