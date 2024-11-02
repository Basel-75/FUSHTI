import 'package:flutter/material.dart';
import 'package:get_all_pkg/get_all_pkg.dart';

class ContentSlider extends StatelessWidget {
  const ContentSlider({
    super.key,
    this.sizeBoxHeight,
    required this.titleText,
    required this.subTitleText,
  });

  final double? sizeBoxHeight;
  final String titleText;
  final String subTitleText;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: sizeBoxHeight ?? 50.h,
          ),
          Text(
            titleText,
            style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 1.h,
          ),
          Text(
            subTitleText,
            textAlign: TextAlign.start,
            style: TextStyle(fontSize: 15.sp),
          ),
        ],
      ),
    );
  }
}