import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:infyhms_flutter/component/common_loader.dart';
import 'package:infyhms_flutter/component/common_snackbar.dart';
import 'package:infyhms_flutter/component/common_socket_exception.dart';
import 'package:infyhms_flutter/model/doctor/doctor_document_model/doctor_documents_crud_model.dart';
import 'package:infyhms_flutter/model/doctor/doctor_document_model/doctor_documents_type_model.dart';
import 'package:infyhms_flutter/model/doctor/doctor_document_model/doctor_patients_model.dart';
import 'package:infyhms_flutter/model/patient/documents_model/document_store_model/document_store.dart';
import 'package:infyhms_flutter/model/patient/documents_model/documents_type_model/documents_type.dart';
import 'package:infyhms_flutter/utils/preference_utils.dart';
import 'package:infyhms_flutter/utils/string_utils.dart';

class NewDocumentController extends GetxController {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController notesController = TextEditingController();
  DocumentsTypeModel? documentsTypeModel;

  DoctorDocumentsTypeModel? doctorDocumentsTypeModel;
  DoctorPatientsDocumentsModel? doctorPatientsDocumentsModel;

  String? docId;
  ImagePicker imagePicker = ImagePicker();
  XFile? file;
  RxBool showFile = false.obs;
  RxBool gotData = false.obs;

  String? patientId;

  pickImage() async {
    file = await imagePicker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      showFile.value = true;
      update();
    }
  }

  void getDocumentTypes() {
    StringUtils.client.getDocumentsType(PreferenceUtils.getStringValue("token"))
      ..then((value) {
        documentsTypeModel = value;
        gotData.value = true;
        update();
      })
      ..onError((DioError error, stackTrace) {
        gotData.value = true;
        CheckSocketException.checkSocketException(error);
        return DocumentsTypeModel();
      });
  }

  void createDocuments() {
    if (titleController.text.trim().isEmpty) {
      DisplaySnackBar.displaySnackBar("Please enter title");
    } else if (docId == null) {
      DisplaySnackBar.displaySnackBar("Please select document type");
    } else if (file == null) {
      DisplaySnackBar.displaySnackBar("Please attach file");
    } else if (notesController.text.trim().isEmpty) {
      DisplaySnackBar.displaySnackBar("Please enter notes");
    } else {
      if (PreferenceUtils.getBoolValue("isLocated")) {
        if (patientId == null) {
          DisplaySnackBar.displaySnackBar("Please select patient");
        } else {
          CommonLoader.showLoader();
          StringUtils.client.createNewDoctorDocument(
            PreferenceUtils.getStringValue("token"),
            titleController.text.trim(),
            docId ?? "",
            patientId ?? "",
            File(file!.path),
          )
            ..then((value) {
              if (value.success == true) {
                Get.back();
                Get.back(result: "Call API");
                DisplaySnackBar.displaySnackBar("Document uploaded successfully");
              }
            })
            ..onError((DioError error, stackTrace) {
              Get.back();
              Get.back();
              CheckSocketException.checkSocketException(error);
              return DoctorDocumentsCRUDModel();
            });
        }
      } else {
        CommonLoader.showLoader();
        StringUtils.client.storeDocument(
          PreferenceUtils.getStringValue("token"),
          titleController.text.trim(),
          docId ?? "",
          notesController.text.trim(),
          File(file!.path),
        )
          ..then((value) {
            if (value.success == true) {
              Get.back();
              Get.back(result: "Call API");
              DisplaySnackBar.displaySnackBar("Document uploaded successfully");
            }
          })
          ..onError((DioError error, stackTrace) {
            Get.back();
            Get.back();
            CheckSocketException.checkSocketException(error);
            return DocumentStoreModel();
          });
      }
    }
  }

  /// doctor
  void getDoctorDocumentsType() {
    StringUtils.client.doctorDocumentType(PreferenceUtils.getStringValue("token"))
      ..then((value) {
        doctorDocumentsTypeModel = value;
        getPatients();
      })
      ..onError((DioError error, stackTrace) {
        getPatients();
        CheckSocketException.checkSocketException(error);
        return DoctorDocumentsTypeModel();
      });
  }

  void getPatients() {
    StringUtils.client.doctorPatientsDocument(PreferenceUtils.getStringValue("token"))
      ..then((value) {
        doctorPatientsDocumentsModel = value;
        gotData.value = true;
      })
      ..onError((DioError error, stackTrace) {
        gotData.value = true;
        return DoctorPatientsDocumentsModel();
      });
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    if (PreferenceUtils.getBoolValue("isDoctor")) {
      getDoctorDocumentsType();
    } else {
      getDocumentTypes();
    }
  }
}
