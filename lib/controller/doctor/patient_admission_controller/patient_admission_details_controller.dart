import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:infyhms_flutter/component/common_socket_exception.dart';
import 'package:infyhms_flutter/model/doctor/patient_admission_model/patient_admission_details_model.dart';
import 'package:infyhms_flutter/utils/preference_utils.dart';
import 'package:infyhms_flutter/utils/string_utils.dart';

class PatientAdmissionDetailsController extends GetxController {
  PatientAdmissionDetailsModel? patientAdmissionDetailsModel;
  RxBool isGotDetails = false.obs;
  int id = Get.arguments;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getPatientAdmissionDetails();
  }

  void getPatientAdmissionDetails() {
    StringUtils.client.getPatientAdmissionDetails(PreferenceUtils.getStringValue("token"), id)
      ..then((value) {
        patientAdmissionDetailsModel = value;
        isGotDetails.value = true;
      })
      ..onError((DioError error, stackTrace) {
        isGotDetails.value = true;
        CheckSocketException.checkSocketException(error);
        return PatientAdmissionDetailsModel();
      });
  }
}
