import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infyhms_flutter/component/common_loader.dart';
import 'package:infyhms_flutter/component/common_snackbar.dart';
import 'package:infyhms_flutter/component/common_socket_exception.dart';
import 'package:infyhms_flutter/model/doctor/bed_assign_model/bed_update_model.dart';
import 'package:infyhms_flutter/model/doctor/bed_assign_model/beds_model.dart';
import 'package:infyhms_flutter/model/doctor/bed_assign_model/ipd_patients_model.dart';
import 'package:infyhms_flutter/model/doctor/bed_assign_model/patient_cases_model.dart';
import 'package:infyhms_flutter/utils/preference_utils.dart';
import 'package:infyhms_flutter/utils/string_utils.dart';

class EditBedController extends GetxController {
  String? selectedDate = "";
  String? selectedBedAssignDate = "";
  String? selectedDischargeDate = "";

  final TextEditingController selectedBedAssignController = TextEditingController();
  final TextEditingController selectedDischargeController = TextEditingController();
  final TextEditingController notesController = TextEditingController();
  PatientCases? patientCases;
  IPDPatientsModel? ipdPatientsModel;
  BedsModel? bedsModel;
  RxBool isCasesApiCalled = false.obs;



  DateTime? oldAssignDate;
  DateTime? oldDischargeDate;

  String? myCases;
  String? ipdPatient;
  String? bed;

  String? myCasesId;
  String? ipdPatientId;
  String? bedId;

  String? assignId;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getMyCases();

  }

  assignValue(Map<String, dynamic> bedAssignData){
    selectedBedAssignDate = bedAssignData["assignDate"];
    selectedBedAssignController.text = selectedBedAssignDate ?? "";
    bedId = bedAssignData["bedId"];
    bed = bedAssignData["bed"];
    assignId = bedAssignData["assignId"];
  }

  Future<String?> selectDate(BuildContext context, DateTime? oldDate, bool isAssign) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: oldDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      if (isAssign) {
        oldAssignDate = picked;
      } else {
        oldDischargeDate = picked;
      }
      selectedDate = "${picked.day.toString().padLeft(2, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.year}";
      return selectedDate ?? "";
    } else {
      return null;
    }
  }

  void getMyCases() {
    StringUtils.client.getPatientCases(PreferenceUtils.getStringValue("token"))
      ..then((value) {
        patientCases = value;
        String? caseId = value.data?.isEmpty ?? true ? null : value.data?[0].patient_case?.split(" ").first ?? "";
        myCasesId = caseId;
        getIPDPatients(caseId);
        getBeds();
      })
      ..onError((DioError error, stackTrace) {
        isCasesApiCalled.value = true;
        return PatientCases();
      });
  }

  void getIPDPatients(String? caseId) {
    StringUtils.client.getIPDModel(PreferenceUtils.getStringValue("token"), caseId ?? "")
      ..then((value) {
        ipdPatientsModel = value;
      })
      ..onError((DioError error, stackTrace) {
        return IPDPatientsModel();
      });
  }

  void getBeds() {
    StringUtils.client.getBedsForEdit(PreferenceUtils.getStringValue("token"), "$bedId")
      ..then((value) {
        bedsModel = value;
        isCasesApiCalled.value = true;
      })
      ..onError((DioError error, stackTrace) {
        return BedsModel();
      });
  }

  void selectAssignDate(BuildContext context) async {
    selectedBedAssignDate = (await selectDate(context, oldAssignDate, true)) ?? selectedBedAssignDate;
    selectedBedAssignController.text = selectedBedAssignDate ?? "";
  }

  void selectDischargeDate(BuildContext context) async {
    selectedDischargeDate = (await selectDate(context, oldDischargeDate, false)) ?? selectedDischargeDate;
    selectedDischargeController.text = selectedDischargeDate ?? "";
  }

  void saveData(String assignId) {
    if (bedId == null) {
      DisplaySnackBar.displaySnackBar("Please select bed");
    } else if (selectedBedAssignDate == null) {
      DisplaySnackBar.displaySnackBar("Please select assign date");
    } else if (selectedDischargeDate == null) {
      DisplaySnackBar.displaySnackBar("Please select discharge date");
    } else {
      CommonLoader.showLoader();
      StringUtils.client.updateBedAssign(
        PreferenceUtils.getStringValue("token"),
        assignId,
        "$bedId",
        "$ipdPatientId",
        "$myCasesId",
        "$selectedBedAssignDate",
        "$selectedDischargeDate",
      )
        ..then((value) {
          Get.back();
          Get.back(result: "Call API");
          DisplaySnackBar.displaySnackBar("Bed details updated successfully");
        })
        ..onError((DioError error, stackTrace) {
          Get.back();
          CheckSocketException.checkSocketException(error);
          return BedUpdatedDetailsModel();
        });
    }
  }
}
