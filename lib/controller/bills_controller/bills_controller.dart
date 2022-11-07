import 'package:get/get.dart';
import 'package:infyhms_flutter/model/bills_model/bill_model.dart';
import 'package:infyhms_flutter/utils/preference_utils.dart';
import 'package:infyhms_flutter/utils/string_utils.dart';

class BillsController extends GetxController {
  BillsModel? billsModel;
  RxBool isGetBills = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    StringUtils.client.getBills("Bearer ${PreferenceUtils.getStringValue("token")}").then((value) {
      billsModel = value;
      isGetBills.value = true;
    });
  }
}
