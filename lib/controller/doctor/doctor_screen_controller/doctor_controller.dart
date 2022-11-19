import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:infyhms_flutter/component/common_socket_exception.dart';
import 'package:infyhms_flutter/model/doctor/doctor_model/doctor_model.dart';
import 'package:infyhms_flutter/utils/preference_utils.dart';
import 'package:infyhms_flutter/utils/string_utils.dart';

class DoctorScreenController extends GetxController {
  DoctorsModel? doctorsModel;
  RxBool isGetDoctor = false.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getDoctors();
  }

  void getDoctors() {
    StringUtils.client.getDoctors(PreferenceUtils.getStringValue("token"))
      ..then((value) {
        doctorsModel = value;
        isGetDoctor.value = true;
      })
      ..onError((DioError error, stackTrace) {
        CheckSocketException.checkSocketException(error);
        return DoctorsModel();
      });
  }
}
