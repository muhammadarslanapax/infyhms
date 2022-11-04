import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infyhms_flutter/controller/intro_controller/splash_controller.dart';
import 'package:infyhms_flutter/utils/image_utils.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key}) : super(key: key);
  final SplashController splashController = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Container(
            height: 100,
            width: 100,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(ImageUtils.splashLogo),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
