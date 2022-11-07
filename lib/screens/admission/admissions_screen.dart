import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infyhms_flutter/constant/color_const.dart';
import 'package:infyhms_flutter/constant/text_style_const.dart';
import 'package:infyhms_flutter/screens/admission/admission_detail_screen.dart';

class AdmissionScreen extends StatelessWidget {
  const AdmissionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      color: Colors.white,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return Column(
            children: [
              ListTile(
                contentPadding: EdgeInsets.only(top: index == 0 ? 15 : 10, left: 15, right: 15),
                onTap: () {
                  Get.to(() => const AdmissionDetailScreen(), transition: Transition.rightToLeft);
                },
                title: Padding(
                  padding: const EdgeInsets.only(bottom: 3),
                  child: Text(
                    "Jenil Shah",
                    style: TextStyleConst.mediumTextStyle(
                      ColorConst.blackColor,
                      width * 0.045,
                    ),
                  ),
                ),
                subtitle: Text(
                  "WKY3GF0F  |  12:00 AM - 9th Jun, 2022",
                  style: TextStyleConst.mediumTextStyle(
                    ColorConst.hintGreyColor,
                    width * 0.037,
                  ),
                ),
                leading: Container(
                  height: 60,
                  width: 60,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQQ-YIPLhIBLVQKh_S4BNo18b03Ct5P_iYFeBBjDCYx&s"),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
