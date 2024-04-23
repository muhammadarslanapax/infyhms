import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:infyhms_flutter/component/common_snackbar.dart';
import 'package:infyhms_flutter/component/common_socket_exception.dart';
import 'package:infyhms_flutter/constant/color_const.dart';
import 'package:infyhms_flutter/model/doctor/doctor_prescription_model/doctor_prescription_detail_model.dart';
import 'package:infyhms_flutter/utils/preference_utils.dart';
import 'package:infyhms_flutter/utils/string_utils.dart';
import 'package:url_launcher/url_launcher.dart';

class DoctorPrescriptionDetailController extends GetxController {
  RxBool isGetDetail = false.obs;
  RxBool isDownloading = false.obs;
  //int id = Get.arguments;
  DoctorPrescriptionDetailModel? doctorPrescriptionDetailModel;

  RxInt progress = 0.obs;
  ReceivePort receivePort = ReceivePort();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    listenDownload();
  }

  void listenDownload() {
    IsolateNameServer.registerPortWithName(receivePort.sendPort, "downloading");
    receivePort.listen((message) {
      progress.value = message[2];
      if (progress.value == 100) {
        if (isDownloading.value) {
          DisplaySnackBar.displaySnackBar("Prescription has been downloaded", 3 , ColorConst.greenColor);
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

  void downloadPDF(String url) async {
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
        DisplaySnackBar.displaySnackBar("Prescription can't be downloaded");
      }
    }
  }

  void getDoctorPrescriptionDetail(int id) {
    StringUtils.client.getDoctorsPrescriptionDetail(PreferenceUtils.getStringValue("token"), id)
      ..then((value) {
        doctorPrescriptionDetailModel = value;
        isGetDetail.value = true;
      })
      ..onError((DioError error, stackTrace) {
        CheckSocketException.checkSocketException(error);
        return DoctorPrescriptionDetailModel();
      });
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    receivePort.close();
    IsolateNameServer.removePortNameMapping('downloading');
  }
}
