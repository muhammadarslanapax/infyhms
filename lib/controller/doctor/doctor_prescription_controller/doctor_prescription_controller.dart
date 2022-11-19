import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:infyhms_flutter/component/common_socket_exception.dart';
import 'package:infyhms_flutter/model/doctor/doctor_prescription_model/doctor_prescription_model.dart';
import 'package:infyhms_flutter/utils/preference_utils.dart';
import 'package:infyhms_flutter/utils/string_utils.dart';

class DoctorPrescriptionController extends GetxController {
  RxBool isGetPrescription = false.obs;
  DoctorPrescriptionModel? doctorPrescriptionModel;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getDoctorPrescription();
  }

  void getDoctorPrescription() {
    StringUtils.client.getDoctorsPrescription(PreferenceUtils.getStringValue("token"))
      ..then((value) {
        doctorPrescriptionModel = value;
        isGetPrescription.value = true;
      })
      ..onError((DioError error, stackTrace) {
        CheckSocketException.checkSocketException(error);
        return DoctorPrescriptionModel();
      });
  }
}
