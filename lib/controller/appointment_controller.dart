import 'package:get/get.dart';

class AppointmentController extends GetxController {
  RxList appointmentStatus = ["Past", "Upcoming", "Cancelled", "Completed"].obs;
  RxInt currentIndex = 0.obs;
}
