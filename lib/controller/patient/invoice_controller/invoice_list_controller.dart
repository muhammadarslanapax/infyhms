import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:infyhms_flutter/component/common_socket_exception.dart';
import 'package:infyhms_flutter/model/patient/invoice_model/invoice_model.dart';
import 'package:infyhms_flutter/utils/preference_utils.dart';
import 'package:infyhms_flutter/utils/string_utils.dart';

class InvoiceListController extends GetxController {
  InvoiceModel? invoiceModel;
  RxBool isGotInvoice = false.obs;

  void getInvoices() {
    StringUtils.client.getInvoices(PreferenceUtils.getStringValue("token"))
      ..then((value) {
        invoiceModel = value;
        if (invoiceModel!.success == true) {
          isGotInvoice.value = true;
        }
      })
      ..onError((DioError error, stackTrace) {
        isGotInvoice.value = true;
        CheckSocketException.checkSocketException(error);
        return InvoiceModel();
      });
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getInvoices();
  }
}
