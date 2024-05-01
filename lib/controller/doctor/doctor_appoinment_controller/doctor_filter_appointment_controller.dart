import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:infyhms_flutter/component/common_socket_exception.dart';
import 'package:infyhms_flutter/controller/doctor/doctor_appoinment_controller/doctor_appoinment_controller.dart';
import 'package:infyhms_flutter/model/doctor/doctor_appointment_model/confirm_appointment_model.dart';
import 'package:infyhms_flutter/model/doctor/doctor_appointment_model/doctor_appointment_model.dart';
import 'package:infyhms_flutter/utils/preference_utils.dart';
import 'package:infyhms_flutter/utils/string_utils.dart';

class DoctorFilterAppointmentController extends GetxController {
  DoctorAppointmentController doctorAppointmentController = Get.put(DoctorAppointmentController());
  DoctorAppointmentModel? doctorAppointmentModel;
  ConfirmAppointmentModel? confirmAppointmentModel;

  RxBool isDoctorFilterApiCall = false.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    if (PreferenceUtils.getBoolValue("isDoctor") == true) {
      if (doctorAppointmentController.currentIndex.value == 0) {
        getPendingAppointment();
      }
    }
  }

  void getPendingAppointment() {
    StringUtils.client.getDoctorAppointments(PreferenceUtils.getStringValue("token"), "pending")
      ..then((value) {
        doctorAppointmentModel = value;
        isDoctorFilterApiCall.value = true;
      })
      ..onError((DioError error, stackTrace) {
        CheckSocketException.checkSocketException(error);
        return DoctorAppointmentModel();
      });
  }

  void getCancelledAppointment() {
    StringUtils.client.getDoctorAppointments(PreferenceUtils.getStringValue("token"), "cancelled")
      ..then((value) {
        doctorAppointmentModel = value;
        isDoctorFilterApiCall.value = true;
      })
      ..onError((DioError error, stackTrace) {
        CheckSocketException.checkSocketException(error);
        return DoctorAppointmentModel();
      });
  }

  void getCompletedAppointment() {
    StringUtils.client.getDoctorAppointments(PreferenceUtils.getStringValue("token"), "completed")
      ..then((value) {
        doctorAppointmentModel = value;
        isDoctorFilterApiCall.value = true;
      })
      ..onError((DioError error, stackTrace) {
        CheckSocketException.checkSocketException(error);
        return DoctorAppointmentModel();
      });
  }

  void changeDoctorIndex(int index) {
    isDoctorFilterApiCall.value = false;
    switch (index) {
      case 0:
        doctorAppointmentController.currentIndex.value = 0;
        getPendingAppointment();
        break;
      case 1:
        doctorAppointmentController.currentIndex.value = 1;
        getCancelledAppointment();
        break;
      case 2:
        doctorAppointmentController.currentIndex.value = 2;
        getCompletedAppointment();
        break;
    }
  }

  void confirmAppointment(int id) {

    isDoctorFilterApiCall.value = false;
    StringUtils.client.confirmAppointment(PreferenceUtils.getStringValue("token"), id)
      ..then((value) {
        confirmAppointmentModel = value;
        if (confirmAppointmentModel!.success == true) {
          getPendingAppointment();
        }
      })
      ..onError((DioError error, stackTrace) {
        CheckSocketException.checkSocketException(error);
        return ConfirmAppointmentModel();
      });
  }
}
