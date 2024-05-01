import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:infyhms_flutter/component/common_loader.dart';
import 'package:infyhms_flutter/component/common_snackbar.dart';
import 'package:infyhms_flutter/component/common_socket_exception.dart';
import 'package:infyhms_flutter/model/doctor/bed_assign_model/bed_assign_delete_model.dart';
import 'package:infyhms_flutter/model/doctor/bed_assign_model/bed_assign_model.dart';
import 'package:infyhms_flutter/utils/preference_utils.dart';
import 'package:infyhms_flutter/utils/string_utils.dart';

class BedAssignController extends GetxController {
  RxList appointmentStatus = ["All", "Active", "Deactive"].obs;
  RxInt currentIndex = 0.obs;
  BedAssignFilterModel? bedAssignFilterModel;
  RxBool isBedAssignDataCalled = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getBedAssignData();
  }

  void changeIndex(int index) {
    isBedAssignDataCalled.value = false;
    switch (index) {
      case 0:
        currentIndex.value = 0;
        getFilteredData("all");
        break;
      case 1:
        currentIndex.value = 1;
        getFilteredData("active");
        break;
      case 2:
        currentIndex.value = 2;
        getFilteredData("deactive");
        break;
    }
  }

  void getBedAssignData() {
    isBedAssignDataCalled.value = false;
    StringUtils.client.getBedData(PreferenceUtils.getStringValue("token"), "all")
      ..then((value) {
        bedAssignFilterModel = value;
        isBedAssignDataCalled.value = true;
      })
      ..onError((DioError error, stackTrace) {
        isBedAssignDataCalled.value = true;
        bedAssignFilterModel = BedAssignFilterModel(data: []);
        CheckSocketException.checkSocketException(error);
        return BedAssignFilterModel();
      });
  }

  void getFilteredData(String status) {
    StringUtils.client.getBedData(PreferenceUtils.getStringValue("token"), status)
      ..then((value) {
        bedAssignFilterModel = value;
        isBedAssignDataCalled.value = true;
      })
      ..onError((DioError error, stackTrace) {
        isBedAssignDataCalled.value = true;
        bedAssignFilterModel = BedAssignFilterModel(data: []);
        CheckSocketException.checkSocketException(error);
        return BedAssignFilterModel();
      });
  }

  void deleteBedAssign(BuildContext context, String id, int index) {
    Get.back();
    if (Get.isSnackbarOpen) {
      Get.closeCurrentSnackbar();
    }
    CommonLoader.showLoader();
    StringUtils.client.deleteBedAssign(PreferenceUtils.getStringValue("token"), id)
      ..then((value) {
        if (value.success == true) {
          isBedAssignDataCalled.value = true;

          DisplaySnackBar.displaySnackBar("Bed Deleted");
          changeIndex(index);
        } else {
          Get.back();
        }
      })
      ..onError((DioError error, stackTrace) {
        Get.back();
        CheckSocketException.checkSocketException(error);
        return BedAssignDelete();
      });
  }
}
