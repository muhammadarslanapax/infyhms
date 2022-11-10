import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:infyhms_flutter/model/invoice/invoice_model.dart';
import 'package:infyhms_flutter/utils/preference_utils.dart';
import 'package:infyhms_flutter/utils/string_utils.dart';

class InvoiceListController extends GetxController {
  InvoiceModel? invoiceModel;

  void getInvoices() {
    StringUtils.client.getInvoices("Bearer ${PreferenceUtils.getStringValue("token")}")
      ..then((value) {
        invoiceModel = value;
        update();
      })
      ..onError((DioError error, stackTrace) {
        invoiceModel = InvoiceModel();
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
