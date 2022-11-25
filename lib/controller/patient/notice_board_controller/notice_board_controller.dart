import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:infyhms_flutter/component/common_socket_exception.dart';
import 'package:infyhms_flutter/model/patient/notice_board_model/notice_board.dart';
import 'package:infyhms_flutter/utils/preference_utils.dart';
import 'package:infyhms_flutter/utils/string_utils.dart';

class NoticeBoardController extends GetxController {
  NoticeBoardModel? noticeBoardModel;
  RxBool isGotNotice = false.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getNotice();
  }

  void getNotice() {
    StringUtils.client.getNoticeBoard(PreferenceUtils.getStringValue("token"))
      ..then((value) {
        noticeBoardModel = value;
        isGotNotice.value = true;
      })
      ..onError((DioError error, stackTrace) {
        isGotNotice.value = true;
        CheckSocketException.checkSocketException(error);
        return NoticeBoardModel();
      });
  }
}
