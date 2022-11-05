import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:infyhms_flutter/component/common_loader.dart';
import 'package:infyhms_flutter/component/common_snackbar.dart';
import 'package:infyhms_flutter/model/documents/document_store_model/document_store.dart';
import 'package:infyhms_flutter/model/documents/documents_type_model/documents_type.dart';
import 'package:infyhms_flutter/utils/preference_utils.dart';
import 'package:infyhms_flutter/utils/string_utils.dart';

class NewDocumentController extends GetxController {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController notesController = TextEditingController();
  DocumentsTypeModel? documentsTypeModel;
  String? docId;
  ImagePicker imagePicker = ImagePicker();
  XFile? file;
  bool showFile = false;

  pickImage() async {
    file = await imagePicker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      showFile = true;
      update();
    }
  }

  void getDocumentTypes() {
    StringUtils.client.getDocumentsType("Bearer ${PreferenceUtils.getStringValue("token")}").then((value) {
      documentsTypeModel = value;
      update();
    });
  }

  void createDocuments(context) {
    if (titleController.text.trim().isEmpty) {
      DisplaySnackBar.displaySnackBar(context, "Please enter title");
    } else if (docId == null) {
      DisplaySnackBar.displaySnackBar(context, "Please select document type");
    } else if (file == null) {
      DisplaySnackBar.displaySnackBar(context, "Please attach file");
    } else if (notesController.text.trim().isEmpty) {
      DisplaySnackBar.displaySnackBar(context, "Please enter notes");
    } else {
      CommonLoader.showLoader(context);
      StringUtils.client
          .storeDocument(
        "Bearer ${PreferenceUtils.getStringValue("token")}",
        titleController.text.trim(),
        docId ?? "",
        notesController.text.trim(),
        File(file!.path),
      )
          ..then((value) {
        if (value.success == true) {
          DisplaySnackBar.displaySnackBar(context, "Document uploaded successfully");
          Get.back();
          Get.back(result: "Call API");
        }
      })
      ..onError((DioError error, stackTrace){
        Get.back();
        Get.back();
        return DocumentStoreModel();
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
