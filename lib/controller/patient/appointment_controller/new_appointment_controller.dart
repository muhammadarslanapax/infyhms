import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infyhms_flutter/component/common_loader.dart';
import 'package:infyhms_flutter/component/common_snackbar.dart';
import 'package:infyhms_flutter/component/common_socket_exception.dart';
import 'package:infyhms_flutter/model/patient/appointment_model/create_appointment/create_appointment_model.dart';
import 'package:infyhms_flutter/model/patient/appointment_model/doctor/doctor_department_model.dart';
import 'package:infyhms_flutter/model/patient/appointment_model/doctor/get_doctor_model.dart';
import 'package:infyhms_flutter/model/patient/appointment_model/slot_booking/slot_booking_model.dart';
import 'package:infyhms_flutter/utils/preference_utils.dart';
import 'package:infyhms_flutter/utils/string_utils.dart';
import 'package:infyhms_flutter/utils/variable_utils.dart';

class NewAppointmentController extends GetxController {
  final TextEditingController doctorController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  DoctorDepartmentModel? doctorDepartmentModel;
  SlotBookingModel? slotBookingModel;
  GetDoctorModel? getDoctorModel;
  CreateAppointmentModel? createAppointmentModel;
  DateTime? oldValue;

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
    StringUtils.client.getDoctorDepartment(PreferenceUtils.getStringValue("token"))
      ..then((value) {
        doctorDepartmentModel = value;
        update();
      })
      ..onError((DioError error, stackTrace) {
        CheckSocketException.checkSocketException(error);
        return DoctorDepartmentModel();
      });
  }

  getDoctorName(int id) {
    StringUtils.client.getDoctor(PreferenceUtils.getStringValue("token"), id)
      ..then((value) {
        getDoctorModel = value;
        doctorId = value.data![0].id.toString();
        isSelectDoctor = true;
        isSelectDoctorDepartment = true;
        update();
      })
      ..onError((DioError error, stackTrace) {
        CheckSocketException.checkSocketException(error);
        return GetDoctorModel();
      });
  }

  Future<void> selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: oldValue ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      oldValue = picked;
      selectedDate = "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
      dateController.text = selectedDate!;
    }
  }

  selectDateApiCall(BuildContext context) {
    if (isSelectDoctor) {
      selectDate(context).then((value) async {
        if (selectedDate != null) {
          await StringUtils.client.getBookingSlotDate(PreferenceUtils.getStringValue("token"), selectedDate!, doctorId).then((value) {
            slotBookingModel = value;
            isSelectDate = true;
            if (slotBookingModel!.data!.bookingSlotArr!.isNotEmpty) {
              selectedTime = slotBookingModel!.data!.bookingSlotArr![0];
            }
            update();
          }).onError((DioError error, stackTrace) {
            CheckSocketException.checkSocketException(error);
          });
        }
      });
    }
  }

  createNewAppointment() {
    if (isSelectDoctorDepartment == false) {
      DisplaySnackBar.displaySnackBar("Please select doctor department");
    } else if (isSelectDate == false) {
      DisplaySnackBar.displaySnackBar("Please select date");
    } else if (isSelectDoctor == false) {
      DisplaySnackBar.displaySnackBar("Please select doctor");
    } else if (slotBookingModel!.data!.bookingSlotArr!.isEmpty) {
      DisplaySnackBar.displaySnackBar("Please select other date");
    } else {
      CommonLoader.showLoader();
      StringUtils.client.createAppointment(
        PreferenceUtils.getStringValue("token"),
        departmentId!,
        doctorId,
        selectedDate!,
        selectedTime!,
        VariableUtils.patientId.value,
      )
        ..then((value) {
          createAppointmentModel = value;
          Get.back();
          if (value.success == true) {
            Get.back();
            DisplaySnackBar.displaySnackBar(value.message!);
          }
        })
        ..onError((DioError error, stackTrace) {
          Get.back();
          CheckSocketException.checkSocketException(error);
          return CreateAppointmentModel();
        });
    }
  }
}
