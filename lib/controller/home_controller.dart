import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infyhms_flutter/component/common_loader.dart';
import 'package:infyhms_flutter/component/common_socket_exception.dart';
import 'package:infyhms_flutter/model/account_model/get_profile_model.dart';
import 'package:infyhms_flutter/model/auth_model/logout_model.dart';
import 'package:infyhms_flutter/screens/admission/admissions_screen.dart';
import 'package:infyhms_flutter/screens/appointment/appointment_screen.dart';
import 'package:infyhms_flutter/screens/auth/login_screen.dart';
import 'package:infyhms_flutter/screens/bills/bills_screen.dart';
import 'package:infyhms_flutter/screens/case/case_screen.dart';
import 'package:infyhms_flutter/screens/consultancy/live_consultations_screen.dart';
import 'package:infyhms_flutter/screens/diagnosis/diagnosis_screen.dart';
import 'package:infyhms_flutter/screens/document/document_screen.dart';
import 'package:infyhms_flutter/screens/invoice/invoice_screen.dart';
import 'package:infyhms_flutter/screens/notice/notice_board_screen.dart';
import 'package:infyhms_flutter/screens/prescription/prescriptions_screen.dart';
import 'package:infyhms_flutter/screens/vaccination/vaccination_screen.dart';
import 'package:infyhms_flutter/utils/preference_utils.dart';
import 'package:infyhms_flutter/utils/string_utils.dart';

class HomeController extends GetxController {
  Widget currentWidget = AppointmentScreen();
  LogoutModel? logoutModel;
  GetProfileModel? getProfileModel;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  RxInt currentDrawerIndex = 0.obs;
  RxString appBarTitle = StringUtils.appointment.obs;
  RxBool isSetValue = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getProfile();
  }

  Future getProfile() async {
    StringUtils.client.getProfile(PreferenceUtils.getStringValue("token"))
      ..then((value) {
        getProfileModel = value;
        if (getProfileModel!.success == true) {
          PreferenceUtils.setStringValue("first_name", getProfileModel!.data!.first_name!);
          PreferenceUtils.setStringValue("last_name", getProfileModel!.data!.last_name!);
          PreferenceUtils.setStringValue("email", getProfileModel!.data!.email!);
          PreferenceUtils.setStringValue("phone_number", getProfileModel!.data!.phone_number!);
          PreferenceUtils.setStringValue("image_url", getProfileModel!.data!.image_url!);
        }
      })
      ..onError((DioError error, stackTrace) {
        CheckSocketException.checkSocketException(error);
        return GetProfileModel();
      });
  }

  void logOut(BuildContext context) {
    Get.back();
    CommonLoader.showLoader(context);
    StringUtils.client.logout(PreferenceUtils.getStringValue("token")).then((value) {
      logoutModel = value;
      if (logoutModel!.success == true) {
        PreferenceUtils.setStringValue("token", "");
        Get.offAll(() => LoginScreen());
      }
    }).onError((DioError error, stackTrace) {
      CheckSocketException.checkSocketException(error);
    });
  }

  void changeWidget(int index) {
    Get.back();
    Get.deleteAll();
    update();
    switch (index) {
      case 0:
        currentWidget = AppointmentScreen();
        appBarTitle.value = StringUtils.appointment;
        currentDrawerIndex.value = 0;
        break;
      case 1:
        currentWidget = BillScreen();
        appBarTitle.value = StringUtils.bills;
        currentDrawerIndex.value = 1;
        break;
      case 2:
        currentWidget = DiagnosisScreen();
        appBarTitle.value = StringUtils.diagnosisTests;
        currentDrawerIndex.value = 2;
        break;
      case 3:
        currentWidget = const DocumentScreen();
        appBarTitle.value = StringUtils.documents;
        currentDrawerIndex.value = 3;
        break;
      case 4:
        currentWidget = const NoticeBoardScreen();
        appBarTitle.value = StringUtils.noticeBoards;
        currentDrawerIndex.value = 4;
        break;
      case 5:
        currentWidget = const InvoiceScreen();
        appBarTitle.value = StringUtils.invoices;
        currentDrawerIndex.value = 5;
        break;
      case 6:
        currentWidget = LiveConsultationsScreen();
        appBarTitle.value = StringUtils.liveConsultations;
        currentDrawerIndex.value = 6;
        break;
      case 7:
        currentWidget = CaseScreen();
        appBarTitle.value = StringUtils.myCases;
        currentDrawerIndex.value = 7;
        break;
      case 8:
        currentWidget = AdmissionScreen();
        appBarTitle.value = StringUtils.myAdmissions;
        currentDrawerIndex.value = 8;
        break;
      case 9:
        currentWidget = PrescriptionsScreen();
        appBarTitle.value = StringUtils.prescriptions;
        currentDrawerIndex.value = 9;
        break;
      case 10:
        currentWidget = VaccinationScreen();
        appBarTitle.value = StringUtils.vaccinatedPatients;
        currentDrawerIndex.value = 10;
        break;
    }
  }
}
