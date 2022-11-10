import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infyhms_flutter/model/auth_model/logout_model.dart';
import 'package:infyhms_flutter/screens/appointment/appointment_screen.dart';
import 'package:infyhms_flutter/utils/preference_utils.dart';
import 'package:infyhms_flutter/utils/string_utils.dart';
import 'package:infyhms_flutter/utils/variable_utils.dart';

class HomeController extends GetxController {
  Widget currentWidget = AppointmentScreen();
  LogoutModel? logoutModel;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  RxInt currentDrawerIndex = 0.obs;
  RxString appBarTitle = StringUtils.appointment.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    VariableUtils.firstName.value = PreferenceUtils.getStringValue("first_name");
    VariableUtils.lastName.value = PreferenceUtils.getStringValue("last_name");
    VariableUtils.email.value = PreferenceUtils.getStringValue("email");
    VariableUtils.phoneNo.value = PreferenceUtils.getStringValue("phone_number");
    VariableUtils.imageUrl.value = PreferenceUtils.getStringValue("image_url");

    print(VariableUtils.firstName.value);
  }
}
