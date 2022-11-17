import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infyhms_flutter/component/common_socket_exception.dart';
import 'package:infyhms_flutter/model/account_model/get_profile_model.dart';
import 'package:infyhms_flutter/model/auth_model/logout_model.dart';
import 'package:infyhms_flutter/screens/appointment/appointment_screen.dart';
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
}
