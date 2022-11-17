import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infyhms_flutter/constant/color_const.dart';
import 'package:infyhms_flutter/controller/intro_controller/splash_controller.dart';
import 'package:infyhms_flutter/screens/auth/reset_password_screen.dart';
import 'package:infyhms_flutter/utils/image_utils.dart';
import 'package:infyhms_flutter/utils/string_utils.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    handleDynamicLinks();
  }

  final SplashController splashController = Get.put(SplashController());

  Future handleDynamicLinks() async {
    final PendingDynamicLinkData? data = await FirebaseDynamicLinks.instance.getInitialLink();
    _handleDeepLink(data);
    FirebaseDynamicLinks.instance.onLink.listen((event) {
      _handleDeepLink(event);
    });
  }

  void _handleDeepLink(PendingDynamicLinkData? data) {
    final Uri? deepLink = data?.link;
    if (deepLink != null) {
      StringUtils.token = deepLink.toString().split("/").last;
      Get.to(() => ResetPasswordScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConst.whiteColor,
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
