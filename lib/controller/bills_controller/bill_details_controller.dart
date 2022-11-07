import 'package:get/get.dart';
import 'package:infyhms_flutter/model/bills_model/bill_detail_model.dart';
import 'package:infyhms_flutter/utils/preference_utils.dart';
import 'package:infyhms_flutter/utils/string_utils.dart';

class BillDetailsController extends GetxController {
  BillDetailModel? billDetailModel;
  int argumentData = Get.arguments;
  RxBool isGetBillsDetails = false.obs;
  RxInt totalPrice = 0.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getBillsDetails();
  }

  void getBillsDetails() {
    StringUtils.client.getBillsDetails("Bearer ${PreferenceUtils.getStringValue("token")}", argumentData).then((value) {
      billDetailModel = value;
      if (billDetailModel!.success == true) {
        isGetBillsDetails.value = true;
      }
    });
  }
}
