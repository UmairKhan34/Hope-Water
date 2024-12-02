import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hopewater/resources/resources.dart';
import 'package:hopewater/src/auth/view/login_view.dart';
import 'package:hopewater/src/auth/view/sign_up_view.dart';
import 'package:hopewater/utilis/global_button.dart';
import 'package:hopewater/utilis/heights_width.dart';
import 'package:sizer/sizer.dart';

class WelcomeScreen extends StatefulWidget {
  static String route = "/welcomeScreen";
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                colorFilter: ColorFilter.mode(
                  R.colors.secondaryTextColor.withOpacity(.9),
                  BlendMode.modulate,
                ),
                image: AssetImage(
                  R.images.welcomebg,
                ),
                fit: BoxFit.cover)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            h50,
            h7,
            Text(
              'Welcome to Hope water',
              style: R.textStyle.googleFontsPoppins(
                  weight: FontWeight.bold,
                  color: R.colors.primraryTextColor,
                  size: 18.sp),
            ),
            Text(
              'Water Delivery app',
              style: R.textStyle.googleFontsPoppins(
                  weight: FontWeight.w400,
                  color: R.colors.primraryTextColor,
                  size: 12.sp),
            ),
            h5,
            GlobalButton(
              height: 7.h,
              width: 90.w,
              title: 'CREATE AN ACCOUNT',
              color: R.colors.primraryTextColor,
              onpress: () {
                Get.toNamed(SignUpViewScreen.route);
              },
              fontColor: R.colors.textColor,
            ),
            h3,
            GlobalButton(
                width: 90.w,
                height: 7.h,
                fontColor: R.colors.primraryTextColor,
                title: 'Login',
                color: R.colors.black,
                onpress: () {
                  Get.toNamed(LoginViewScreen.route);
                })
          ],
        ),
      ),
    );
  }
}
