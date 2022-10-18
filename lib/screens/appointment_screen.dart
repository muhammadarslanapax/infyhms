import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:infyhms_flutter/constant/color_const.dart';
import 'package:infyhms_flutter/constant/text_style_const.dart';
import 'package:infyhms_flutter/controller/appointment_controller.dart';
import 'package:infyhms_flutter/screens/new_appointment_screen.dart';
import 'package:infyhms_flutter/utils/string_utils.dart';

class AppointmentScreen extends StatelessWidget {
  AppointmentScreen({Key? key}) : super(key: key);
  final AppointmentController appointmentController = Get.put(AppointmentController());
  final List<Map<String, dynamic>> appointment = [
    {
      "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQQ-YIPLhIBLVQKh_S4BNo18b03Ct5P_iYFeBBjDCYx&s",
      "title": "Dr.Harsh rathod",
      "subTitle": "Code addict  |  10:00 AM - 9th Sep, 2022",
    },
    {
      "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQQ-YIPLhIBLVQKh_S4BNo18b03Ct5P_iYFeBBjDCYx&s",
      "title": "Dr.Harsh rathod",
      "subTitle": "Code addict  |  10:00 AM - 9th Sep, 2022",
    },
    {
      "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQQ-YIPLhIBLVQKh_S4BNo18b03Ct5P_iYFeBBjDCYx&s",
      "title": "Dr.Harsh rathod",
      "subTitle": "Code addict  |  10:00 AM - 9th Sep, 2022",
    },
    {
      "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQQ-YIPLhIBLVQKh_S4BNo18b03Ct5P_iYFeBBjDCYx&s",
      "title": "Dr.Harsh rathod",
      "subTitle": "Code addict  |  10:00 AM - 9th Sep, 2022",
    },
    {
      "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQQ-YIPLhIBLVQKh_S4BNo18b03Ct5P_iYFeBBjDCYx&s",
      "title": "Dr.Harsh rathod",
      "subTitle": "Code addict  |  10:00 AM - 9th Sep, 2022",
    },
    {
      "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQQ-YIPLhIBLVQKh_S4BNo18b03Ct5P_iYFeBBjDCYx&s",
      "title": "Dr.Harsh rathod",
      "subTitle": "Code addict  |  10:00 AM - 9th Sep, 2022",
    },
    {
      "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQQ-YIPLhIBLVQKh_S4BNo18b03Ct5P_iYFeBBjDCYx&s",
      "title": "Dr.Harsh rathod",
      "subTitle": "Code addict  |  10:00 AM - 9th Sep, 2022",
    },
    {
      "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQQ-YIPLhIBLVQKh_S4BNo18b03Ct5P_iYFeBBjDCYx&s",
      "title": "Dr.Harsh rathod",
      "subTitle": "Code addict  |  10:00 AM - 9th Sep, 2022",
    },
    {
      "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQQ-YIPLhIBLVQKh_S4BNo18b03Ct5P_iYFeBBjDCYx&s",
      "title": "Dr.Harsh rathod",
      "subTitle": "Code addict  |  10:00 AM - 9th Sep, 2022",
    },
    {
      "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQQ-YIPLhIBLVQKh_S4BNo18b03Ct5P_iYFeBBjDCYx&s",
      "title": "Dr.Harsh rathod",
      "subTitle": "Code addict  |  10:00 AM - 9th Sep, 2022",
    },
    {
      "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQQ-YIPLhIBLVQKh_S4BNo18b03Ct5P_iYFeBBjDCYx&s",
      "title": "Dr.Harsh rathod",
      "subTitle": "Code addict  |  10:00 AM - 9th Sep, 2022",
    },
    {
      "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQQ-YIPLhIBLVQKh_S4BNo18b03Ct5P_iYFeBBjDCYx&s",
      "title": "Dr.Harsh rathod",
      "subTitle": "Code addict  |  10:00 AM - 9th Sep, 2022",
    },
    {
      "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQQ-YIPLhIBLVQKh_S4BNo18b03Ct5P_iYFeBBjDCYx&s",
      "title": "Dr.Harsh rathod",
      "subTitle": "Code addict  |  10:00 AM - 9th Sep, 2022",
    },
    {
      "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQQ-YIPLhIBLVQKh_S4BNo18b03Ct5P_iYFeBBjDCYx&s",
      "title": "Dr.Harsh rathod",
      "subTitle": "Code addict  |  10:00 AM - 9th Sep, 2022",
    },
    {
      "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQQ-YIPLhIBLVQKh_S4BNo18b03Ct5P_iYFeBBjDCYx&s",
      "title": "Dr.Harsh rathod",
      "subTitle": "Code addict  |  10:00 AM - 9th Sep, 2022",
    },
    {
      "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQQ-YIPLhIBLVQKh_S4BNo18b03Ct5P_iYFeBBjDCYx&s",
      "title": "Dr.Harsh rathod",
      "subTitle": "Code addict  |  10:00 AM - 9th Sep, 2022",
    },
    {
      "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQQ-YIPLhIBLVQKh_S4BNo18b03Ct5P_iYFeBBjDCYx&s",
      "title": "Dr.Harsh rathod",
      "subTitle": "Code addict  |  10:00 AM - 9th Sep, 2022",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Column(
          children: [
            Container(
              height: 70,
              margin: EdgeInsets.only(top: height * 0.01, bottom: height * 0.015),
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
                          height: 50,
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
            Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: appointment.length,
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
                            appointment[index]["title"],
                            style: TextStyleConst.mediumTextStyle(
                              ColorConst.blackColor,
                              width * 0.045,
                            ),
                          ),
                          subtitle: Text(
                            appointment[index]["subTitle"],
                            style: TextStyleConst.mediumTextStyle(
                              ColorConst.hintGreyColor,
                              width * 0.04,
                            ),
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
                      SizedBox(height: height * 0.02),
                    ],
                  );
                },
              ),
            ),
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
    );
  }
}
