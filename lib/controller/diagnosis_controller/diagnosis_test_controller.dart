import 'package:get/get.dart';
import 'package:infyhms_flutter/model/diagnosis_model/diagnosis_test_model.dart';
import 'package:infyhms_flutter/utils/preference_utils.dart';
import 'package:infyhms_flutter/utils/string_utils.dart';

class DiagnosisTestController extends GetxController {
  DiagnosisTestModel? diagnosisTestModel;
  RxBool isDiagnosisTestApiCall = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    StringUtils.client.getDiagnosisTest("Bearer ${PreferenceUtils.getStringValue("token")}").then((value) {
      diagnosisTestModel = value;
      isDiagnosisTestApiCall.value = true;
    });
  }
}
