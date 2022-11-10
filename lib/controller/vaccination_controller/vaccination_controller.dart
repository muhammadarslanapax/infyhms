import 'package:get/get.dart';
import 'package:infyhms_flutter/model/vaccinated_model/vaccinated_model.dart';
import 'package:infyhms_flutter/utils/preference_utils.dart';
import 'package:infyhms_flutter/utils/string_utils.dart';

class VaccinationController extends GetxController {
  VaccinatedModel? vaccinatedModel;
  RxBool isGetVaccination = false.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    StringUtils.client.getVaccinated("Bearer ${PreferenceUtils.getStringValue("token")}").then((value) {
      vaccinatedModel = value;
      isGetVaccination.value = true;
    });
  }
}
