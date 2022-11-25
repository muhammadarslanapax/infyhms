import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infyhms_flutter/component/common_loader.dart';
import 'package:infyhms_flutter/component/common_snackbar.dart';
import 'package:infyhms_flutter/component/common_socket_exception.dart';
import 'package:infyhms_flutter/component/format_time_duration.dart';
import 'package:infyhms_flutter/model/doctor/doctor_schedule_model/doctor_schedule_model.dart';
import 'package:infyhms_flutter/model/doctor/doctor_schedule_model/doctor_schedule_update_model.dart';
import 'package:infyhms_flutter/utils/preference_utils.dart';
import 'package:infyhms_flutter/utils/string_utils.dart';

class SchedulesController extends GetxController {
  TextEditingController perPatientTimeController = TextEditingController();
  List<TextEditingController> controllerList = [];

  RxBool gotData = false.obs;

  DoctorScheduleModel? doctorScheduleModel;

  void updateSchedules() {
    List<String> availableOn = [];
    List<String> availableFrom = [];
    List<String> availableTo = [];

    for (int i = 0; i < (doctorScheduleModel?.data?.schedule?.length ?? 0); i++) {
      availableOn.add(doctorScheduleModel?.data?.schedule?[i].available_on ?? "");
      availableFrom.add(controllerList[i * 2].text);
      availableTo.add(controllerList[(i * 2) + 1].text);
    }

    Map<String, dynamic> data = {
      "per_patient_time": perPatientTimeController.text,
      "available_on": availableOn,
      "available_from": availableFrom,
      "available_to": availableTo,
    };
    var context;
    CommonLoader.showLoader(context);
    StringUtils.client.scheduleUpdate(PreferenceUtils.getStringValue("token"), doctorScheduleModel?.data?.id.toString() ?? "", data)
      ..then((value) {
        Get.back();
        DisplaySnackBar.displaySnackBar("Schedules updated successfully");
      })
      ..onError((DioError error, stackTrace) {
        Get.back();
        CheckSocketException.checkSocketException(error);
        return DoctorScheduleUpdateModel();
      });
  }

  void showTimePickerDialog(BuildContext context, int? index, String time) {
    String hour = time.split(":")[0];
    String minutes = time.split(":")[1];
    String seconds = time.split(":")[2];
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return CupertinoTimerPicker(
          initialTimerDuration: Duration(
            hours: int.parse(hour),
            minutes: int.parse(minutes),
            seconds: int.parse(seconds),
          ),
          onTimerDurationChanged: (value) {
            if (index != null) {
              controllerList[index].text = FormatTimeDuration.showDuration(value);
            } else {
              perPatientTimeController.text = FormatTimeDuration.showDuration(value);
            }
          },
          alignment: Alignment.bottomCenter,
        );
      },
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(50),
        ),
      ),
      backgroundColor: const Color(0xFFefeff4),
      constraints: const BoxConstraints(maxHeight: 250),
    );
  }

  void getSchedules() {
    StringUtils.client.schedule(PreferenceUtils.getStringValue("token"))
      ..then((value) {
        doctorScheduleModel = value;
        controllerList = List.generate((doctorScheduleModel?.data?.schedule?.length ?? 0) * 2, (index) {
          return TextEditingController();
        });
        perPatientTimeController.text = doctorScheduleModel?.data?.per_patient_time ?? "";
        for (int i = 0; i < (doctorScheduleModel?.data?.schedule?.length ?? 0); i++) {
          controllerList[i * 2].text = doctorScheduleModel?.data?.schedule?[i].available_from ?? "";
          controllerList[(i * 2) + 1].text = doctorScheduleModel?.data?.schedule?[i].available_to ?? "";
        }

        gotData.value = true;
      })
      ..onError((DioError error, stackTrace) {
        gotData.value = true;
        CheckSocketException.checkSocketException(error);
        return DoctorScheduleModel();
      });
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    getSchedules();
  }
}
