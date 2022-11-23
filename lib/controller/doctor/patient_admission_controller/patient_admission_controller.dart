import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:infyhms_flutter/component/common_socket_exception.dart';
import 'package:infyhms_flutter/model/doctor/patient_admission_model/delete_admission_model.dart';
import 'package:infyhms_flutter/model/doctor/patient_admission_model/patient_admission_model.dart';
import 'package:infyhms_flutter/utils/preference_utils.dart';
import 'package:infyhms_flutter/utils/string_utils.dart';

class PatientAdmissionController extends GetxController {
  PatientAdmissionModel? patientAdmissionModel;
  DeleteAdmissionModel? deleteAdmissionModel;
  RxBool isGotAdmission = false.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getPatientAdmission();
  }

  void getPatientAdmission() {
    StringUtils.client.getPatientAdmission(PreferenceUtils.getStringValue("token"))
      ..then((value) {
        patientAdmissionModel = value;
        if (patientAdmissionModel!.success == true) {
          isGotAdmission.value = true;
        }
      })
      ..onError((DioError error, stackTrace) {
        CheckSocketException.checkSocketException(error);
        return PatientAdmissionModel();
      });
  }

  void deleteAdmission(int id) {
    isGotAdmission.value = false;
    StringUtils.client.deleteAdmission(PreferenceUtils.getStringValue("token"), id)
      ..then((value) {
        deleteAdmissionModel = value;
        if (deleteAdmissionModel!.success == true) {
          getPatientAdmission();
        }
      })
      ..onError((DioError error, stackTrace) {
        getPatientAdmission();
        CheckSocketException.checkSocketException(error);
        return DeleteAdmissionModel();
      });
  }
}
