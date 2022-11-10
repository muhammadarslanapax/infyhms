import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infyhms_flutter/constant/color_const.dart';
import 'package:infyhms_flutter/constant/text_style_const.dart';
import 'package:infyhms_flutter/controller/notice_board_controller.dart';

class NoticeBoardScreen extends StatelessWidget {
  const NoticeBoardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return GetBuilder<NoticeBoardController>(
        init: NoticeBoardController(),
        builder: (controller) {
          return Container(
            color: Colors.white,
            child: controller.noticeBoardModel == null
                ? const Center(child: CircularProgressIndicator(color: ColorConst.primaryColor))
                : controller.noticeBoardModel?.data?.isEmpty ?? true
                    ? Center(
                        child: Text(
                          "No notice found",
                          style: TextStyleConst.mediumTextStyle(
                            ColorConst.blackColor,
                            width * 0.04,
                          ),
                        ),
                      )
                    : ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: controller.noticeBoardModel?.data?.length ?? 0,
                        itemBuilder: (context, index) {
                          return ListTile(
                            onTap: () {
                              showModalBottomSheet(
                                shape: const OutlineInputBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(50),
                                    topRight: Radius.circular(50),
                                  ),
                                ),
                                context: context,
                                builder: (context) {
                                  return Container(
                                    constraints: BoxConstraints(minHeight: height * 0.3),
                                    margin: const EdgeInsets.only(right: 25, top: 15, left: 25),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Center(
                                            child: Container(
                                              height: 5,
                                              width: 60,
                                              decoration: BoxDecoration(color: const Color(0xffE7E9EB), borderRadius: BorderRadius.circular(5)),
                                            ),
                                          ),
                                          const SizedBox(height: 40),
                                          Text(
                                            controller.noticeBoardModel?.data?[index].title ?? "N/A",
                                            style: TextStyleConst.boldTextStyle(
                                              ColorConst.blackColor,
                                              width * 0.045,
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            controller.noticeBoardModel?.data?[index].description ?? "N/A",
                                            style: TextStyleConst.mediumTextStyle(
                                              ColorConst.hintGreyColor,
                                              width * 0.04,
                                            ),
                                          ),
                                          const SizedBox(height: 15),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            contentPadding: const EdgeInsets.only(right: 15, left: 15),
                            title: Padding(
                              padding: const EdgeInsets.only(bottom: 4),
                              child: Text(
                                controller.noticeBoardModel?.data?[index].title ?? "N/A",
                                style: TextStyleConst.mediumTextStyle(
                                  ColorConst.blackColor,
                                  width * 0.045,
                                ),
                              ),
                            ),
                            subtitle: Text(
                              "${controller.noticeBoardModel?.data?[index].time ?? "N/A"} - ${controller.noticeBoardModel?.data?[index].date ?? "N/A"}",
                              style: TextStyleConst.mediumTextStyle(
                                ColorConst.hintGreyColor,
                                width * 0.037,
                              ),
                            ),
                          );
                        },
                      ),
          );
        });
  }
}
