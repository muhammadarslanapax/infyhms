import 'package:flutter/material.dart';
import 'package:infyhms_flutter/constant/color_const.dart';
import 'package:infyhms_flutter/constant/text_style_const.dart';

class VaccinationScreen extends StatelessWidget {
  const VaccinationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      color: Colors.white,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: 20,
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
                  "Covaxin - 1st Dose",
                  style: TextStyleConst.mediumTextStyle(
                    ColorConst.blackColor,
                    width * 0.045,
                  ),
                ),
                SizedBox(height: height * 0.004),
                RichText(
                  text: TextSpan(
                    text: "N/A ",
                    style: TextStyleConst.mediumTextStyle(
                      Colors.green,
                      width * 0.037,
                    ),
                    children: [
                      TextSpan(
                        text: "08:03 PM - 2nd Mar, 2022",
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
    );
  }
}
