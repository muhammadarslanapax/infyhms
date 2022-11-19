import 'package:get/get.dart';
import 'package:infyhms_flutter/model/doctor/doctor_prescription_model/doctor_prescription_detail_model.dart';

class DoctorPrescriptionDetailController extends GetxController {
  RxBool isGetDetail = false.obs;
  RxBool isDownloading = false.obs;
  DoctorPrescriptionDetailModel? doctorPrescriptionDetailModel;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
}
