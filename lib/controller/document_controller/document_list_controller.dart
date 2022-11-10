import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infyhms_flutter/component/common_button.dart';
import 'package:infyhms_flutter/component/common_loader.dart';
import 'package:infyhms_flutter/component/common_snackbar.dart';
import 'package:infyhms_flutter/constant/color_const.dart';
import 'package:infyhms_flutter/constant/text_style_const.dart';
import 'package:infyhms_flutter/model/documents/document_delete_model/document_delete.dart';
import 'package:infyhms_flutter/model/documents/documents_model/documents.dart';
import 'package:infyhms_flutter/utils/image_utils.dart';
import 'package:infyhms_flutter/utils/preference_utils.dart';
import 'package:infyhms_flutter/utils/string_utils.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:path_provider/path_provider.dart';

class DocumentController extends GetxController {
  DocumentsModel? documentsModel;
  Dio dio = Dio();
  int received = 0;
  String progress = '0';
  int total = 0;
  bool isDownloading = false;
  List<int> currentIndex = [];

  void downloadDocument(context, int index) async {
    currentIndex.add(index);
    String url = documentsModel?.data?[index].document_url ?? "";
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
          '${filePath.path}/$fileName', //'Phone/omo/' + fileName,
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
        currentIndex.remove(index);
        update();
      } catch (e) {
        DisplaySnackBar.displaySnackBar(context, "Document can't be downloaded");
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
    StringUtils.client.deleteDocument("Bearer ${PreferenceUtils.getStringValue("token")}", id)
      ..then((value) {
        DisplaySnackBar.displaySnackBar(context, "Document deleted");
        Get.back();
        getDocuments();
      })
      ..onError((DioError error, stackTrace) {
        Get.back();
        DisplaySnackBar.displaySnackBar(context, error.message);
        return DocumentDeleteModel();
      });
  }

  void getDocuments() {
    StringUtils.client.getDocuments("Bearer ${PreferenceUtils.getStringValue("token")}")
      ..then((value) {
        documentsModel = value;
        update();
      })
      ..onError((DioError error, stackTrace) {
        documentsModel = DocumentsModel();
        return DocumentsModel();
      });
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getDocuments();
  }
}
