import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:infyhms_flutter/component/common_button.dart';
import 'package:infyhms_flutter/component/common_loader.dart';
import 'package:infyhms_flutter/component/common_snackbar.dart';
import 'package:infyhms_flutter/component/common_socket_exception.dart';
import 'package:infyhms_flutter/constant/color_const.dart';
import 'package:infyhms_flutter/constant/text_style_const.dart';
import 'package:infyhms_flutter/model/patient/documents_model/documents_model/documents.dart';
import 'package:infyhms_flutter/utils/image_utils.dart';
import 'package:infyhms_flutter/utils/preference_utils.dart';
import 'package:infyhms_flutter/utils/string_utils.dart';
import 'package:url_launcher/url_launcher.dart';

class DocumentController extends GetxController {
  DocumentsModel? documentsModel;

  RxInt? currentIndex;

  RxBool isDownloading = false.obs;
  RxInt progress = 0.obs;
  ReceivePort receivePort = ReceivePort();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    listenDownload();
    getDocuments();
  }

  void listenDownload() {
    IsolateNameServer.registerPortWithName(receivePort.sendPort, "downloading");
    receivePort.listen((message) {
      progress.value = message[2];
      if (progress.value == 100) {
        if (isDownloading.value) {
          DisplaySnackBar.displaySnackBar("Document downloaded");
          isDownloading.value = false;
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

  void downloadDocument(context, int index) async {
    if (isDownloading.value == true) {
      DisplaySnackBar.displaySnackBar("Download is in progress");
    } else {
      currentIndex = index.obs;
      String url = documentsModel?.data?[index].document_url ?? "";
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
          DisplaySnackBar.displaySnackBar("Document can't be downloaded");
        }
      }
    }
  }

  void showDeleteDialog(context, double height, double width, int index) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext contextOfDialog) {
        return Center(
          child: Container(
            height: height / 2.6,
            width: width / 1.12,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 60,
                  width: 60,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(ImageUtils.deleteIcon),
                    ),
                  ),
                ),
                SizedBox(height: height * 0.03),
                Text(
                  "Delete",
                  style: TextStyleConst.boldTextStyle(
                    ColorConst.blackColor,
                    width * 0.05,
                  ),
                ),
                SizedBox(height: height * 0.01),
                Text(
                  "Are you sure want to delete this\n document?",
                  textAlign: TextAlign.center,
                  style: TextStyleConst.mediumTextStyle(
                    ColorConst.hintGreyColor,
                    width * 0.042,
                  ),
                ),
                SizedBox(height: height * 0.03),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CommonButton(
                      textStyleConst: TextStyleConst.mediumTextStyle(
                        ColorConst.whiteColor,
                        width * 0.05,
                      ),
                      onTap: () {
                        Get.back();
                        deleteData(context, documentsModel!.data?[index].id ?? 0);
                      },
                      color: ColorConst.blueColor,
                      text: StringUtils.delete,
                      width: width / 2.5,
                      height: 50,
                    ),
                    CommonButton(
                      textStyleConst: TextStyleConst.mediumTextStyle(
                        ColorConst.hintGreyColor,
                        width * 0.05,
                      ),
                      onTap: () {
                        Get.back();
                      },
                      color: ColorConst.borderGreyColor,
                      text: StringUtils.cancel,
                      width: width / 2.5,
                      height: 50,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void deleteData(BuildContext context, int id) {
    CommonLoader.showLoader(context);
    StringUtils.client.deleteDocument(PreferenceUtils.getStringValue("token"), id).then((value) {
      DisplaySnackBar.displaySnackBar("Document deleted");
      Get.back();
      getDocuments();
    }).onError((DioError error, stackTrace) {
      Get.back();
      DisplaySnackBar.displaySnackBar(error.message);
      CheckSocketException.checkSocketException(error);
    });
  }

  void getDocuments() {
    StringUtils.client.getDocuments(PreferenceUtils.getStringValue("token")).then((value) {
      documentsModel = value;
      update();
    }).onError((DioError error, stackTrace) {
      documentsModel = DocumentsModel();
      CheckSocketException.checkSocketException(error);
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
