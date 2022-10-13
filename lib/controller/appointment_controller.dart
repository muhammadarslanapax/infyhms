import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppointmentController extends GetxController {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  RxList appointmentStatus = ["Past", "Upcoming", "Cancelled", "Completed"].obs;
  RxInt currentIndex = 0.obs;
  RxInt currentDrawerIndex = 0.obs;
}
