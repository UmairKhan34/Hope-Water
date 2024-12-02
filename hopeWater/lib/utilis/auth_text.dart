// ignore_for_file: must_be_immutable

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hopewater/resources/resources.dart';
import 'package:sizer/sizer.dart';

class AuthText extends StatelessWidget {
  final String title;
  final String description;
  VoidCallback onpress;
  AuthText(
      {super.key,
      required this.title,
      required this.description,
      required this.onpress});

  @override
  Widget build(BuildContext context) {
    return Text.rich(TextSpan(children: [
      TextSpan(
        text: title,
        style: R.textStyle.googleFontsPoppins(
            color: R.colors.secondaryTextColor,
            size: 10.sp,
            weight: FontWeight.w400,
            decoration: TextDecoration.underline),
      ),
      TextSpan(
          recognizer: TapGestureRecognizer()..onTap = onpress,
          text: description,
          style: R.textStyle.googleFontsPoppins(
              weight: FontWeight.w400,
              color: R.colors.splashColor,
              size: 10.sp,
              decoration: TextDecoration.none))
    ]));
  }
}
