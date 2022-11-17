import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
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

  RxBool isDownloading = false.obs;
  int progress = 0;
  final ReceivePort _receivePort = ReceivePort();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getInvoiceDetails();
    IsolateNameServer.registerPortWithName(_receivePort.sendPort, "downloading");
    _receivePort.listen((message) {
      progress = message[2];
    });
    FlutterDownloader.registerCallback(downloadingCallback);
  }

  static downloadingCallback(id, status, progress) {
    SendPort? sendPort = IsolateNameServer.lookupPortByName("downloading");
    sendPort?.send([id, status, progress]);
  }

  void downloadPDF(context, String url) async {
    if (Platform.isIOS) {
      launchUrl(Uri.parse(url));
    } else {
      isDownloading.value = true;
      try {
        Directory filePath = await Directory("storage/emulated/0/Documents/HMS").create(recursive: true);
        await FlutterDownloader.enqueue(
          url: url,
          savedDir: filePath.path,
          showNotification: true,
          openFileFromNotification: true,
          saveInPublicStorage: true,
        );
        isDownloading.value = false;

        DisplaySnackBar.displaySnackBar("Invoice Downloaded");
        print(isDownloading.value);
      } catch (e) {
        isDownloading.value = false;
        DisplaySnackBar.displaySnackBar("Invoice can't be downloaded");
      }
    }
  }

  // void downloadPDF(context, String url) async {
  //   if (Platform.isIOS) {
  //     launchUrl(Uri.parse(url));
  //   } else {
  //     String fileName = url.substring(url.lastIndexOf("/") + 1);
  //     Directory filePath = await Directory("storage/emulated/0/Documents/HMS").create(recursive: true);
  //     try {
  //       isDownloading = true;
  //       update();
  //       await dio.download(
  //         url,
  //         '${filePath.path}/$fileName',
  //         deleteOnError: true,
  //         onReceiveProgress: (receivedBytes, totalBytes) {
  //           received = receivedBytes;
  //           total = totalBytes;
  //           progress = (received / total * 100).toStringAsFixed(0);
  //         },
  //       );
  //       if (progress == "100") {
  //         DisplaySnackBar.displaySnackBar(context, "Invoice Downloaded");
  //       }
  //       isDownloading = false;
  //       update();
  //     } catch (e) {
  //       DisplaySnackBar.displaySnackBar(context, "Document can't be downloaded");
  //     }
  //   }
  // }

  void getInvoiceDetails() {
    StringUtils.client.getInvoiceData(PreferenceUtils.getStringValue("token"), invoiceId).then((value) {
      invoiceDetailsModel = value;
      update();
    }).onError((DioError error, stackTrace) {
      CheckSocketException.checkSocketException(error);
    });
  }
}
