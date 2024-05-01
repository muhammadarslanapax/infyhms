import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:infyhms_flutter/component/common_socket_exception.dart';
import 'package:infyhms_flutter/model/doctor/doctor_diagnosis_test_model/delete_test_model.dart';
import 'package:infyhms_flutter/model/doctor/doctor_diagnosis_test_model/doctor_diagnosis_test_model.dart';
import 'package:infyhms_flutter/model/patient/diagnosis_model/diagnosis_test_model.dart';
import 'package:infyhms_flutter/utils/preference_utils.dart';
import 'package:infyhms_flutter/utils/string_utils.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../component/common_snackbar.dart';

class DiagnosisTestController extends GetxController {
  DiagnosisTestModel? diagnosisTestModel;
  DoctorDiagnosisTestModel? doctorDiagnosisTestModel;
  RxBool isDiagnosisTestApiCall = false.obs;
  DeleteTestModel? deleteTestModel;

  int? currentIndex;
  List<RxBool> isCurrentDownloading = <RxBool>[];
  RxInt progress = 0.obs;
  ReceivePort receivePort = ReceivePort();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    listenDownload();
    PreferenceUtils.getBoolValue("isDoctor")
        ? getDoctorDiagnosisTest()
        : getDiagnosisTest();
  }

  void listenDownload() {
    IsolateNameServer.registerPortWithName(receivePort.sendPort, "downloading");
    receivePort.listen((message) {
      progress.value = message[2];
      if (progress.value == 100) {
        if (isCurrentDownloading[currentIndex ?? 0].value) {
          DisplaySnackBar.displaySnackBar("Document downloaded");
          isCurrentDownloading[currentIndex ?? 0].value = false;
          currentIndex = null;
        }
      }
    });
    FlutterDownloader.registerCallback(downloadingCallback);
  }

  static downloadingCallback(id, status, progress) {
    SendPort? sendPort = IsolateNameServer.lookupPortByName("downloading");
    sendPort?.send([id, status, progress]);
  }

  void downloadDiagnosis(context, int index) async {
    if (!isCurrentDownloading.contains(true.obs)) {
      currentIndex = index;
      String url;
      if (PreferenceUtils.getBoolValue("isDoctor")) {
        url = doctorDiagnosisTestModel?.data?[index].pdf_url ?? "";
      } else {
        url = diagnosisTestModel?.data?[index].pdf_url ?? "";
      }
      if (Platform.isIOS) {
        launchUrl(Uri.parse(url));
      } else {
        isCurrentDownloading[index].value = true;
        try {
          Directory filePath =
              await Directory("storage/emulated/0/Documents/HMS")
                  .create(recursive: true);
          await FlutterDownloader.enqueue(
            url: url,
            savedDir: filePath.path,
            showNotification: true,
            openFileFromNotification: true,
            saveInPublicStorage: true,
          );
          await Future.delayed(const Duration(milliseconds: 2000));
          DisplaySnackBar.displaySnackBar("Diagnosis tests PDF has been downloaded", 3);
          isCurrentDownloading[index].value = false;
        } catch (e) {
          isCurrentDownloading[index].value = false;
          DisplaySnackBar.displaySnackBar("Document can't be downloaded");
        }
      }
    }
  }

  void getDiagnosisTest() {
    StringUtils.client.getDiagnosisTest(PreferenceUtils.getStringValue("token"))
      ..then((value) {
        diagnosisTestModel = value;
        isCurrentDownloading = List.generate(value.data?.length ?? 1, (index) {
          return false.obs;
        });
        isDiagnosisTestApiCall.value = true;
      })
      ..onError((DioError error, stackTrace) {
        CheckSocketException.checkSocketException(error);
        return DiagnosisTestModel();
      });
  }

  void getDoctorDiagnosisTest() {
    StringUtils.client
        .getDoctorsDiagnosisTest(PreferenceUtils.getStringValue("token"))
      ..then((value) {
        doctorDiagnosisTestModel = value;
        isCurrentDownloading = List.generate(value.data?.length ?? 1, (index) {
          return false.obs;
        });
        isDiagnosisTestApiCall.value = true;
      })
      ..onError((DioError error, stackTrace) {
        CheckSocketException.checkSocketException(error);
        return DoctorDiagnosisTestModel();
      });
  }

  void deleteTest(int id) {
    isDiagnosisTestApiCall.value = false;
    StringUtils.client.deleteTest(PreferenceUtils.getStringValue("token"), id).then((value) {
      deleteTestModel = value;
      if (deleteTestModel!.success == true) {
        PreferenceUtils.getBoolValue("isDoctor") ? getDoctorDiagnosisTest() : getDiagnosisTest();
      }
    });
  }
}
