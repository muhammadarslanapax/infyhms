import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:infyhms_flutter/component/common_snackbar.dart';
import 'package:infyhms_flutter/component/common_socket_exception.dart';
import 'package:infyhms_flutter/model/patient/diagnosis_model/diagnosis_test_model.dart';
import 'package:infyhms_flutter/utils/preference_utils.dart';
import 'package:infyhms_flutter/utils/string_utils.dart';
import 'package:url_launcher/url_launcher.dart';

class DiagnosisTestController extends GetxController {
  DiagnosisTestModel? diagnosisTestModel;
  RxBool isDiagnosisTestApiCall = false.obs;
  RxInt? currentIndex;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getDiagnosisTest();
    listenDownload();
  }

  RxBool isDownloading = false.obs;
  RxInt progress = 0.obs;
  ReceivePort receivePort = ReceivePort();

  void listenDownload() {
    IsolateNameServer.registerPortWithName(receivePort.sendPort, "downloading");
    receivePort.listen((message) {
      progress.value = message[2];
      if (progress.value == 100) {
        if (isDownloading.value) {
          DisplaySnackBar.displaySnackBar("Diagnosis test PDF downloaded");
          isDownloading.value = false;
        }
      }
    });
    FlutterDownloader.registerCallback(downloadingCallback);
  }

  static downloadingCallback(id, status, progress) {
    SendPort? sendPort = IsolateNameServer.lookupPortByName("downloading");
    sendPort?.send([id, status, progress]);
  }

  void downloadPDF(String url, int index) async {
    if (isDownloading.value == true) {
      DisplaySnackBar.displaySnackBar("Download is in progress");
    } else {
      currentIndex = index.obs;
      String url = diagnosisTestModel!.data![index].pdf_url!;
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
        } catch (e) {
          isDownloading.value = false;
          DisplaySnackBar.displaySnackBar("Diagnosis test PDF can't be downloaded");
        }
      }
    }
  }

  void getDiagnosisTest() {
    StringUtils.client.getDiagnosisTest(PreferenceUtils.getStringValue("token")).then((value) {
      diagnosisTestModel = value;
      isDiagnosisTestApiCall.value = true;
    }).onError((DioError error, stackTrace) {
      CheckSocketException.checkSocketException(error);
    });
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
  //         DisplaySnackBar.displaySnackBar("Downloaded");
  //       }
  //       isDownloading = false;
  //       update();
  //     } catch (e) {
  //       DisplaySnackBar.displaySnackBar("Document can't be downloaded");
  //     }
  //   }
  // }
}
