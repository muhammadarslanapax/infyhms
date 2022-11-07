import 'package:get/get.dart';
import 'package:infyhms_flutter/model/case_model/case_model.dart';
import 'package:infyhms_flutter/utils/preference_utils.dart';
import 'package:infyhms_flutter/utils/string_utils.dart';

class CaseController extends GetxController {
  CaseModel? caseModel;
  RxBool isGetCase = false.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getCase();
  }

  getCase() {
    StringUtils.client.getCase("Bearer ${PreferenceUtils.getStringValue("token")}").then((value) {
      caseModel = value;
      isGetCase.value = true;
    });
  }
}
