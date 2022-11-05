import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infyhms_flutter/model/appointment_model/create_appointment/create_appointment_model.dart';
import 'package:infyhms_flutter/model/appointment_model/new_appointment/doctor_department_model.dart';
import 'package:infyhms_flutter/model/appointment_model/new_appointment/get_doctor_model.dart';
import 'package:infyhms_flutter/model/appointment_model/slot_booking/slot_booking_model.dart';
import 'package:infyhms_flutter/utils/preference_utils.dart';
import 'package:infyhms_flutter/utils/string_utils.dart';

class NewAppointmentController extends GetxController {
  final TextEditingController doctorController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  DoctorDepartmentModel? doctorDepartmentModel;
  SlotBookingModel? slotBookingModel;
  GetDoctorModel? getDoctorModel;
  CreateAppointmentModel? createAppointmentModel;

  String doctorId = "";
  String? departmentId;
  String? selectedDate;
  String? selectedTime;

  int currentIndex = 0;

  bool isSelectDate = false;
  bool isSelectDoctorDepartment = false;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    StringUtils.client.getDoctorDepartment("Bearer ${PreferenceUtils.getStringValue("token")}").then((value) {
      doctorDepartmentModel = value;
      update();
    });
  }

  Future getDoctorName(int id) async {
    await StringUtils.client.getDoctor("Bearer ${PreferenceUtils.getStringValue("token")}", id).then((value) {
      getDoctorModel = value;
      doctorId = value.data![0].id.toString();
      update();
    });
  }

  Future<void> selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      selectedDate = "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
      dateController.text = selectedDate!;
    }
  }
}
