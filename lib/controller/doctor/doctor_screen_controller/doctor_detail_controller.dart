import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:infyhms_flutter/component/common_socket_exception.dart';
import 'package:infyhms_flutter/model/doctor/doctor_model/doctor_detail_model.dart';
import 'package:infyhms_flutter/utils/preference_utils.dart';
import 'package:infyhms_flutter/utils/string_utils.dart';

class DoctorDetailController extends GetxController {
  DoctorsDetailModel? doctorsDetailModel;
  RxBool isGetDetail = false.obs;

  void getDoctorDetail(int id) {
    StringUtils.client.getDoctorsDetail(PreferenceUtils.getStringValue("token"), id)
      ..then((value) {
        doctorsDetailModel = value;
        isGetDetail.value = true;
      })
      ..onError((DioError error, stackTrace) {
        CheckSocketException.checkSocketException(error);
        return DoctorsDetailModel();
      });
  }
}
