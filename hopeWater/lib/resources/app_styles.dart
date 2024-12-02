import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hopewater/resources/resources.dart';
import 'package:sizer/sizer.dart';

class AppTextStyle {
  TextStyle googleFontRubik(
      FontWeight weight, double size, TextDecoration decoration, Color? color) {
    return GoogleFonts.rubik(
        fontSize: size,
        decoration: decoration,
        fontWeight: weight,
        color: color);
  }

  TextStyle googleFontsOleoScript(
      {FontWeight? weight,
      double? size,
      TextDecoration? decoration,
      Color? color}) {
    return GoogleFonts.oleoScript(
      fontWeight: weight ?? FontWeight.w400,
      fontSize: size ?? 16.sp,
      decoration: decoration ?? TextDecoration.none,
      color: color ?? R.colors.primraryTextColor,
    );
  }

  TextStyle googleFontsPoppins(
      {FontWeight? weight,
      double? size,
      TextDecoration? decoration,
      Color? color}) {
    return GoogleFonts.poppins(
      fontWeight: weight ?? FontWeight.w400,
      fontSize: size ?? 16.sp,
      decoration: decoration ?? TextDecoration.none,
      color: color ?? R.colors.primraryTextColor,
    );
  }
}
