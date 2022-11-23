import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:infyhms_flutter/component/common_socket_exception.dart';
import 'package:infyhms_flutter/controller/appointment_controller/appointment_controller.dart';
import 'package:infyhms_flutter/model/patient/appointment_model/cancel_appointment/cancel_appointment_model.dart';
import 'package:infyhms_flutter/model/patient/appointment_model/delete_appointment/delete_appointment_model.dart';
import 'package:infyhms_flutter/model/patient/appointment_model/filter/filter_appointment_model.dart';
import 'package:infyhms_flutter/utils/preference_utils.dart';
import 'package:infyhms_flutter/utils/string_utils.dart';

class FilterAppointmentController extends GetxController {
  AppointmentController appointmentController = Get.put(AppointmentController());
  FilterAppointmentModel? filterAppointmentModel;
  CancelAppointmentModel? cancelAppointmentModel;
  DeleteAppointmentModel? deleteAppointmentModel;
  RxBool isApiCall = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    if (PreferenceUtils.getBoolValue("isDoctor") == false) {
      if (appointmentController.currentIndex.value == 0) {
        getAppointment("past");
      }
    }
  }

  void changeIndex(int index) {
    isApiCall.value = false;
    switch (index) {
      case 0:
        appointmentController.currentIndex.value = 0;
        getAppointment("past");
        break;
      case 1:
        appointmentController.currentIndex.value = 1;
        getAppointment("pending");
        break;
      case 2:
        appointmentController.currentIndex.value = 2;
        getAppointment("cancelled");
        break;
      case 3:
        appointmentController.currentIndex.value = 3;
        getAppointment("completed");
        break;
    }
  }

  void getAppointment(String filter) {
    StringUtils.client.getPastAppointments(PreferenceUtils.getStringValue("token"), filter).then((value) {
      filterAppointmentModel = value;
      isApiCall.value = true;
    }).onError((DioError error, stackTrace) {
      CheckSocketException.checkSocketException(error);
    });
  }

  void deleteAppointment(int id) {
    isApiCall.value = false;
    StringUtils.client.deleteAppointment(PreferenceUtils.getStringValue("token"), id)
      ..then((value) {
        deleteAppointmentModel = value;
        if (deleteAppointmentModel!.success == true) {
          switch (appointmentController.currentIndex.value) {
            case 0:
              appointmentController.currentIndex.value = 0;
              getAppointment("past");
              break;
            case 2:
              appointmentController.currentIndex.value = 2;
              getAppointment("cancelled");
              break;
            case 3:
              appointmentController.currentIndex.value = 3;
              getAppointment("completed");
              break;
          }
        }
        Get.back();
      })
      ..onError((DioError error, stackTrace) {
        CheckSocketException.checkSocketException(error);
        return DeleteAppointmentModel();
      });
  }

  void cancelledPendingAppointment(int id) {
    isApiCall.value = false;
    StringUtils.client.cancelAppointment(PreferenceUtils.getStringValue("token"), id)
      ..then((value) {
        cancelAppointmentModel = value;
        if (cancelAppointmentModel!.success == true) {
          appointmentController.currentIndex.value = 1;
          getAppointment("pending");
        }
        Get.back();
      })
      ..onError((DioError error, stackTrace) {
        Get.back();
        CheckSocketException.checkSocketException(error);
        return CancelAppointmentModel();
      });
  }

  void deletePendingAppointment(int id) {
    isApiCall.value = false;
    StringUtils.client.deleteAppointment(PreferenceUtils.getStringValue("token"), id)
      ..then((value) {
        deleteAppointmentModel = value;
        if (deleteAppointmentModel!.success == true) {
          appointmentController.currentIndex.value = 1;
          getAppointment("pending");
        }
        Get.back();
      })
      ..onError((DioError error, stackTrace) {
        CheckSocketException.checkSocketException(error);
        return DeleteAppointmentModel();
      });
  }
}
