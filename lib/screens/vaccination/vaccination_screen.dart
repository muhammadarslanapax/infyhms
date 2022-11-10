import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infyhms_flutter/constant/color_const.dart';
import 'package:infyhms_flutter/constant/text_style_const.dart';
import 'package:infyhms_flutter/controller/vaccination_controller/vaccination_controller.dart';

class VaccinationScreen extends StatelessWidget {
  VaccinationScreen({Key? key}) : super(key: key);
  final VaccinationController vaccinationController = Get.put(VaccinationController());

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Obx(
      () => vaccinationController.isGetVaccination.value == true
          ? vaccinationController.vaccinatedModel!.data!.isEmpty
              ? Center(
                  child: Center(
                    child: Text(
                      "No vaccinations found",
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
                    physics: const BouncingScrollPhysics(),
                    itemCount: vaccinationController.vaccinatedModel!.data!.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.only(left: 15, right: 15, top: index == 0 ? 15 : 5),
                        height: 60,
                        color: Colors.transparent,
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "${vaccinationController.vaccinatedModel!.data![index].vaccine_name} - ${vaccinationController.vaccinatedModel!.data![index].dose_number} Dose",
                              style: TextStyleConst.mediumTextStyle(
                                ColorConst.blackColor,
                                width * 0.045,
                              ),
                            ),
                            SizedBox(height: height * 0.004),
                            RichText(
                              text: TextSpan(
                                text: vaccinationController.vaccinatedModel!.data![index].serial_number,
                                style: TextStyleConst.mediumTextStyle(
                                  Colors.green,
                                  width * 0.037,
                                ),
                                children: [
                                  TextSpan(
                                    text:
                                        " | ${vaccinationController.vaccinatedModel!.data![index].time} - ${vaccinationController.vaccinatedModel!.data![index].date}",
                                    style: TextStyleConst.mediumTextStyle(
                                      ColorConst.hintGreyColor,
                                      width * 0.037,
                                    ),
                                  ),
                                ],
                              ),
                            )
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
