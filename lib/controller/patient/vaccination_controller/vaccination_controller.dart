import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:infyhms_flutter/component/common_socket_exception.dart';
import 'package:infyhms_flutter/model/patient/vaccinated_model/vaccinated_model.dart';
import 'package:infyhms_flutter/utils/preference_utils.dart';
import 'package:infyhms_flutter/utils/string_utils.dart';

class VaccinationController extends GetxController {
  VaccinatedModel? vaccinatedModel;
  RxBool isGetVaccination = false.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    StringUtils.client.getVaccinated(PreferenceUtils.getStringValue("token")).then((value) {
      vaccinatedModel = value;
      isGetVaccination.value = true;
    }).onError((DioError error, stackTrace) {
      CheckSocketException.checkSocketException(error);
    });
  }
}
