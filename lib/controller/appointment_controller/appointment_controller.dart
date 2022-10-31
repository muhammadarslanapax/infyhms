import 'package:get/get.dart';

class AppointmentController extends GetxController {
  // AppointmentModel? appointmentModel;
  RxList appointmentStatus = ["Past", "Upcoming", "Cancelled", "Completed"].obs;
  RxInt currentIndex = 0.obs;

  // @override
  // void onInit() {
  //   // TODO: implement onInit
  //   print(PreferenceUtils.getStringValue("token"));
  //   // StringUtils.client.getAppointments(PreferenceUtils.getStringValue("token"))
  //   //   ..then((value) {
  //   //     appointmentModel = value;
  //   //     print(appointmentModel?.success);
  //   //   })
  //   //   ..onError((DioError error, stackTrace) {
  //   //     print("error --- ${error.message}");
  //   //
  //   //     return AppointmentModel();
  //   //   });
  //   super.onInit();
  // }
}
