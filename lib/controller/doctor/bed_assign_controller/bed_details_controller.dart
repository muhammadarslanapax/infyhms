import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:infyhms_flutter/component/common_socket_exception.dart';
import 'package:infyhms_flutter/model/doctor/bed_assign_model/bed_details_model.dart';
import 'package:infyhms_flutter/utils/preference_utils.dart';
import 'package:infyhms_flutter/utils/string_utils.dart';

class BedDetailsController extends GetxController {
  BedDetailsModel? bedDetailsModel;
  RxBool isBedDetailsApiCalled = false.obs;

  void getBedDetails(String id) {
    StringUtils.client.getBedDataDetails(PreferenceUtils.getStringValue("token"), id)
      ..then((value) {
        bedDetailsModel = value;
        isBedDetailsApiCalled.value = true;
      })
      ..onError((DioError error, stackTrace) {
        bedDetailsModel = BedDetailsModel(data: null);
        isBedDetailsApiCalled.value = true;
        CheckSocketException.checkSocketException(error);
        return BedDetailsModel();
      });
  }
}
