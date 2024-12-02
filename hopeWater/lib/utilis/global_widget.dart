import 'package:flutter/material.dart';
import 'package:hopewater/resources/resources.dart';
import 'package:hopewater/utilis/heights_width.dart';
import 'package:sizer/sizer.dart';

class GlobalWidget extends StatefulWidget {
  final String title;
  final String description;
  final VoidCallback onpress;
  const GlobalWidget(
      {super.key,
      required this.title,
      required this.description,
      required this.onpress});

  @override
  State<GlobalWidget> createState() => _GlobalWidgetState();
}

class _GlobalWidgetState extends State<GlobalWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          h9,
          InkWell(
              onTap: widget.onpress,
              child: Image.asset(
                R.images.backButton,
                height: 3.h,
                width: 5.w,
              )),
          h2,
          Text(
            widget.title,
            style: R.textStyle.googleFontsPoppins(
                color: R.colors.splashColor,
                size: 17.sp,
                weight: FontWeight.bold),
          ),
          h2,
          Text(
            widget.description,
            style: R.textStyle.googleFontsPoppins(
                color: R.colors.secondaryTextColor,
                size: 10.sp,
                weight: FontWeight.w400),
          ),
          h1
        ],
      ),
    );
  }
}
