import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:infyhms_flutter/component/common_socket_exception.dart';
import 'package:infyhms_flutter/model/doctor/report_model/common_report_model/common_report_model.dart';
import 'package:infyhms_flutter/model/doctor/report_model/common_report_model/delete_common_report_model.dart';
import 'package:infyhms_flutter/model/doctor/report_model/investigation_report_model/investigation_report_model.dart';
import 'package:infyhms_flutter/utils/preference_utils.dart';
import 'package:infyhms_flutter/utils/string_utils.dart';

class ReportScreenController extends GetxController {
  CommonReportModel? commonReportModel;
  DeleteCommonReportModel? deleteCommonReportModel;
  InvestigationReportModel? investigationReportModel;
  RxBool isGotReport = false.obs;
  String report = Get.arguments;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    callReportApi();
  }

  void callReportApi() {
    switch (report) {
      case StringUtils.birthReport:
        getBirthReport();
        break;
      case StringUtils.deathReport:
        getDeathReport();
        break;
      case StringUtils.investigationReport:
        getInvestigationReport();
        break;
      case StringUtils.operationReport:
        getOperationReport();
        break;
    }
  }

  void deleteReport(int id) {
    Get.back();
    switch (report) {
      case StringUtils.birthReport:
        deleteBirthReport(id);
        break;
      case StringUtils.deathReport:
        deleteDeathReport(id);
        break;
      case StringUtils.investigationReport:
        deleteInvestigationReport(id);
        break;
      case StringUtils.operationReport:
        deleteOperationReport(id);
        break;
    }
  }

  void getBirthReport() {
    StringUtils.client.getBirthReport(PreferenceUtils.getStringValue("token"))
      ..then((value) {
        commonReportModel = value;
        if (commonReportModel!.success == true) {
          isGotReport.value = true;
        }
      })
      ..onError((DioError error, stackTrace) {
        isGotReport.value = true;
        CheckSocketException.checkSocketException(error);
        return CommonReportModel();
      });
  }

  void getDeathReport() {
    StringUtils.client.getDeathReport(PreferenceUtils.getStringValue("token"))
      ..then((value) {
        commonReportModel = value;
        if (commonReportModel!.success == true) {
          isGotReport.value = true;
        }
      })
      ..onError((DioError error, stackTrace) {
        isGotReport.value = true;
        CheckSocketException.checkSocketException(error);
        return CommonReportModel();
      });
  }

  void getInvestigationReport() {
    StringUtils.client.getInvestigationReport(PreferenceUtils.getStringValue("token"))
      ..then((value) {
        investigationReportModel = value;
        if (investigationReportModel!.success == true) {
          isGotReport.value = true;
        }
      })
      ..onError((DioError error, stackTrace) {
        isGotReport.value = true;
        CheckSocketException.checkSocketException(error);
        return InvestigationReportModel();
      });
  }

  void getOperationReport() {
    StringUtils.client.getOperationReport(PreferenceUtils.getStringValue("token"))
      ..then((value) {
        commonReportModel = value;
        if (commonReportModel!.success == true) {
          isGotReport.value = true;
        }
      })
      ..onError((DioError error, stackTrace) {
        isGotReport.value = true;
        CheckSocketException.checkSocketException(error);
        return CommonReportModel();
      });
  }

  void deleteBirthReport(int id) {
    isGotReport.value = false;
    StringUtils.client.deleteBirthReport(PreferenceUtils.getStringValue("token"), id)
      ..then((value) {
        deleteCommonReportModel = value;
        if (deleteCommonReportModel!.success == true) {
          getBirthReport();
        }
      })
      ..onError((DioError error, stackTrace) {
        getBirthReport();
        CheckSocketException.checkSocketException(error);
        return DeleteCommonReportModel();
      });
  }

  void deleteDeathReport(int id) {
    isGotReport.value = false;
    StringUtils.client.deleteDeathReport(PreferenceUtils.getStringValue("token"), id)
      ..then((value) {
        deleteCommonReportModel = value;
        if (deleteCommonReportModel!.success == true) {
          getDeathReport();
        }
      })
      ..onError((DioError error, stackTrace) {
        getDeathReport();
        CheckSocketException.checkSocketException(error);
        return DeleteCommonReportModel();
      });
  }

  void deleteOperationReport(int id) {
    isGotReport.value = false;
    StringUtils.client.deleteOperationReport(PreferenceUtils.getStringValue("token"), id)
      ..then((value) {
        deleteCommonReportModel = value;
        if (deleteCommonReportModel!.success == true) {
          getOperationReport();
        }
      })
      ..onError((DioError error, stackTrace) {
        getOperationReport();
        CheckSocketException.checkSocketException(error);
        return DeleteCommonReportModel();
      });
  }

  void deleteInvestigationReport(int id) {
    isGotReport.value = false;
    StringUtils.client.deleteInvestigationReport(PreferenceUtils.getStringValue("token"), id)
      ..then((value) {
        deleteCommonReportModel = value;
        if (deleteCommonReportModel!.success == true) {
          getInvestigationReport();
        }
      })
      ..onError((DioError error, stackTrace) {
        getInvestigationReport();
        CheckSocketException.checkSocketException(error);
        return DeleteCommonReportModel();
      });
  }
}
