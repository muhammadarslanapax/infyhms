import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infyhms_flutter/constant/color_const.dart';
import 'package:infyhms_flutter/constant/text_style_const.dart';
import 'package:infyhms_flutter/screens/diagnosis_test_detail_screen.dart';
import 'package:infyhms_flutter/utils/image_utils.dart';

class DiagnosisScreen extends StatelessWidget {
  const DiagnosisScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      color: Colors.white,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              Get.to(() => const DiagnosisTestDetailScreen(), transition: Transition.rightToLeft);
            },
            contentPadding: EdgeInsets.only(top: index == 0 ? 15 : 10, left: 15, right: 15),
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
            trailing: GestureDetector(
              onTap: () {},
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
              "Chintan Patel",
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
                  "Circulatory System",
                  style: TextStyleConst.mediumTextStyle(
                    ColorConst.hintGreyColor,
                    width * 0.035,
                  ),
                ),
                Text(
                  "K2TUWFVE  |  5th Jul,2022",
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
    );
  }
}
