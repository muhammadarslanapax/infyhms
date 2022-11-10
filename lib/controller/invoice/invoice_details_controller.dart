import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:infyhms_flutter/component/common_snackbar.dart';
import 'package:infyhms_flutter/model/invoice/invoice_details_model.dart';
import 'package:infyhms_flutter/utils/preference_utils.dart';
import 'package:infyhms_flutter/utils/string_utils.dart';
import 'package:path_provider/path_provider.dart';
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
      Directory? dir = await getExternalStorageDirectory();
      Directory filePath = await Directory("${dir!.path.split("/Android").first}/Documents/HMS").create();
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
    });
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getInvoiceDetails();
  }
}
