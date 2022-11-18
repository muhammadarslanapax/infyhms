import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:infyhms_flutter/component/common_socket_exception.dart';
import 'package:infyhms_flutter/model/patient/admission_model/admission_model.dart';
import 'package:infyhms_flutter/utils/preference_utils.dart';
import 'package:infyhms_flutter/utils/string_utils.dart';

class AdmissionController extends GetxController {
  AdmissionModel? admissionModel;
  RxBool isGetAdmission = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    StringUtils.client.getAdmission(PreferenceUtils.getStringValue("token")).then((value) {
      admissionModel = value;
      isGetAdmission.value = true;
    }).onError((DioError error, stackTrace) {
      CheckSocketException.checkSocketException(error);
    });
  }
}
