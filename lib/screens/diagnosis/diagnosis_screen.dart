import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infyhms_flutter/constant/color_const.dart';
import 'package:infyhms_flutter/constant/text_style_const.dart';
import 'package:infyhms_flutter/controller/diagnosis_controller/diagnosis_test_controller.dart';
import 'package:infyhms_flutter/screens/diagnosis/diagnosis_test_detail_screen.dart';
import 'package:infyhms_flutter/utils/image_utils.dart';

class DiagnosisScreen extends StatelessWidget {
  DiagnosisScreen({Key? key}) : super(key: key);
  final DiagnosisTestController diagnosisTestController = Get.put(DiagnosisTestController());

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Obx(
      () => diagnosisTestController.isDiagnosisTestApiCall.value == true
          ? diagnosisTestController.diagnosisTestModel!.data!.isEmpty
              ? Container(
                  color: ColorConst.whiteColor,
                  child: Center(
                    child: Text(
                      "No diagnosis test found",
                      style: TextStyleConst.mediumTextStyle(
                        ColorConst.blackColor,
                        width * 0.04,
                      ),
                    ),
                  ),
                )
              : Container(
                  color: Colors.white,
                  child: ListView.builder(
                    itemCount: diagnosisTestController.diagnosisTestModel!.data!.length,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {
                          Get.to(
                            () => DiagnosisTestDetailScreen(),
                            transition: Transition.rightToLeft,
                            arguments: diagnosisTestController.diagnosisTestModel!.data![index].id,
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
                              image: NetworkImage(diagnosisTestController.diagnosisTestModel!.data![index].patient_image!),
                            ),
                          ),
                        ),
                        trailing: GestureDetector(
                          onTap: () {
                            diagnosisTestController.downloadPDF(context, diagnosisTestController.diagnosisTestModel!.data![index].pdf_url!);
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
                        title: Text(
                          diagnosisTestController.diagnosisTestModel!.data![index].doctor_name!,
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
                              diagnosisTestController.diagnosisTestModel!.data![index].category!,
                              style: TextStyleConst.mediumTextStyle(
                                ColorConst.hintGreyColor,
                                width * 0.035,
                              ),
                            ),
                            Text(
                              "${diagnosisTestController.diagnosisTestModel!.data![index].report_number!} | ${diagnosisTestController.diagnosisTestModel!.data![index].created_at}",
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
