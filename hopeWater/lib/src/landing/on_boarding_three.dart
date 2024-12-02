import 'package:flutter/material.dart';
import 'package:hopewater/resources/resources.dart';
import 'package:hopewater/utilis/heights_width.dart';
import 'package:sizer/sizer.dart';

class OnBoardingThreeView extends StatefulWidget {
  static String route = "/onboardingthree";
  const OnBoardingThreeView({super.key});

  @override
  State<OnBoardingThreeView> createState() => _OnBoardingThreeViewState();
}

class _OnBoardingThreeViewState extends State<OnBoardingThreeView> {
  PageController controller = PageController();
  bool onlastpage = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          h5,
          Image.asset(
            R.images.delivery,
            height: 50.h,
          ),
          h3,
          Text(
            'Fast and responsibily \ndelivery ',
            textAlign: TextAlign.center,
            style: R.textStyle.googleFontsPoppins(
                size: 20.sp,
                weight: FontWeight.bold,
                color: R.colors.secondaryTextColor),
          ),
          h5,
          Text(
            "Count on us for quick and responsible delivery, ensuring your water arrives on time and in perfect condition.",
            textAlign: TextAlign.center,
            style: R.textStyle.googleFontsPoppins(
                size: 10.sp,
                weight: FontWeight.w400,
                color: R.colors.secondaryTextColor),
          ),
          h5,
        ],
      ),
    );
  }
}
