import 'package:flutter/material.dart';
import 'package:infyhms_flutter/constant/color_const.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    // final width = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
          body: Column(
        children: [
          Expanded(
            child: Container(
              color: ColorConst.bgGreyColor,
            ),
          ),
          Container(
            height: height / 1.8,
            color: ColorConst.whiteColor,
          ),
        ],
      )),
    );
  }
}
