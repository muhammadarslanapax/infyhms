import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:infyhms_flutter/controller/appointment_controller/appointment_controller.dart';
import 'package:infyhms_flutter/model/appointment_model/filter/filter_appointment_model.dart';
import 'package:infyhms_flutter/utils/preference_utils.dart';
import 'package:infyhms_flutter/utils/string_utils.dart';

class FilterAppointmentController extends GetxController {
  AppointmentController appointmentController = Get.put(AppointmentController());
  FilterAppointmentModel? filterAppointmentModel;
  RxBool isApiCall = false.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    if (appointmentController.currentIndex.value == 0) {
      StringUtils.client.getPastAppointments("Bearer ${PreferenceUtils.getStringValue("token")}", "past")
        ..then((value) {
          filterAppointmentModel = value;
          isApiCall.value = true;
        })
        ..onError((DioError error, stackTrace) {
          return FilterAppointmentModel();
        });
    }
  }
}
