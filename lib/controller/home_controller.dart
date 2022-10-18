import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infyhms_flutter/screens/appointment_screen.dart';
import 'package:infyhms_flutter/utils/string_utils.dart';

class HomeController extends GetxController {
  Widget currentWidget = AppointmentScreen();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  RxInt currentDrawerIndex = 0.obs;
  RxString appBarTitle = StringUtils.appointment.obs;
}
