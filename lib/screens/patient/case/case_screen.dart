import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infyhms_flutter/constant/color_const.dart';
import 'package:infyhms_flutter/constant/text_style_const.dart';
import 'package:infyhms_flutter/controller/patient/case_controller/case_controller.dart';
import 'package:infyhms_flutter/screens/patient/case/case_detail_screen.dart';

class CaseScreen extends StatelessWidget {
  CaseScreen({Key? key}) : super(key: key);
  final CaseController caseController = Get.put(CaseController());

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Obx(
      () => caseController.isGetCase.value == true
          ? caseController.caseModel!.data!.isEmpty
              ? Container(
                  color: ColorConst.whiteColor,
                  child: Center(
                    child: Text(
                      "No cases found",
                      style: TextStyleConst.mediumTextStyle(
                        ColorConst.blackColor,
                        width * 0.04,
                      ),
                    ),
                  ),
                )
              : Container(
                  color: ColorConst.whiteColor,
                  child: ListView.builder(
                    itemCount: caseController.caseModel!.data!.length,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {
                          Get.to(
                            () => CaseDetailScreen(),
                            transition: Transition.rightToLeft,
                            arguments: {
                              "case_id": caseController.caseModel!.data![index].case_id,
                              "case_date": caseController.caseModel!.data![index].case_date,
                              "doctor_name": caseController.caseModel!.data![index].doctor_name,
                              "case_time": caseController.caseModel!.data![index].case_time,
                              "fee": caseController.caseModel!.data![index].fee,
                              "created_on": caseController.caseModel!.data![index].created_on,
                              "status": caseController.caseModel!.data![index].status,
                              "currency": caseController.caseModel!.data![index].currency,
                              "description": caseController.caseModel!.data![index].description,
                            },
                          );
                        },
                        contentPadding: EdgeInsets.only(top: index == 0 ? 15 : 10, left: 15, right: 15),
                        leading: Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(caseController.caseModel!.data![index].doctor_image!),
                            ),
                          ),
                        ),
                        title: Text(
                          caseController.caseModel!.data![index].doctor_name!,
                          style: TextStyleConst.mediumTextStyle(
                            ColorConst.blackColor,
                            width * 0.045,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: height * 0.002),
                            Text(
                              caseController.caseModel!.data![index].status!,
                              style: TextStyleConst.mediumTextStyle(
                                ColorConst.greenColor,
                                width * 0.035,
                              ),
                            ),
                            SizedBox(height: height * 0.004),
                            Text(
                              "${caseController.caseModel!.data![index].case_id!}  |  ${caseController.caseModel!.data![index].case_time!} - ${caseController.caseModel!.data![index].case_date!}",
                              style: TextStyleConst.mediumTextStyle(
                                ColorConst.hintGreyColor,
                                width * 0.036,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
