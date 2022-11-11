import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:infyhms_flutter/component/common_snackbar.dart';
import 'package:infyhms_flutter/component/common_socket_exception.dart';
import 'package:infyhms_flutter/model/invoice_model/invoice_details_model.dart';
import 'package:infyhms_flutter/utils/preference_utils.dart';
import 'package:infyhms_flutter/utils/string_utils.dart';
import 'package:url_launcher/url_launcher.dart';

class InvoiceDetailsController extends GetxController {
  int invoiceId = Get.arguments;
  InvoiceDetailsModel? invoiceDetailsModel;

  Dio dio = Dio();
  int received = 0;
  String progress = '0';
  int total = 0;
  bool isDownloading = false;

  void downloadPDF(context, String url) async {
    if (Platform.isIOS) {
      launchUrl(Uri.parse(url));
    } else {
      String fileName = url.substring(url.lastIndexOf("/") + 1);
      Directory filePath = await Directory("storage/emulated/0/Documents/HMS").create(recursive: true);
      try {
        isDownloading = true;
        update();
        await dio.download(
          url,
          '${filePath.path}/$fileName',
          deleteOnError: true,
          onReceiveProgress: (receivedBytes, totalBytes) {
            received = receivedBytes;
            total = totalBytes;
            progress = (received / total * 100).toStringAsFixed(0);
          },
        );
        if (progress == "100") {
          DisplaySnackBar.displaySnackBar(context, "Downloaded");
        }
        isDownloading = false;
        update();
      } catch (e) {
        DisplaySnackBar.displaySnackBar(context, "Document can't be downloaded");
      }
    }
  }

  void getInvoiceDetails() {
    print(invoiceId);
    StringUtils.client.getInvoiceData("Bearer ${PreferenceUtils.getStringValue("token")}", invoiceId).then((value) {
      invoiceDetailsModel = value;
      update();
    }).onError((DioError error, stackTrace) {
      CheckSocketException.checkSocketException(error);
    });
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getInvoiceDetails();
  }
}
