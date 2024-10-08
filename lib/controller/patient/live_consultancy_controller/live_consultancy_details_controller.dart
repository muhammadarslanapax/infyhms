import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:infyhms_flutter/component/common_socket_exception.dart';
import 'package:infyhms_flutter/model/doctor/doctor_live_consultations_model/doctor_live_consultations_details_model.dart';
import 'package:infyhms_flutter/model/patient/live_consultancy/live_consultation_details_model.dart';
import 'package:infyhms_flutter/utils/preference_utils.dart';
import 'package:infyhms_flutter/utils/string_utils.dart';

class LiveConsultancyDetailsController extends GetxController {
  LiveConsultationDetailsModel? liveConsultationDetailsModel;
  DoctorLiveConsultationsDetailsModel? doctorLiveConsultationsDetailsModel;
  RxBool gotDetailsOfConsultation = false.obs;

  getConsultationDetail(int consultationId){
    PreferenceUtils.getBoolValue("isDoctor") ? getDoctorDetailsOfConsultation(consultationId) : getDetailsOfConsultation(consultationId);
  }

  void getDetailsOfConsultation(int consultationId) {
    gotDetailsOfConsultation.value = false;
    StringUtils.client.liveConsultationData(PreferenceUtils.getStringValue("token"), consultationId)
      ..then((value) {
        liveConsultationDetailsModel = value;
        gotDetailsOfConsultation.value = true;
      })
      ..onError((DioError error, stackTrace) {
        CheckSocketException.checkSocketException(error);
        return LiveConsultationDetailsModel();
      });
  }

  void getDoctorDetailsOfConsultation(int consultationId) {
    StringUtils.client.liveDoctorConsultationData(PreferenceUtils.getStringValue("token"), consultationId)
      ..then((value) {
        doctorLiveConsultationsDetailsModel = value;
        gotDetailsOfConsultation.value = true;
      })
      ..onError((DioError error, stackTrace) {
        CheckSocketException.checkSocketException(error);
        return DoctorLiveConsultationsDetailsModel();
      });
  }
}
