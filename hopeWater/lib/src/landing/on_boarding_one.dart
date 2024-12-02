import 'package:flutter/material.dart';
import 'package:hopewater/utilis/heights_width.dart';
import 'package:sizer/sizer.dart';

import '../../resources/resources.dart';

class OnBoardingOneView extends StatefulWidget {
  static String route = '/onBoardingScreenOne';
  const OnBoardingOneView({super.key});

  @override
  State<OnBoardingOneView> createState() => _OnBoardingOneViewState();
}

class _OnBoardingOneViewState extends State<OnBoardingOneView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          h5,
          Image.asset(
            R.images.drinkingWater,
            height: 50.h,
          ),
          h3,
          Text(
            'We provide best quality \nwater',
            textAlign: TextAlign.center,
            style: R.textStyle.googleFontsPoppins(
                size: 20.sp,
                weight: FontWeight.bold,
                color: R.colors.secondaryTextColor),
          ),
          h5,
          Text(
            'Experience pure, refreshing water with our top-notch quality standards. Stay hydrated, stay healthy',
            textAlign: TextAlign.center,
            style: R.textStyle.googleFontsPoppins(
                size: 10.sp,
                weight: FontWeight.w400,
                color: R.colors.secondaryTextColor),
          ),
        ],
      ),
    );
  }
}
