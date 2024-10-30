import 'package:flutter/material.dart';
import 'package:get_all_pkg/get_all_pkg.dart';

class ContainerStatistics extends StatelessWidget {
  const ContainerStatistics({
    super.key,
    required this.statisticsName,
    required this.statisticsNumber,
    required this.statisticsIcon,
    this.statisticsNameTxtSize,
    this.statisticsNumberTxtSize,
    this.txtColor,
    required this.containerColor,
    this.containerWidth,
    this.containerHeight,
  });

  final String statisticsName;
  final int statisticsNumber;
  final Icon statisticsIcon;
  final double? statisticsNameTxtSize;
  final double? statisticsNumberTxtSize;
  final Color? txtColor;
  final Color containerColor;
  final double? containerWidth;
  final double? containerHeight;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: containerWidth ?? 30.w,
      height: containerHeight ?? 9.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: containerColor,
        border: Border.all(width: 0.2, color: Colors.black26),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              statisticsName,
              style: TextStyle(
                  fontSize: statisticsNameTxtSize ?? 16.sp,
                  color: txtColor ?? Colors.black),
            ),
            SizedBox(
              height: 1.5.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                statisticsIcon,
                Text(
                  '$statisticsNumber',
                  style: TextStyle(
                      color: txtColor,
                      fontSize: statisticsNumberTxtSize ?? 14.sp),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
