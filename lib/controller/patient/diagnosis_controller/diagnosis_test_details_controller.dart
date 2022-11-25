import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:infyhms_flutter/component/common_snackbar.dart';
import 'package:infyhms_flutter/component/common_socket_exception.dart';
import 'package:infyhms_flutter/model/doctor/doctor_diagnosis_test_model/doctor_diagnosis_test_detail_model.dart';
import 'package:infyhms_flutter/model/patient/diagnosis_model/diagnosis_test_details_model.dart';
import 'package:infyhms_flutter/utils/preference_utils.dart';
import 'package:infyhms_flutter/utils/string_utils.dart';
import 'package:url_launcher/url_launcher.dart';

class DiagnosisTestDetailsController extends GetxController {
  int diagnosisTestId = Get.arguments;
  int doctorDiagnosisTestId = Get.arguments;
  DiagnosisTestDetailsModel? diagnosisTestDetailsModel;
  DoctorDiagnosisTestDetailsModel? doctorDiagnosisTestDetailsModel;
  RxBool isDetailsGet = false.obs;

  RxBool isDownloading = false.obs;
  RxInt progress = 0.obs;
  ReceivePort receivePort = ReceivePort();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    listenDownload();
    PreferenceUtils.getBoolValue("isDoctor") ? getDoctorDiagnosisTestDetails() : getDiagnosisTestDetails();
  }

  void listenDownload() {
    IsolateNameServer.registerPortWithName(receivePort.sendPort, "downloading");
    receivePort.listen((message) {
      progress.value = message[2];
      if (progress.value == 100) {
        if (isDownloading.value) {
          DisplaySnackBar.displaySnackBar("Diagnosis tests PDF downloaded");
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
        DisplaySnackBar.displaySnackBar("Diagnosis tests PDF can't be downloaded");
      }
    }
  }

  void getDiagnosisTestDetails() {
    StringUtils.client.getDiagnosisTestDetails(PreferenceUtils.getStringValue("token"), diagnosisTestId)
      ..then((value) {
        diagnosisTestDetailsModel = value;
        isDetailsGet.value = true;
      })
      ..onError((DioError error, stackTrace) {
        CheckSocketException.checkSocketException(error);
        return DiagnosisTestDetailsModel();
      });
  }

  void getDoctorDiagnosisTestDetails() {
    StringUtils.client.getDoctorsDiagnosisTestDetails(PreferenceUtils.getStringValue("token"), doctorDiagnosisTestId)
      ..then((value) {
        doctorDiagnosisTestDetailsModel = value;
        isDetailsGet.value = true;
      })
      ..onError((DioError error, stackTrace) {
        CheckSocketException.checkSocketException(error);
        return DoctorDiagnosisTestDetailsModel();
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
