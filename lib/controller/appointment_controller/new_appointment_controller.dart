import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infyhms_flutter/model/appointment_model/new_appointment/doctor_department_model.dart';
import 'package:infyhms_flutter/model/appointment_model/new_appointment/get_doctor_model.dart';
import 'package:infyhms_flutter/utils/preference_utils.dart';
import 'package:infyhms_flutter/utils/string_utils.dart';

class NewAppointmentController extends GetxController {
  DoctorDepartmentModel? doctorDepartmentModel;
  GetDoctorModel? getDoctorModel;
  bool isSelectDoctorDepartment = false;

  RxString doctorValue = "".obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    StringUtils.client.getDoctorDepartment("Bearer ${PreferenceUtils.getStringValue("token")}").then((value) {
      doctorDepartmentModel = value;
      update();
    });
  }

  final TextEditingController doctorController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  Future getDoctorName(int id) async {
    doctorValue.value = "";

    StringUtils.client.getDoctor("Bearer ${PreferenceUtils.getStringValue("token")}", id).then((value) {
      getDoctorModel = value;

      update();
    });
  }
}
