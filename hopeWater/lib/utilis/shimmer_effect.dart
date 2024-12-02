import 'package:flutter/material.dart';
import 'package:hopewater/resources/resources.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  final double height;
  final double width;

  const ShimmerWidget.rectangular({
    required this.height,
    required this.width,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: R.colors.lightGray,
      highlightColor: R.colors.primraryTextColor,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(22)),
      ),
    );
  }
}
