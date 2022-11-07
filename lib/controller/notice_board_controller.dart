import 'package:get/get.dart';
import 'package:infyhms_flutter/model/notice_board_model/notice_board.dart';
import 'package:infyhms_flutter/utils/string_utils.dart';

class NoticeBoardController extends GetxController {
  NoticeBoardModel? noticeBoardModel;


  void getNotice(){
    StringUtils.client.getNoticeBoard("");
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getNotice();
  }
}
