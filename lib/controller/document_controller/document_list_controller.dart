import 'package:get/get.dart';
import 'package:infyhms_flutter/model/documents/documents_model/documents.dart';
import 'package:infyhms_flutter/utils/preference_utils.dart';
import 'package:infyhms_flutter/utils/string_utils.dart';

class DocumentController extends GetxController {
  DocumentsModel? documentsModel;

  void getDocuments() {
    StringUtils.client.getDocuments("Bearer ${PreferenceUtils.getStringValue("token")}").then((value) {
      documentsModel = value;
      update();
    });

  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getDocuments();
  }
}
