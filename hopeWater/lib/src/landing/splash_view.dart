import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hopewater/services/session_controller.dart';
import 'package:hopewater/src/landing/welcome_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hopewater/src/landing/finish_on_boarding.dart';
import 'package:hopewater/src/base/view/base_view.dart';
import 'package:hopewater/resources/resources.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sizer/sizer.dart';

class SplashView extends StatefulWidget {
  static String route = "/splashView";
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    _checkUserStatus();
  }

  void _checkUserStatus() async {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    final prefs = await SharedPreferences.getInstance();
    final bool isOnboardingCompleted =
        prefs.getBool('onboardingCompleted') ?? false;

    Future.delayed(const Duration(seconds: 2), () {
      if (user != null) {
        SessionController().userId = user.uid.toString();
        Get.offAllNamed(BaseView.route);
      } else if (isOnboardingCompleted) {
        Get.offAllNamed(WelcomeScreen.route);
      } else {
        Get.offAllNamed(FinishOnBoardingScreen.route);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: R.colors.splashColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            R.images.waterDrop,
            height: 30.h,
            width: 100.w,
          ),
          SizedBox(
            height: 3.h,
          ),
          Text('Hope Water',
              style: R.textStyle.googleFontsPoppins(
                  weight: FontWeight.bold,
                  size: 25.sp,
                  color: R.colors.primraryTextColor))
        ],
      ),
    );
  }
}
