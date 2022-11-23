import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:infyhms_flutter/component/common_socket_exception.dart';
import 'package:infyhms_flutter/model/patient/live_consultancy/live_consultation_details_model.dart';
import 'package:infyhms_flutter/utils/preference_utils.dart';
import 'package:infyhms_flutter/utils/string_utils.dart';

class LiveConsultancyDetailsController extends GetxController {
  Rx<LiveConsultationDetailsModel?> liveConsultationDetailsModel = LiveConsultationDetailsModel().obs;
  RxBool gotDetailsOfConsultation = false.obs;
  int consultationId = Get.arguments;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getDetailsOfConsultation();
  }

  void getDetailsOfConsultation() {
    gotDetailsOfConsultation.value = false;
    StringUtils.client.liveConsultationData(PreferenceUtils.getStringValue("token"), consultationId).then((value) {
      liveConsultationDetailsModel.value = value;
      gotDetailsOfConsultation.value = true;
    }).onError((DioError error, stackTrace) {
      CheckSocketException.checkSocketException(error);
    });
  }
}
