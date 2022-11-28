import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:infyhms_flutter/component/common_loader.dart';
import 'package:infyhms_flutter/component/common_snackbar.dart';
import 'package:infyhms_flutter/component/common_socket_exception.dart';
import 'package:infyhms_flutter/model/doctor/doctor_document_model/doctor_documents_crud_model.dart';
import 'package:infyhms_flutter/model/doctor/doctor_document_model/doctor_documents_type_model.dart';
import 'package:infyhms_flutter/model/patient/documents_model/document_update_model/document_update.dart';
import 'package:infyhms_flutter/model/patient/documents_model/documents_type_model/documents_type.dart';
import 'package:infyhms_flutter/utils/preference_utils.dart';
import 'package:infyhms_flutter/utils/string_utils.dart';

class EditDocumentController extends GetxController {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController notesController = TextEditingController();
  DocumentsTypeModel? documentsTypeModel;
  DoctorDocumentsTypeModel? doctorDocumentsTypeModel;

  RxBool gotData = false.obs;

  var arguments = Get.arguments;
  String? docTypeId;
  ImagePicker imagePicker = ImagePicker();
  XFile? file;
  String filePath = "";
  RxBool showFile = false.obs;

  String? patientId;

  void pickImage(BuildContext context) async {
    try {
      file = await imagePicker.pickImage(source: ImageSource.gallery);
    } catch (e) {
      DisplaySnackBar.displaySnackBar("Please give access to photos from settings", 5);
    }

    if (file != null) {
      showFile.value = true;
      update();
    }
  }

  void getDocumentTypes() {
    StringUtils.client.getDocumentsType(PreferenceUtils.getStringValue("token"))
      ..then((value) {
        documentsTypeModel = value;
        titleController.text = arguments["title"];
        notesController.text = arguments["note"];
        docTypeId = "${arguments["docType"]}";
        filePath = arguments["attachment"];
        gotData.value = true;
      })
      ..onError((DioError error, stackTrace) {
        gotData.value = true;
        return DocumentsTypeModel();
      });
  }

  void editDocuments(int documentId) {
    if (titleController.text.trim().isEmpty) {
      DisplaySnackBar.displaySnackBar("Please enter title");
    } else if (docTypeId == null) {
      DisplaySnackBar.displaySnackBar("Please select document type");
    } else if (notesController.text.trim().isEmpty) {
      DisplaySnackBar.displaySnackBar("Please enter notes");
    } else {
      if (PreferenceUtils.getBoolValue("isDoctor")) {
        CommonLoader.showLoader();
        StringUtils.client.updateDoctorsDocuments(
          PreferenceUtils.getStringValue("token"),
          documentId.toString(),
          titleController.text.trim(),
          docTypeId ?? "",
          patientId ?? "",
          file == null ? null : File(file?.path ?? ""),
        )
          ..then((value) {
            Get.back();
            Get.back(result: "Call API");
            DisplaySnackBar.displaySnackBar("Document updated successfully");
          })
          ..onError((DioError error, stackTrace) {
            Get.back();
            Get.back();
            CheckSocketException.checkSocketException(error);
            return DoctorDocumentsCRUDModel();
          });
      } else {
        CommonLoader.showLoader();
        StringUtils.client.updateDocument(
          PreferenceUtils.getStringValue("token"),
          titleController.text.trim(),
          docTypeId ?? "",
          notesController.text.trim(),
          file == null ? null : File(file?.path ?? ""),
          documentId,
        )
          ..then((value) {
            if (value.success == true) {
              Get.back();
              Get.back(result: "Call API");
              DisplaySnackBar.displaySnackBar("Document updated successfully");
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
  }

  /// doctor
  void getDoctorsDocumentType() {
    StringUtils.client.doctorDocumentType(PreferenceUtils.getStringValue("token"))
      ..then((value) {
        doctorDocumentsTypeModel = value;
        titleController.text = arguments["title"];
        notesController.text = arguments["note"];
        docTypeId = "${arguments["docType"]}";
        filePath = arguments["attachment"];
        patientId = arguments["patientId"];
        gotData.value = true;
      })
      ..onError((error, stackTrace) {
        gotData.value = true;
        return DoctorDocumentsTypeModel();
      });
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    if (PreferenceUtils.getBoolValue("isDoctor")) {
      getDoctorsDocumentType();
    } else {
      getDocumentTypes();
    }
  }
}
