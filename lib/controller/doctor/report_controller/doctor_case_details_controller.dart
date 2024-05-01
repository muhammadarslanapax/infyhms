import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:infyhms_flutter/component/common_socket_exception.dart';
import 'package:infyhms_flutter/model/doctor/report_model/doctor_case_details_model.dart';
import 'package:infyhms_flutter/utils/preference_utils.dart';
import 'package:infyhms_flutter/utils/string_utils.dart';

class DoctorCaseDetailsController extends GetxController {
  DoctorCaseDetailsModel? doctorCaseDetailsModel;
  RxBool isGodDetails = false.obs;

  void getDoctorCaseDetails(String caseId) {
    StringUtils.client.getDoctorCaseDetails(PreferenceUtils.getStringValue("token"), caseId)
      ..then((value) {
        doctorCaseDetailsModel = value;
        if (doctorCaseDetailsModel!.success == true) {
          isGodDetails.value = true;
        }
      })
      ..onError((DioError error, stackTrace) {
        isGodDetails.value = true;
        CheckSocketException.checkSocketException(error);
        return DoctorCaseDetailsModel();
      });
  }
}
