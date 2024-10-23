import 'package:flutter/material.dart';
import 'package:get_all_pkg/get_all_pkg.dart';

class CustomButton extends StatelessWidget {
  final void Function() onPressed;
  final String title;
  final Size? fixedSize;
  final Color? backgroundColor;
  final double? fontsize;
  const CustomButton(
      {super.key,
      required this.onPressed,
      required this.title,
      this.fixedSize,
      this.backgroundColor,
      this.fontsize});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          fixedSize: fixedSize ?? Size(80.w, 0.5.h),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
      onPressed: onPressed,
      child: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: fontsize ?? 18,
        ),
      ),
    );
  }
}