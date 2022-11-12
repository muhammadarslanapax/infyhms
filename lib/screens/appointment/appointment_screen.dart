import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:infyhms_flutter/component/common_button.dart';
import 'package:infyhms_flutter/component/common_snackbar.dart';
import 'package:infyhms_flutter/component/common_socket_exception.dart';
import 'package:infyhms_flutter/constant/color_const.dart';
import 'package:infyhms_flutter/constant/text_style_const.dart';
import 'package:infyhms_flutter/controller/appointment_controller/appointment_controller.dart';
import 'package:infyhms_flutter/controller/appointment_controller/filter_appointment_controller.dart';
import 'package:infyhms_flutter/screens/appointment/new_appointment_screen.dart';
import 'package:infyhms_flutter/utils/image_utils.dart';
import 'package:infyhms_flutter/utils/preference_utils.dart';
import 'package:infyhms_flutter/utils/string_utils.dart';

class AppointmentScreen extends StatelessWidget {
  AppointmentScreen({Key? key}) : super(key: key);
  final AppointmentController appointmentController = Get.put(AppointmentController());
  final FilterAppointmentController filterAppointmentController = Get.put(FilterAppointmentController());

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
                            filterAppointmentController.isApiCall.value = false;
                            switch (index) {
                              case 0:
                                filterAppointmentController.isApiCall.value = false;

                                appointmentController.currentIndex.value = 0;
                                StringUtils.client.getPastAppointments("Bearer ${PreferenceUtils.getStringValue("token")}", "past").then((value) {
                                  filterAppointmentController.filterAppointmentModel = value;
                                  filterAppointmentController.isApiCall.value = true;
                                }).onError((DioError error, stackTrace) {
                                  CheckSocketException.checkSocketException(error);
                                });
                                break;
                              case 1:
                                filterAppointmentController.isApiCall.value = false;

                                appointmentController.currentIndex.value = 1;
                                StringUtils.client.getPastAppointments("Bearer ${PreferenceUtils.getStringValue("token")}", "pending").then((value) {
                                  filterAppointmentController.filterAppointmentModel = value;
                                  filterAppointmentController.isApiCall.value = true;
                                }).onError((DioError error, stackTrace) {
                                  CheckSocketException.checkSocketException(error);
                                });
                                break;
                              case 2:
                                filterAppointmentController.isApiCall.value = false;

                                appointmentController.currentIndex.value = 2;
                                StringUtils.client
                                    .getPastAppointments("Bearer ${PreferenceUtils.getStringValue("token")}", "cancelled")
                                    .then((value) {
                                  filterAppointmentController.filterAppointmentModel = value;
                                  filterAppointmentController.isApiCall.value = true;
                                }).onError((DioError error, stackTrace) {
                                  CheckSocketException.checkSocketException(error);
                                });
                                break;
                              case 3:
                                filterAppointmentController.isApiCall.value = false;

                                appointmentController.currentIndex.value = 3;
                                StringUtils.client
                                    .getPastAppointments("Bearer ${PreferenceUtils.getStringValue("token")}", "completed")
                                    .then((value) {
                                  filterAppointmentController.filterAppointmentModel = value;
                                  filterAppointmentController.isApiCall.value = true;
                                }).onError((DioError error, stackTrace) {
                                  CheckSocketException.checkSocketException(error);
                                });
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
              Obx(
                () => filterAppointmentController.isApiCall.value != false
                    ? filterAppointmentController.filterAppointmentModel!.data!.isNotEmpty
                        ? Expanded(
                            child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemCount: filterAppointmentController.filterAppointmentModel!.data!.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    appointmentController.currentIndex.value != 2
                                        ? Slidable(
                                            startActionPane: ActionPane(
                                              extentRatio: 0.25,
                                              motion: const ScrollMotion(),
                                              children: [
                                                SlidableAction(
                                                  onPressed: (context) {
                                                    showDialog(
                                                      barrierDismissible: false,
                                                      context: context,
                                                      builder: (context) {
                                                        return Center(
                                                          child: Container(
                                                            height: height / 2.7,
                                                            width: width / 1.12,
                                                            decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.circular(15),
                                                              color: Colors.white,
                                                            ),
                                                            child: Column(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              children: [
                                                                Container(
                                                                  height: 60,
                                                                  width: 60,
                                                                  decoration: const BoxDecoration(
                                                                    image: DecorationImage(
                                                                      image: AssetImage(ImageUtils.alertIcon),
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(height: height * 0.03),
                                                                Text(
                                                                  "Cancel Appointment",
                                                                  style: TextStyleConst.boldTextStyle(
                                                                    ColorConst.blackColor,
                                                                    width * 0.05,
                                                                  ),
                                                                ),
                                                                SizedBox(height: height * 0.01),
                                                                Text(
                                                                  "Are you sure want to cancel\n Appointment?",
                                                                  textAlign: TextAlign.center,
                                                                  style: TextStyleConst.mediumTextStyle(
                                                                    ColorConst.hintGreyColor,
                                                                    width * 0.042,
                                                                  ),
                                                                ),
                                                                SizedBox(height: height * 0.03),
                                                                Row(
                                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                  children: [
                                                                    CommonButton(
                                                                      textStyleConst: TextStyleConst.mediumTextStyle(
                                                                        ColorConst.whiteColor,
                                                                        width * 0.05,
                                                                      ),
                                                                      onTap: () {
                                                                        print(filterAppointmentController.filterAppointmentModel!.data![index].id);
                                                                        StringUtils.client
                                                                            .cancelAppointment("Bearer ${PreferenceUtils.getStringValue("token")}",
                                                                                filterAppointmentController.filterAppointmentModel!.data![index].id!)
                                                                            .then((value) {
                                                                          filterAppointmentController.cancelAppointmentModel = value;
                                                                          print(filterAppointmentController.cancelAppointmentModel!.success);
                                                                          print(filterAppointmentController.cancelAppointmentModel!.message);
                                                                          if (filterAppointmentController.cancelAppointmentModel!.success == true) {
                                                                            DisplaySnackBar.displaySnackBar(
                                                                                context, "Appoinemnt cancel successfully");
                                                                          }
                                                                          Get.back();
                                                                        });
                                                                      },
                                                                      color: ColorConst.blueColor,
                                                                      text: StringUtils.yes,
                                                                      width: width / 2.5,
                                                                      height: 50,
                                                                    ),
                                                                    CommonButton(
                                                                      textStyleConst:
                                                                          TextStyleConst.mediumTextStyle(ColorConst.hintGreyColor, width * 0.05),
                                                                      onTap: () {
                                                                        Get.back();
                                                                      },
                                                                      color: ColorConst.borderGreyColor,
                                                                      text: StringUtils.no,
                                                                      width: width / 2.5,
                                                                      height: 50,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    );
                                                  },
                                                  backgroundColor: ColorConst.borderGreyColor,
                                                  foregroundColor: ColorConst.blackColor,
                                                  label: StringUtils.cancel,
                                                  lableColor: ColorConst.hintGreyColor,
                                                ),
                                              ],
                                            ),
                                            endActionPane: ActionPane(
                                              extentRatio: 0.25,
                                              motion: const ScrollMotion(),
                                              children: [
                                                SlidableAction(
                                                  onPressed: (context) {
                                                    showDialog(
                                                      barrierDismissible: false,
                                                      context: context,
                                                      builder: (context) {
                                                        return Center(
                                                          child: Container(
                                                            height: height / 2.7,
                                                            width: width / 1.12,
                                                            decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.circular(15),
                                                              color: Colors.white,
                                                            ),
                                                            child: Column(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              children: [
                                                                Container(
                                                                  height: 60,
                                                                  width: 60,
                                                                  decoration: const BoxDecoration(
                                                                    image: DecorationImage(
                                                                      image: AssetImage(ImageUtils.deleteIcon),
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(height: height * 0.03),
                                                                Text(
                                                                  "Delete",
                                                                  style: TextStyleConst.boldTextStyle(
                                                                    ColorConst.blackColor,
                                                                    width * 0.05,
                                                                  ),
                                                                ),
                                                                SizedBox(height: height * 0.01),
                                                                Text(
                                                                  "Are you sure want to delete this\n appointment?",
                                                                  textAlign: TextAlign.center,
                                                                  style: TextStyleConst.mediumTextStyle(
                                                                    ColorConst.hintGreyColor,
                                                                    width * 0.042,
                                                                  ),
                                                                ),
                                                                SizedBox(height: height * 0.03),
                                                                Row(
                                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                  children: [
                                                                    CommonButton(
                                                                      textStyleConst: TextStyleConst.mediumTextStyle(
                                                                        ColorConst.whiteColor,
                                                                        width * 0.05,
                                                                      ),
                                                                      onTap: () {
                                                                        StringUtils.client
                                                                            .deleteAppointment("Bearer ${PreferenceUtils.getStringValue("token")}",
                                                                                filterAppointmentController.filterAppointmentModel!.data![index].id!)
                                                                            .then((value) {
                                                                          filterAppointmentController.deleteAppointmentModel = value;
                                                                          print(filterAppointmentController.deleteAppointmentModel!.message);

                                                                          if (filterAppointmentController.deleteAppointmentModel!.success == true) {
                                                                            switch (appointmentController.currentIndex.value) {
                                                                              case 0:
                                                                                filterAppointmentController.isApiCall.value = false;

                                                                                appointmentController.currentIndex.value = 0;
                                                                                StringUtils.client
                                                                                    .getPastAppointments(
                                                                                        "Bearer ${PreferenceUtils.getStringValue("token")}", "past")
                                                                                    .then((value) {
                                                                                  filterAppointmentController.filterAppointmentModel = value;
                                                                                  filterAppointmentController.isApiCall.value = true;
                                                                                }).onError((DioError error, stackTrace) {
                                                                                  CheckSocketException.checkSocketException(error);
                                                                                });
                                                                                break;
                                                                              case 1:
                                                                                print(index);
                                                                                filterAppointmentController.isApiCall.value = false;

                                                                                appointmentController.currentIndex.value = 1;
                                                                                StringUtils.client
                                                                                    .getPastAppointments(
                                                                                        "Bearer ${PreferenceUtils.getStringValue("token")}",
                                                                                        "pending")
                                                                                    .then((value) {
                                                                                  filterAppointmentController.filterAppointmentModel = value;
                                                                                  filterAppointmentController.isApiCall.value = true;
                                                                                }).onError((DioError error, stackTrace) {
                                                                                  CheckSocketException.checkSocketException(error);
                                                                                });
                                                                                break;

                                                                              case 3:
                                                                                filterAppointmentController.isApiCall.value = false;

                                                                                appointmentController.currentIndex.value = 3;
                                                                                StringUtils.client
                                                                                    .getPastAppointments(
                                                                                        "Bearer ${PreferenceUtils.getStringValue("token")}",
                                                                                        "completed")
                                                                                    .then((value) {
                                                                                  filterAppointmentController.filterAppointmentModel = value;
                                                                                  filterAppointmentController.isApiCall.value = true;
                                                                                }).onError((DioError error, stackTrace) {
                                                                                  CheckSocketException.checkSocketException(error);
                                                                                });
                                                                                break;
                                                                            }
                                                                          }

                                                                          Get.back();
                                                                        });
                                                                      },
                                                                      color: ColorConst.blueColor,
                                                                      text: StringUtils.delete,
                                                                      width: width / 2.5,
                                                                      height: 50,
                                                                    ),
                                                                    CommonButton(
                                                                      textStyleConst: TextStyleConst.mediumTextStyle(
                                                                        ColorConst.hintGreyColor,
                                                                        width * 0.05,
                                                                      ),
                                                                      onTap: () {
                                                                        Get.back();
                                                                      },
                                                                      color: ColorConst.borderGreyColor,
                                                                      text: StringUtils.cancel,
                                                                      width: width / 2.5,
                                                                      height: 50,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    );
                                                  },
                                                  backgroundColor: const Color(0xFFFCE5E5),
                                                  foregroundColor: ColorConst.redColor,
                                                  label: StringUtils.delete,
                                                  lableColor: ColorConst.redColor,
                                                ),
                                              ],
                                            ),
                                            child: ListTile(
                                              title: Text(
                                                filterAppointmentController.filterAppointmentModel!.data![index].doctor_name!,
                                                style: TextStyleConst.mediumTextStyle(
                                                  ColorConst.blackColor,
                                                  width * 0.045,
                                                ),
                                              ),
                                              subtitle: Row(
                                                children: [
                                                  Text(
                                                    "${filterAppointmentController.filterAppointmentModel!.data![index].doctor_department!} | ",
                                                    style: TextStyleConst.mediumTextStyle(
                                                      ColorConst.hintGreyColor,
                                                      width * 0.036,
                                                    ),
                                                  ),
                                                  Text(
                                                    "${filterAppointmentController.filterAppointmentModel!.data![index].appointment_time!} - ",
                                                    style: TextStyleConst.mediumTextStyle(
                                                      ColorConst.hintGreyColor,
                                                      width * 0.036,
                                                    ),
                                                  ),
                                                  Flexible(
                                                    child: Text(
                                                      filterAppointmentController.filterAppointmentModel!.data![index].appointment_date!,
                                                      style: TextStyleConst.mediumTextStyle(
                                                        ColorConst.hintGreyColor,
                                                        width * 0.036,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              leading: Container(
                                                height: 60,
                                                width: 60,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(
                                                        filterAppointmentController.filterAppointmentModel!.data![index].doctor_image_url!),
                                                  ),
                                                ),
                                                // child: CachedNetworkImage(
                                                //   imageUrl:
                                                //       appointmentModel!.data![index].doctor_image_url!,
                                                //   placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                                                //   errorWidget: (context, url, error) => const Icon(Icons.error),
                                                // ),
                                              ),
                                            ),
                                          )
                                        : Slidable(
                                            endActionPane: ActionPane(
                                              extentRatio: 0.25,
                                              motion: const ScrollMotion(),
                                              children: [
                                                SlidableAction(
                                                  onPressed: (context) {
                                                    showDialog(
                                                      barrierDismissible: false,
                                                      context: context,
                                                      builder: (context) {
                                                        return Center(
                                                          child: Container(
                                                            height: height / 2.7,
                                                            width: width / 1.12,
                                                            decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.circular(15),
                                                              color: Colors.white,
                                                            ),
                                                            child: Column(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              children: [
                                                                Container(
                                                                  height: 60,
                                                                  width: 60,
                                                                  decoration: const BoxDecoration(
                                                                    image: DecorationImage(
                                                                      image: AssetImage(ImageUtils.deleteIcon),
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(height: height * 0.03),
                                                                Text(
                                                                  "Delete",
                                                                  style: TextStyleConst.boldTextStyle(
                                                                    ColorConst.blackColor,
                                                                    width * 0.05,
                                                                  ),
                                                                ),
                                                                SizedBox(height: height * 0.01),
                                                                Text(
                                                                  "Are you sure want to delete this\n appointment?",
                                                                  textAlign: TextAlign.center,
                                                                  style: TextStyleConst.mediumTextStyle(
                                                                    ColorConst.hintGreyColor,
                                                                    width * 0.042,
                                                                  ),
                                                                ),
                                                                SizedBox(height: height * 0.03),
                                                                Row(
                                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                  children: [
                                                                    CommonButton(
                                                                      textStyleConst: TextStyleConst.mediumTextStyle(
                                                                        ColorConst.whiteColor,
                                                                        width * 0.05,
                                                                      ),
                                                                      onTap: () {
                                                                        StringUtils.client
                                                                            .deleteAppointment("Bearer ${PreferenceUtils.getStringValue("token")}",
                                                                                filterAppointmentController.filterAppointmentModel!.data![index].id!)
                                                                            .then((value) {
                                                                          filterAppointmentController.deleteAppointmentModel = value;
                                                                          print(filterAppointmentController.deleteAppointmentModel!.message);

                                                                          if (filterAppointmentController.deleteAppointmentModel!.success == true) {
                                                                            filterAppointmentController.isApiCall.value = false;

                                                                            appointmentController.currentIndex.value = 2;
                                                                            StringUtils.client
                                                                                .getPastAppointments(
                                                                                    "Bearer ${PreferenceUtils.getStringValue("token")}", "cancelled")
                                                                                .then((value) {
                                                                              filterAppointmentController.filterAppointmentModel = value;
                                                                              filterAppointmentController.isApiCall.value = true;
                                                                            }).onError((DioError error, stackTrace) {
                                                                              CheckSocketException.checkSocketException(error);
                                                                            });
                                                                          }

                                                                          Get.back();
                                                                        });
                                                                      },
                                                                      color: ColorConst.blueColor,
                                                                      text: StringUtils.delete,
                                                                      width: width / 2.5,
                                                                      height: 50,
                                                                    ),
                                                                    CommonButton(
                                                                      textStyleConst: TextStyleConst.mediumTextStyle(
                                                                        ColorConst.hintGreyColor,
                                                                        width * 0.05,
                                                                      ),
                                                                      onTap: () {
                                                                        Get.back();
                                                                      },
                                                                      color: ColorConst.borderGreyColor,
                                                                      text: StringUtils.cancel,
                                                                      width: width / 2.5,
                                                                      height: 50,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    );
                                                  },
                                                  backgroundColor: const Color(0xFFFCE5E5),
                                                  foregroundColor: Colors.white,
                                                  label: StringUtils.delete,
                                                  lableColor: Colors.red,
                                                ),
                                              ],
                                            ),
                                            child: ListTile(
                                              title: Text(
                                                filterAppointmentController.filterAppointmentModel!.data![index].doctor_name!,
                                                style: TextStyleConst.mediumTextStyle(
                                                  ColorConst.blackColor,
                                                  width * 0.045,
                                                ),
                                              ),
                                              subtitle: Row(
                                                children: [
                                                  Text(
                                                    "${filterAppointmentController.filterAppointmentModel!.data![index].doctor_department!} | ",
                                                    style: TextStyleConst.mediumTextStyle(
                                                      ColorConst.hintGreyColor,
                                                      width * 0.036,
                                                    ),
                                                  ),
                                                  Text(
                                                    "${filterAppointmentController.filterAppointmentModel!.data![index].appointment_time!} - ",
                                                    style: TextStyleConst.mediumTextStyle(
                                                      ColorConst.hintGreyColor,
                                                      width * 0.036,
                                                    ),
                                                  ),
                                                  Flexible(
                                                    child: Text(
                                                      filterAppointmentController.filterAppointmentModel!.data![index].appointment_date!,
                                                      style: TextStyleConst.mediumTextStyle(
                                                        ColorConst.hintGreyColor,
                                                        width * 0.036,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              leading: Container(
                                                height: 60,
                                                width: 60,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(
                                                        filterAppointmentController.filterAppointmentModel!.data![index].doctor_image_url!),
                                                  ),
                                                ),
                                                // child: CachedNetworkImage(
                                                //   imageUrl:
                                                //       appointmentModel!.data![index].doctor_image_url!,
                                                //   placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                                                //   errorWidget: (context, url, error) => const Icon(Icons.error),
                                                // ),
                                              ),
                                            ),
                                          ),
                                    SizedBox(height: height * 0.01),
                                  ],
                                );
                              },
                            ),
                          )
                        : Expanded(
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                "Appointment is empty",
                                style: TextStyleConst.mediumTextStyle(
                                  ColorConst.blackColor,
                                  width * 0.04,
                                ),
                              ),
                            ),
                          )
                    : const Expanded(
                        child: Align(
                          alignment: Alignment.center,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      ),
              )
            ],
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: GestureDetector(
                onTap: () {
                  Get.to(() => const NewAppointmentScreen(), transition: Transition.rightToLeft);
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
