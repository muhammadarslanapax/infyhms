import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:infyhms_flutter/constant/color_const.dart';
import 'package:infyhms_flutter/constant/text_style_const.dart';
import 'package:infyhms_flutter/controller/document_controller/document_list_controller.dart';
import 'package:infyhms_flutter/screens/document/edit_document_screen.dart';
import 'package:infyhms_flutter/screens/document/new_document_screen.dart';
import 'package:infyhms_flutter/utils/image_utils.dart';
import 'package:infyhms_flutter/utils/string_utils.dart';

class DocumentScreen extends StatelessWidget {
  const DocumentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return GetBuilder<DocumentController>(
        init: DocumentController(),
        builder: (controller) {
          return Stack(
            children: [
              Container(
                color: Colors.white,
                child: controller.documentsModel == null
                    ? const Center(child: CircularProgressIndicator(color: ColorConst.primaryColor))
                    : controller.documentsModel?.data?.isEmpty ?? true
                        ? Center(
                            child: Text(
                              "No documents found",
                              style: TextStyleConst.mediumTextStyle(
                                ColorConst.blackColor,
                                width * 0.04,
                              ),
                            ),
                          )
                        : ListView.builder(
                            itemCount: controller.documentsModel!.data!.length,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  Slidable(
                                    startActionPane: ActionPane(
                                      extentRatio: 0.25,
                                      motion: const ScrollMotion(),
                                      children: [
                                        SlidableAction(
                                          onPressed: (contextAction) async {
                                            final message = await Get.to(
                                                () => EditDocumentScreen(documentId: controller.documentsModel?.data?[index].id ?? 0),
                                                transition: Transition.leftToRight,
                                                arguments: {
                                                  "title": controller.documentsModel?.data?[index].title,
                                                  "docType": controller.documentsModel?.data?[index].document_type_id,
                                                  "attachment": controller.documentsModel?.data?[index].document_url,
                                                  "note": controller.documentsModel?.data?[index].notes,
                                                });
                                            if (message == "Call API") {
                                              controller.getDocuments();
                                            }
                                          },
                                          backgroundColor: ColorConst.orangeColor.withOpacity(0.15),
                                          label: StringUtils.edit,
                                          lableColor: ColorConst.orangeColor,
                                        ),
                                      ],
                                    ),
                                    endActionPane: ActionPane(
                                      extentRatio: 0.25,
                                      motion: const ScrollMotion(),
                                      children: [
                                        SlidableAction(
                                          onPressed: (contextAction) {
                                            controller.showDeleteDialog(context, height, width, index);
                                          },
                                          backgroundColor: const Color(0xFFFCE5E5),
                                          label: StringUtils.delete,
                                          lableColor: ColorConst.redColor,
                                        ),
                                      ],
                                    ),
                                    child: ListTile(
                                      onTap: () {},
                                      contentPadding: EdgeInsets.only(top: index == 0 ? 15 : 0, right: 15, left: 15),
                                      title: Text(
                                        controller.documentsModel?.data?[index].title ?? "",
                                        style: TextStyleConst.mediumTextStyle(
                                          ColorConst.blackColor,
                                          width * 0.045,
                                        ),
                                      ),
                                      subtitle: Text(
                                        controller.documentsModel?.data?[index].notes ?? "",
                                        style: TextStyleConst.mediumTextStyle(
                                          ColorConst.hintGreyColor,
                                          width * 0.037,
                                        ),
                                      ),
                                      leading: Container(
                                        height: 35,
                                        width: 35,
                                        decoration: const BoxDecoration(
                                          image: DecorationImage(
                                            fit: BoxFit.contain,
                                            // image: NetworkImage(controller.documentsModel?.data?[index].document_url ?? ""),
                                            image: AssetImage("assets/icon/imageIcon.png"),
                                          ),
                                        ),
                                      ),
                                      trailing: Obx(
                                        () => controller.isDownloading.value && controller.currentIndex!.value == index
                                            ? const CircularProgressIndicator(color: ColorConst.primaryColor)
                                            : InkWell(
                                                onTap: () {
                                                  controller.downloadDocument(context, index);
                                                },
                                                child: Container(
                                                  margin: const EdgeInsets.only(right: 10),
                                                  width: 25,
                                                  height: 25,
                                                  decoration: const BoxDecoration(
                                                    image: DecorationImage(
                                                      image: AssetImage(ImageUtils.downloadIcon),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.all(25),
                  child: GestureDetector(
                    onTap: () async {
                      final message = await Get.to(() => const NewDocumentScreen(), transition: Transition.rightToLeft);
                      if (message == "Call API") {
                        controller.getDocuments();
                      }
                    },
                    child: Container(
                      height: 55,
                      width: 55,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: ColorConst.blueColor,
                      ),
                      child: const Icon(Icons.add, color: ColorConst.whiteColor),
                    ),
                  ),
                ),
              ),
            ],
          );
        });
  }
}
