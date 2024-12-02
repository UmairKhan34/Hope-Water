import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hopewater/resources/resources.dart';
import 'package:hopewater/src/base/view/base_view.dart';
import 'package:hopewater/utilis/global_button.dart';
import 'package:hopewater/utilis/heights_width.dart';
import 'package:sizer/sizer.dart';

class OrderPlaced extends StatefulWidget {
  static String route = "/orderPlaced";
  const OrderPlaced({super.key});

  @override
  State<OrderPlaced> createState() => _OrderPlacedState();
}

class _OrderPlacedState extends State<OrderPlaced> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 5.w,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(R.images.congrats),
            h2,
            Text(
              "Your Order has been placed ",
              style: R.textStyle
                  .googleFontsPoppins(size: 16.sp, color: R.colors.black),
            ),
            h1,
            Text(
              "Our team will contact you",
              style: R.textStyle
                  .googleFontsPoppins(size: 10.sp, color: R.colors.black),
            ),
            h15,
            GlobalButton(
                height: 7.h,
                title: "Go Back to Home Screen",
                color: R.colors.splashColor,
                onpress: () {
                  Get.offAllNamed(BaseView.route);
                })
          ],
        ),
      ),
    );
  }
}
