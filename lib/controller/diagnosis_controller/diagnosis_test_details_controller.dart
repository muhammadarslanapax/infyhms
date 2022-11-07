import 'package:get/get.dart';
import 'package:infyhms_flutter/model/diagnosis_model/diagnosis_test_details_model.dart';
import 'package:infyhms_flutter/utils/preference_utils.dart';
import 'package:infyhms_flutter/utils/string_utils.dart';

class DiagnosisTestDetailsController extends GetxController {
  int argument = Get.arguments;
  DiagnosisTestDetailsModel? diagnosisTestDetailsModel;
  RxBool isDetailsGet = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    StringUtils.client.getDiagnosisTestDetails("Bearer ${PreferenceUtils.getStringValue("token")}", argument).then((value) {
      diagnosisTestDetailsModel = value;
      isDetailsGet.value = true;
    });
    print(argument);
  }
}
