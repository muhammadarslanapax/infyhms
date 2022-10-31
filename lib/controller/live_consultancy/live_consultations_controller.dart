import 'package:get/get.dart';

class LiveConsultationsController extends GetxController {
  RxList consultationsStatus = ["All", "Awaited", "Cancelled", "Finished"].obs;
  RxInt currentIndex = 0.obs;
}
