import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infyhms_flutter/component/common_snackbar.dart';
import 'package:infyhms_flutter/model/appointment_model/create_appointment/create_appointment_model.dart';
import 'package:infyhms_flutter/model/appointment_model/doctor/doctor_department_model.dart';
import 'package:infyhms_flutter/model/appointment_model/doctor/get_doctor_model.dart';
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
  bool isSelectDoctor = false;

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
      isSelectDoctor = true;
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

  selectDateApiCall(BuildContext context) {
    if (isSelectDoctor) {
      selectDate(context).then((value) async {
        if (selectedDate != null) {
          await StringUtils.client.getBookingSlotDate("Bearer ${PreferenceUtils.getStringValue("token")}", selectedDate!, doctorId).then((value) {
            slotBookingModel = value;
            isSelectDate = true;
            if (slotBookingModel!.data!.bookingSlotArr!.isNotEmpty) {
              selectedTime = slotBookingModel!.data!.bookingSlotArr![0];
            }
            update();
          });
        }
      });
    }
  }

  createNewAppointment(BuildContext context) {
    if (isSelectDoctorDepartment == false) {
      DisplaySnackBar.displaySnackBar(context, "Please select doctor department");
    } else if (isSelectDate == false) {
      DisplaySnackBar.displaySnackBar(context, "Please select date");
    } else if (isSelectDoctor == false) {
      DisplaySnackBar.displaySnackBar(context, "Please select doctor");
    } else if (slotBookingModel!.data!.bookingSlotArr!.isEmpty) {
      DisplaySnackBar.displaySnackBar(context, "Please select other date");
    } else {
      StringUtils.client
          .createAppointment("Bearer ${PreferenceUtils.getStringValue("token")}", departmentId!, doctorId, selectedDate!, selectedTime!)
          .then((value) {
        createAppointmentModel = value;
        if (value.success == true) {
          DisplaySnackBar.displaySnackBar(context, value.message!);
          Get.back();
        }
      });
    }
  }
}
