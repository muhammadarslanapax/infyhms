import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infyhms_flutter/component/common_loader.dart';
import 'package:infyhms_flutter/component/common_snackbar.dart';
import 'package:infyhms_flutter/component/common_socket_exception.dart';
import 'package:infyhms_flutter/model/doctor/bed_assign_model/beds_model.dart';
import 'package:infyhms_flutter/model/doctor/bed_assign_model/create_new_bed_model.dart';
import 'package:infyhms_flutter/model/doctor/bed_assign_model/ipd_patients_model.dart';
import 'package:infyhms_flutter/model/doctor/bed_assign_model/patient_cases_model.dart';
import 'package:infyhms_flutter/utils/preference_utils.dart';
import 'package:infyhms_flutter/utils/string_utils.dart';

class NewBedController extends GetxController {
  String? selectedDate;
  TextEditingController dateController = TextEditingController();
  TextEditingController notesController = TextEditingController();

  RxBool gotDropDownData = false.obs;

  PatientCases? patientCases;
  IPDPatientsModel? ipdPatientsModel;
  BedsModel? bedsModel;

  String? caseId;
  String? patientId;
  String? bedId;

  DateTime? oldDate;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getMyCases();
  }

  void caseChoice(String value) {
    String id = value.split(" ").first;
    caseId = id;
    getIPDPatients(id);
  }

  void getMyCases() {
    StringUtils.client.getPatientCases(PreferenceUtils.getStringValue("token"))
      ..then((value) {
        patientCases = value;
        getBeds();
      })
      ..onError((DioError error, stackTrace) {
        CheckSocketException.checkSocketException(error);
        return PatientCases();
      });
  }

  void getIPDPatients(String caseId) {
    StringUtils.client.getIPDModel(PreferenceUtils.getStringValue("token"), caseId)
      ..then((value) {
        ipdPatientsModel = value;
        getBeds();
      })
      ..onError((DioError error, stackTrace) {
        return IPDPatientsModel();
      });
  }

  void getBeds() {
    StringUtils.client.getBeds(PreferenceUtils.getStringValue("token"))
      ..then((value) {
        bedsModel = value;
        gotDropDownData.value = true;
      })
      ..onError((DioError error, stackTrace) {
        return BedsModel();
      });
  }

  void selectAssignDate(BuildContext context) async {
    selectedDate = (await selectDate(context)) ?? selectedDate;
    dateController.text = selectedDate ?? "";
  }

  void createNewBedAssign() {
    if (patientCases?.data?.isNotEmpty ?? true && caseId == null) {
      DisplaySnackBar.displaySnackBar("Please select case");
    } else if (bedId == null) {
      DisplaySnackBar.displaySnackBar("Please select bed");
    } else if (selectedDate == null) {
      DisplaySnackBar.displaySnackBar("Please select date");
    } else {
      CommonLoader.showLoader();
      StringUtils.client.createNewBedAssign(PreferenceUtils.getStringValue("token"), bedId, patientId, caseId ?? "", selectedDate ?? "")
        ..then((value) {
          if (value.success == true) {
            DisplaySnackBar.displaySnackBar("New Bed Assigned Successfully");
          }
          Get.back();
        })
        ..onError((DioError error, stackTrace) {
          Get.back();
          CheckSocketException.checkSocketException(error, 3, "You can't assign new bed");
          return CreateNewBedModel();
        });
    }
  }

  Future<String?> selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: oldDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      oldDate = picked;
      selectedDate = "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
      return selectedDate ?? "";
    } else {
      return null;
    }
  }
}
