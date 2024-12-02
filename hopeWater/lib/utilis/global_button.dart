import 'package:flutter/material.dart';
import 'package:hopewater/resources/resources.dart';
import 'package:sizer/sizer.dart';

class GlobalButton extends StatelessWidget {
  final String title;
  final Color color;
  final VoidCallback onpress;
  final double? height;
  final Color? fontColor;
  final double? width;
  final Color? borderColor;
  final bool isLoading;
  const GlobalButton(
      {super.key,
      required this.title,
      required this.color,
      required this.onpress,
      this.height,
      this.fontColor,
      this.width,
      this.borderColor,
      this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onpress,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: borderColor ?? R.colors.primraryTextColor),
        ),
        child: Center(
          child: isLoading
              ? CircularProgressIndicator(
                  strokeWidth: 2,
                  color: R.colors.black,
                )
              : Text(
                  title,
                  style: R.textStyle.googleFontsPoppins(
                      weight: FontWeight.bold, size: 10.sp, color: fontColor),
                ),
        ),
      ),
    );
  }
}
