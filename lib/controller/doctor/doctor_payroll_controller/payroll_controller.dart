import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:infyhms_flutter/component/common_socket_exception.dart';
import 'package:infyhms_flutter/model/doctor/doctor_payroll_model/payroll_model.dart';
import 'package:infyhms_flutter/utils/preference_utils.dart';
import 'package:infyhms_flutter/utils/string_utils.dart';

class PayrollController extends GetxController {
  PayrollModel? payrollModel;
  RxBool isGetPayroll = false.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getPayroll();
  }

  void getPayroll() {
    StringUtils.client.getPayroll(PreferenceUtils.getStringValue("token"))
      ..then((value) {
        payrollModel = value;
        isGetPayroll.value = true;
      })
      ..onError((DioError error, stackTrace) {
        CheckSocketException.checkSocketException(error);
        return PayrollModel();
      });
  }
}
