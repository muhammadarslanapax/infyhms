import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:infyhms_flutter/component/common_socket_exception.dart';
import 'package:infyhms_flutter/model/doctor/doctor_diagnosis_test_model/delete_test_model.dart';
import 'package:infyhms_flutter/model/doctor/doctor_diagnosis_test_model/doctor_diagnosis_test_model.dart';
import 'package:infyhms_flutter/model/patient/diagnosis_model/diagnosis_test_model.dart';
import 'package:infyhms_flutter/utils/preference_utils.dart';
import 'package:infyhms_flutter/utils/string_utils.dart';

class DiagnosisTestController extends GetxController {
  DiagnosisTestModel? diagnosisTestModel;
  DoctorDiagnosisTestModel? doctorDiagnosisTestModel;
  RxBool isDiagnosisTestApiCall = false.obs;
  DeleteTestModel? deleteTestModel;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    PreferenceUtils.getBoolValue("isDoctor") ? getDoctorDiagnosisTest() : getDiagnosisTest();
  }

  void getDiagnosisTest() {
    StringUtils.client.getDiagnosisTest(PreferenceUtils.getStringValue("token"))
      ..then((value) {
        diagnosisTestModel = value;
        isDiagnosisTestApiCall.value = true;
      })
      ..onError((DioError error, stackTrace) {
        CheckSocketException.checkSocketException(error);
        return DiagnosisTestModel();
      });
  }

  void getDoctorDiagnosisTest() {
    StringUtils.client.getDoctorsDiagnosisTest(PreferenceUtils.getStringValue("token"))
      ..then((value) {
        doctorDiagnosisTestModel = value;
        isDiagnosisTestApiCall.value = true;
      })
      ..onError((DioError error, stackTrace) {
        CheckSocketException.checkSocketException(error);
        return DoctorDiagnosisTestModel();
      });
  }

  void deleteTest(int id) {
    isDiagnosisTestApiCall.value = false;
    StringUtils.client.deleteTest(PreferenceUtils.getStringValue("token"), id).then((value) {
      deleteTestModel = value;
      if (deleteTestModel!.success == true) {
        PreferenceUtils.getBoolValue("isDoctor") ? getDoctorDiagnosisTest() : getDiagnosisTest();
      }
    });
  }
}
