import 'package:flutter/material.dart';

class AppDecoration {
  InputDecoration decoration(
      {Widget? suffixIcon,
      Widget? prefixIcon,
      required String hint,
      TextStyle? textStyle,
      required double radius,
      required Color fillcolor,
      required Color borderColor,
      bool? filled,
      TextInputAction? textInput}) {
    return InputDecoration(
      fillColor: fillcolor,
      suffixIcon: suffixIcon,
      prefixIcon: prefixIcon,
      contentPadding: const EdgeInsets.all(20),
      hintStyle: textStyle,
      hintText: hint,
      filled: filled,
      border: OutlineInputBorder(
        borderSide: BorderSide(color: borderColor),
        borderRadius: BorderRadius.all(Radius.circular(radius)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: borderColor),
        borderRadius: BorderRadius.all(Radius.circular(radius)),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: borderColor),
        borderRadius: BorderRadius.all(Radius.circular(radius)),
      ),
    );
  }
}
