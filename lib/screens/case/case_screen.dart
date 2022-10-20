import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infyhms_flutter/constant/color_const.dart';
import 'package:infyhms_flutter/constant/text_style_const.dart';
import 'package:infyhms_flutter/screens/case/case_detail_screen.dart';

class CaseScreen extends StatelessWidget {
  const CaseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () {
            Get.to(() => const CaseDetailScreen(), transition: Transition.rightToLeft);
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
                "Active",
                style: TextStyleConst.mediumTextStyle(
                  ColorConst.greenColor,
                  width * 0.035,
                ),
              ),
              SizedBox(height: height * 0.004),
              Text(
                "ZT5XTTII  |  12:00 PM - 16th Sep, 2022",
                style: TextStyleConst.mediumTextStyle(
                  ColorConst.hintGreyColor,
                  width * 0.036,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
