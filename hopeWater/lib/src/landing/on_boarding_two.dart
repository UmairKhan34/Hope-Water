import 'package:flutter/material.dart';
import 'package:hopewater/utilis/heights_width.dart';
import 'package:sizer/sizer.dart';

import '../../resources/resources.dart';

class OnBoardingTwoView extends StatefulWidget {
  static String route = '/onBoardingScreenTwo';
  const OnBoardingTwoView({super.key});

  @override
  State<OnBoardingTwoView> createState() => _OnBoardingTwoViewState();
}

class _OnBoardingTwoViewState extends State<OnBoardingTwoView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          h5,
          Image.asset(
            R.images.waterCart,
            height: 50.h,
          ),
          h3,
          Text(
            'Schedule when you want \nyour water delivered',
            textAlign: TextAlign.center,
            style: R.textStyle.googleFontsPoppins(
                size: 20.sp,
                weight: FontWeight.bold,
                color: R.colors.secondaryTextColor),
          ),
          h5,
          Text(
            "Pick delivery times that suit you best and always have fresh, high-quality water. It's easy and flexible.",
            textAlign: TextAlign.center,
            style: R.textStyle.googleFontsPoppins(
                size: 10.sp,
                weight: FontWeight.w400,
                color: R.colors.secondaryTextColor),
          ),
          h5
        ],
      ),
    );
  }
}
