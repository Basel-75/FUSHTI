import 'package:flutter/material.dart';
import 'package:get_all_pkg/get_all_pkg.dart';

class EmpTitleName extends StatelessWidget {
  const EmpTitleName({
    super.key,
    required this.schoolName,
    this.textSize,
    this.paddingRight,
    this.paddingTop,
  });
  final String schoolName;
  final double? textSize;
  final double? paddingRight;
  final double? paddingTop;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(right: paddingRight ?? 4.h, top: paddingTop ?? 0.h),
      child: Align(
        alignment: Alignment.centerRight,
        child: Text(
          schoolName,
          style: TextStyle(
              fontSize: textSize ?? 17.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xff546F66)),
        ),
      ),
    );
  }
}
