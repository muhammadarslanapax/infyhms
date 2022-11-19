import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:infyhms_flutter/component/common_socket_exception.dart';
import 'package:infyhms_flutter/model/doctor/doctor_model/doctor_detail_model.dart';
import 'package:infyhms_flutter/utils/preference_utils.dart';
import 'package:infyhms_flutter/utils/string_utils.dart';

class DoctorDetailController extends GetxController {
  DoctorsDetailModel? doctorsDetailModel;
  int id = Get.arguments;
  RxBool isGetDetail = false.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getDoctorDetail();
  }

  void getDoctorDetail() {
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
