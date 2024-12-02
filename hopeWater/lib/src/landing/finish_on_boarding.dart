import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hopewater/resources/resources.dart';
import 'package:hopewater/src/landing/on_boarding_one.dart';
import 'package:hopewater/src/landing/on_boarding_two.dart';
import 'package:hopewater/src/landing/on_boarding_three.dart';
import 'package:hopewater/src/landing/welcome_screen.dart';
import 'package:hopewater/utilis/global_button.dart';
import 'package:hopewater/utilis/heights_width.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class FinishOnBoardingScreen extends StatefulWidget {
  static String route = "/onfinishonBoarding";
  const FinishOnBoardingScreen({super.key});

  @override
  State<FinishOnBoardingScreen> createState() => _FinishOnBoardingScreenState();
}

class _FinishOnBoardingScreenState extends State<FinishOnBoardingScreen> {
  PageController controller = PageController();
  bool onlastpage = false;
  int currentindex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        PageView(
          controller: controller,
          onPageChanged: (index) {
            setState(() {
              onlastpage = (index == 2);
            });
            index++;
            currentindex = index;
          },
          children: const [
            OnBoardingOneView(),
            OnBoardingTwoView(),
            OnBoardingThreeView()
          ],
        ),
        Container(
            alignment: const Alignment(0, 0.75),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Padding(
                padding: EdgeInsets.only(top: 79.h),
                child: SmoothPageIndicator(
                  controller: controller,
                  count: 3,
                  effect: SlideEffect(
                    activeDotColor: R.colors.splashColor,
                    dotHeight: 10,
                    dotWidth: 10,
                  ),
                ),
              ),
              h3,
              onlastpage
                  ? GlobalButton(
                      fontColor: R.colors.primraryTextColor,
                      height: 7.h,
                      width: 80.w,
                      title: 'Get Started',
                      color: R.colors.splashColor,
                      onpress: () async {
                        final prefs = await SharedPreferences.getInstance();
                        await prefs.setBool('onboardingCompleted', true);
                        Get.offAllNamed(WelcomeScreen.route);
                      })
                  : GlobalButton(
                      fontColor: R.colors.primraryTextColor,
                      height: 7.h,
                      width: 80.w,
                      title: 'Next',
                      color: R.colors.splashColor,
                      onpress: () {
                        controller.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut);
                      },
                    )
            ]))
      ]),
    );
  }
}
