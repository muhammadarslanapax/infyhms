import 'package:get/get.dart';

class DoctorAppointmentController extends GetxController {
  RxList appointmentStatus = ["Pending", "Cancelled", "Completed"].obs;
  RxInt currentIndex = 0.obs;
}
