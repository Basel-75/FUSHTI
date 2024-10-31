import 'package:flutter/material.dart';
import 'package:get_all_pkg/get_all_pkg.dart';

class ProfileSmallContainer extends StatelessWidget {
  final String? title;
  final String number;
  final Color? backgroundColor;
  final Function()? onTap;
  final EdgeInsetsGeometry? margin;
  const ProfileSmallContainer({
    super.key,
    this.title,
    required this.number,
    this.backgroundColor,
    this.onTap,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: margin,
        width: 30.w,
        height: 9.h,
        decoration: BoxDecoration(
            color: backgroundColor ?? const Color(0x54FDE1B9),
            borderRadius: BorderRadius.circular(11),
            //boxShadow: kElevationToShadow[4],
            border: Border.all(width: 0.2, color: Colors.grey)),
        child: title != null
            ? Column(
                children: [
                  Text(
                    title!,
                    style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xff546F66)),
                  ),
                  Text(
                    number,
                    style:
                        TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
                  ),
                ],
              )
            : Center(
                child: Text(
                  number,
                  style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xff546F66)),
                ),
              ),
      ),
    );
  }
}
