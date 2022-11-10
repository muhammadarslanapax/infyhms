import 'package:get/get.dart';
import 'package:infyhms_flutter/model/prescriptions_model/prescriptions_model.dart';
import 'package:infyhms_flutter/utils/preference_utils.dart';
import 'package:infyhms_flutter/utils/string_utils.dart';

class PrescriptionController extends GetxController {
  PrescriptionsModel? prescriptionsModel;
  RxBool isGetPrescription = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    StringUtils.client.getPrescription("Bearer ${PreferenceUtils.getStringValue("token")}").then((value) {
      prescriptionsModel = value;
      isGetPrescription.value = true;
    });
  }
}
