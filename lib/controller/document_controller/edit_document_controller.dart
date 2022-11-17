import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:infyhms_flutter/component/common_loader.dart';
import 'package:infyhms_flutter/component/common_snackbar.dart';
import 'package:infyhms_flutter/component/common_socket_exception.dart';
import 'package:infyhms_flutter/model/documents_model/document_update_model/document_update.dart';
import 'package:infyhms_flutter/model/documents_model/documents_type_model/documents_type.dart';
import 'package:infyhms_flutter/utils/preference_utils.dart';
import 'package:infyhms_flutter/utils/string_utils.dart';

class EditDocumentController extends GetxController {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController notesController = TextEditingController();
  DocumentsTypeModel? documentsTypeModel;
  var arguments = Get.arguments;
  String? docId;
  ImagePicker imagePicker = ImagePicker();
  XFile? file;
  String filePath = "";
  bool showFile = false;

  void pickImage(BuildContext context) async {
    try {
      file = await imagePicker.pickImage(source: ImageSource.gallery);
    } catch (e) {
      DisplaySnackBar.displaySnackBar("Please give access to photos from settings", 5);
    }

    if (file != null) {
      showFile = true;
      update();
    }
  }

  void getDocumentTypes() {
    StringUtils.client.getDocumentsType(PreferenceUtils.getStringValue("token")).then((value) {
      documentsTypeModel = value;

      titleController.text = arguments["title"];
      notesController.text = arguments["note"];
      docId = "${arguments["docType"]}";
      filePath = arguments["attachment"];
      update();
    });
  }

  void editDocuments(context, int documentId) {
    if (titleController.text.trim().isEmpty) {
      DisplaySnackBar.displaySnackBar("Please enter title");
    } else if (docId == null) {
      DisplaySnackBar.displaySnackBar("Please select document type");
    }
    // else if (file == null) {
    //   DisplaySnackBar.displaySnackBar(context, "Please attach file");
    // }
    else if (notesController.text.trim().isEmpty) {
      DisplaySnackBar.displaySnackBar("Please enter notes");
    } else {
      CommonLoader.showLoader(context);
      StringUtils.client.updateDocument(
        PreferenceUtils.getStringValue("token"),
        titleController.text.trim(),
        docId ?? "",
        notesController.text.trim(),
        file == null ? null : File(file?.path ?? ""),
        documentId,
      )
        ..then((value) {
          if (value.success == true) {
            DisplaySnackBar.displaySnackBar("Document updated successfully");
            Get.back();
            Get.back(result: "Call API");
          }
        })
        ..onError((DioError error, stackTrace) {
          Get.back();
          Get.back();
          CheckSocketException.checkSocketException(error);
          return DocumentUpdateModel();
        });
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getDocumentTypes();
  }
}
