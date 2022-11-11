import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:infyhms_flutter/component/common_snackbar.dart';
import 'package:infyhms_flutter/component/common_socket_exception.dart';
import 'package:infyhms_flutter/model/live_consultancy/live_consultation_details_model.dart';
import 'package:infyhms_flutter/model/live_consultancy/live_consultation_filter.dart';
import 'package:infyhms_flutter/utils/preference_utils.dart';
import 'package:infyhms_flutter/utils/string_utils.dart';
import 'package:url_launcher/url_launcher.dart';

class LiveConsultationsController extends GetxController {
  RxList consultationsStatus = ["All", "Awaited", "Cancelled", "Finished"].obs;
  RxInt currentIndex = 0.obs;
  Rx<LiveConsultationFilter?> liveConsultationFilter = LiveConsultationFilter().obs;
  Rx<LiveConsultationDetailsModel?> liveConsultationDetailsModel = LiveConsultationDetailsModel().obs;
  RxBool gotConsultationData = false.obs;
  RxBool gotDetailsOfConsultation = false.obs;

  void launchConsultationURL(context, String url) {
    try {
      launchUrl(Uri.parse(url));
    } catch (e) {
      DisplaySnackBar.displaySnackBar(context, "Can't launch URL");
    }
  }

  void getDetailsOfConsultation(int consultationId) {
    gotDetailsOfConsultation.value = false;
    StringUtils.client.liveConsultationData("Bearer ${PreferenceUtils.getStringValue("token")}", consultationId).then((value) {
      liveConsultationDetailsModel.value = value;
      gotDetailsOfConsultation.value = true;
    }).onError((DioError error, stackTrace) {
      CheckSocketException.checkSocketException(error);
    });
  }

  void changeIndex(int index) {
    gotConsultationData.value = false;
    switch (index) {
      case 0:
        currentIndex.value = 0;
        getConsultancy("all");
        break;
      case 1:
        currentIndex.value = 1;
        getConsultancy("awaited");
        break;
      case 2:
        currentIndex.value = 2;
        getConsultancy("cancelled");
        break;
      case 3:
        currentIndex.value = 3;
        getConsultancy("finished");
        break;
    }
  }

  void getConsultancy(String status) {
    StringUtils.client.liveConsultationFilter("Bearer ${PreferenceUtils.getStringValue("token")}", status).then((value) {
      liveConsultationFilter.value = value;
      gotConsultationData.value = true;
    }).onError((DioError error, stackTrace) {
      liveConsultationFilter.value = LiveConsultationFilter();
      gotConsultationData.value = true;
      CheckSocketException.checkSocketException(error);
    });
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getConsultancy("all");
  }
}
