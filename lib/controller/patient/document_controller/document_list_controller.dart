import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infyhms_flutter/component/common_button.dart';
import 'package:infyhms_flutter/component/common_loader.dart';
import 'package:infyhms_flutter/component/common_snackbar.dart';
import 'package:infyhms_flutter/component/common_socket_exception.dart';
import 'package:infyhms_flutter/constant/color_const.dart';
import 'package:infyhms_flutter/constant/text_style_const.dart';
import 'package:infyhms_flutter/model/doctor/doctor_document_model/doctor_documents_crud_model.dart';
import 'package:infyhms_flutter/model/doctor/doctor_document_model/doctor_documents_model.dart';
import 'package:infyhms_flutter/model/patient/documents_model/document_delete_model/document_delete.dart';
import 'package:infyhms_flutter/model/patient/documents_model/documents_model/documents.dart';
import 'package:infyhms_flutter/utils/image_utils.dart';
import 'package:infyhms_flutter/utils/preference_utils.dart';
import 'package:infyhms_flutter/utils/string_utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class DocumentController extends GetxController {
  DocumentsModel? documentsModel;
  DoctorDocumentsModel? doctorDocumentsModel;
  RxBool gotData = false.obs;
  Dio dio = Dio();
  int received = 0;
  String progress = '0';
  int total = 0;
  RxBool isDownloading = false.obs;
  RxList<int> currentIndex = <int>[].obs;

  void downloadDocument(context, int index) async {
    currentIndex.add(index);
    String url;
    if (PreferenceUtils.getBoolValue("isDoctor")) {
      url = doctorDocumentsModel?.data?[index].document_url ?? "";
    } else {
      url = documentsModel?.data?[index].document_url ?? "";
    }

    if (Platform.isIOS) {
      launchUrl(Uri.parse(url));
    } else {
      String fileName = url.substring(url.lastIndexOf("/") + 1);
      Directory? dir = await getExternalStorageDirectory();
      Directory filePath = await Directory("${dir!.path.split("/Android").first}/Documents/HMS").create();
      try {
        isDownloading.value = true;

        await dio.download(
          url,
          '${filePath.path}/$fileName', //'Phone/omo/' + fileName,
          deleteOnError: true,
          onReceiveProgress: (receivedBytes, totalBytes) {
            received = receivedBytes;
            total = totalBytes;
            progress = (received / total * 100).toStringAsFixed(0);
          },
        );
        if (progress == "100") {
          DisplaySnackBar.displaySnackBar("Document Downloaded");
        }
        isDownloading.value = false;
        currentIndex.remove(index);
      } catch (e) {
        DisplaySnackBar.displaySnackBar("Documents can't be downloaded");
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
                        if (PreferenceUtils.getBoolValue("isDoctor")) {
                          deleteDoctorDocument(context, doctorDocumentsModel?.data?[index].id ?? 0);
                        } else {
                          deleteDocData(context, documentsModel?.data?[index].id ?? 0);
                        }
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

  void deleteDocData(BuildContext context, int id) {
    CommonLoader.showLoader(context);
    StringUtils.client.deleteDocument(PreferenceUtils.getStringValue("token"), id)
      ..then((value) {
        DisplaySnackBar.displaySnackBar("Document deleted");
        Get.back();
        getDocuments();
      })
      ..onError((DioError error, stackTrace) {
        Get.back();
        DisplaySnackBar.displaySnackBar(error.message);
        CheckSocketException.checkSocketException(error);
        return DocumentDeleteModel();
      });
  }

  void getDocuments() {
    gotData.value = false;
    StringUtils.client.getDocuments(PreferenceUtils.getStringValue("token")).then((value) {
      documentsModel = value;
      gotData.value = true;
      update();
    }).onError((DioError error, stackTrace) {
      documentsModel = DocumentsModel();
      gotData.value = true;
      CheckSocketException.checkSocketException(error);
    });
  }

  /// Doctor administration
  void getDoctorDocuments() {
    gotData.value = false;
    StringUtils.client.doctorDocuments(PreferenceUtils.getStringValue("token"))
      ..then((value) {
        doctorDocumentsModel = value;
        gotData.value = true;
      })
      ..onError((error, stackTrace) {
        doctorDocumentsModel = DoctorDocumentsModel();
        gotData.value = true;
        return DoctorDocumentsModel();
      });
  }

  void deleteDoctorDocument(BuildContext context, int id) {
    CommonLoader.showLoader(context);
    StringUtils.client.deleteDoctorDocuments(PreferenceUtils.getStringValue("token"), id.toString())
      ..then((value) {
        Get.back();
        DisplaySnackBar.displaySnackBar("Document deleted");
        getDoctorDocuments();
      })
      ..onError((DioError error, stackTrace) {
        Get.back();
        DisplaySnackBar.displaySnackBar(error.message);
        CheckSocketException.checkSocketException(error);
        return DoctorDocumentsCRUDModel();
      });
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    if (PreferenceUtils.getBoolValue("isDoctor")) {
      getDoctorDocuments();
    } else {
      getDocuments();
    }
  }
}
