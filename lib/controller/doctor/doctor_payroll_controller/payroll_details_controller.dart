import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:infyhms_flutter/component/common_socket_exception.dart';
import 'package:infyhms_flutter/model/doctor/doctor_payroll_model/payroll_details_model.dart';
import 'package:infyhms_flutter/utils/preference_utils.dart';
import 'package:infyhms_flutter/utils/string_utils.dart';

class PayrollDetailsController extends GetxController {
  PayrollDetailsModel? payrollDetailsModel;
  RxBool isGetDetails = false.obs;

  void getPayrollDetails(int id) {
    StringUtils.client.getPayrollDetails(PreferenceUtils.getStringValue("token"), id)
      ..then((value) {
        payrollDetailsModel = value;
        isGetDetails.value = true;
      })
      ..onError((DioError error, stackTrace) {
        CheckSocketException.checkSocketException(error);
        return PayrollDetailsModel();
      });
  }
}
