import 'package:flutter/material.dart';
import 'package:infyhms_flutter/constant/color_const.dart';
import 'package:infyhms_flutter/constant/text_style_const.dart';

class NoticeBoardScreen extends StatelessWidget {
  const NoticeBoardScreen({Key? key}) : super(key: key);

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
              showModalBottomSheet(
                shape: const OutlineInputBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                ),
                context: context,
                builder: (context) {
                  return Container(
                    margin: const EdgeInsets.only(right: 25, top: 30, left: 25),
                    height: height / 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Care Tips for COVID-19",
                          style: TextStyleConst.boldTextStyle(
                            ColorConst.blackColor,
                            width * 0.045,
                          ),
                        ),
                        SizedBox(height: height * 0.01),
                        Text(
                          "Due to the second wave of the Coronavirus pandemic and continuing exceptional circumstances, the Trust Board have agreed that all policies which are currently within review date will have their review date further extended by six months",
                          style: TextStyleConst.mediumTextStyle(
                            ColorConst.hintGreyColor,
                            width * 0.04,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            contentPadding: const EdgeInsets.only(right: 15, left: 15),
            title: Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text(
                "Care Tips for COVID-19",
                style: TextStyleConst.mediumTextStyle(
                  ColorConst.blackColor,
                  width * 0.045,
                ),
              ),
            ),
            subtitle: Text(
              "9:43 AM - 7th Jul,2022",
              style: TextStyleConst.mediumTextStyle(
                ColorConst.hintGreyColor,
                width * 0.037,
              ),
            ),
          );
        },
      ),
    );
  }
}
