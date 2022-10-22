import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:infyhms_flutter/constant/color_const.dart';
import 'package:infyhms_flutter/constant/text_style_const.dart';
import 'package:infyhms_flutter/controller/appointment_controller.dart';
import 'package:infyhms_flutter/model/appointment_model.dart';
import 'package:infyhms_flutter/screens/appointment/new_appointment_screen.dart';
import 'package:infyhms_flutter/utils/preference_utils.dart';
import 'package:infyhms_flutter/utils/string_utils.dart';

class AppointmentScreen extends StatefulWidget {
  AppointmentScreen({Key? key}) : super(key: key);

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  final AppointmentController appointmentController = Get.put(AppointmentController());
  AppointmentModel? appointmentModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    StringUtils.client.getAppointments("Bearer ${PreferenceUtils.getStringValue("token")}")
      ..then((value) {
        appointmentModel = value;
        print(appointmentModel?.success);
      })
      ..onError((DioError error, stackTrace) {
        print("error --- ${error.message}");

        return AppointmentModel();
      });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      color: ColorConst.whiteColor,
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                height: 70,
                margin: EdgeInsets.only(top: height * 0.01),
                width: double.infinity,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: appointmentController.appointmentStatus.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Center(
                      child: Obx(
                        () => GestureDetector(
                          onTap: () {
                            switch (index) {
                              case 0:
                                appointmentController.currentIndex.value = 0;
                                break;
                              case 1:
                                appointmentController.currentIndex.value = 1;
                                break;
                              case 2:
                                appointmentController.currentIndex.value = 2;
                                break;
                              case 3:
                                appointmentController.currentIndex.value = 3;
                                break;
                            }
                          },
                          child: Container(
                            margin: EdgeInsets.only(left: width * 0.03, right: index == 3 ? 10 : 0),
                            height: 45,
                            decoration: index == appointmentController.currentIndex.value
                                ? BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: ColorConst.blueColor,
                                  )
                                : BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      width: 2,
                                      color: ColorConst.borderGreyColor,
                                    ),
                                  ),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                child: Text(
                                  appointmentController.appointmentStatus[index],
                                  style: TextStyleConst.mediumTextStyle(
                                    index == appointmentController.currentIndex.value ? ColorConst.whiteColor : ColorConst.hintGreyColor,
                                    width * 0.04,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              appointmentModel != null
                  ? Expanded(
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: appointmentModel!.data!.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Slidable(
                                startActionPane: ActionPane(
                                  extentRatio: 0.2,
                                  motion: const ScrollMotion(),
                                  children: [
                                    SlidableAction(
                                      onPressed: (context) {},
                                      backgroundColor: ColorConst.borderGreyColor,
                                      foregroundColor: Colors.white,
                                      label: StringUtils.cancel,
                                      lableColor: ColorConst.hintGreyColor,
                                    ),
                                  ],
                                ),
                                endActionPane: ActionPane(
                                  extentRatio: 0.2,
                                  motion: const ScrollMotion(),
                                  children: [
                                    SlidableAction(
                                      onPressed: (context) {},
                                      backgroundColor: const Color(0xFFFCE5E5),
                                      foregroundColor: Colors.white,
                                      label: StringUtils.delete,
                                      lableColor: Colors.red,
                                    ),
                                  ],
                                ),
                                child: ListTile(
                                  title: Text(
                                    appointmentModel!.data![index].doctor_name!,
                                    style: TextStyleConst.mediumTextStyle(
                                      ColorConst.blackColor,
                                      width * 0.045,
                                    ),
                                  ),
                                  subtitle: Row(
                                    children: [
                                      Text(
                                        "${appointmentModel!.data![index].doctor_department!} |",
                                        style: TextStyleConst.mediumTextStyle(
                                          ColorConst.hintGreyColor,
                                          width * 0.037,
                                        ),
                                      ),
                                      Text(
                                        "${appointmentModel!.data![index].appointment_time!} -",
                                        style: TextStyleConst.mediumTextStyle(
                                          ColorConst.hintGreyColor,
                                          width * 0.037,
                                        ),
                                      ),
                                      Text(
                                        appointmentModel!.data![index].appointment_date!,
                                        style: TextStyleConst.mediumTextStyle(
                                          ColorConst.hintGreyColor,
                                          width * 0.037,
                                        ),
                                      ),
                                    ],
                                  ),
                                  leading: Container(
                                    height: 60,
                                    width: 60,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQQ-YIPLhIBLVQKh_S4BNo18b03Ct5P_iYFeBBjDCYx&s"),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: height * 0.01),
                            ],
                          );
                        },
                      ),
                    )
                  : const Center(child: CircularProgressIndicator())
            ],
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: GestureDetector(
                onTap: () {
                  Get.to(() => NewAppointmentScreen(), transition: Transition.circularReveal);
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
      ),
    );
  }
}
