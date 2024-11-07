import 'package:flutter/material.dart';
import 'package:get_all_pkg/get_all_pkg.dart';

class BoxItemContainer extends StatelessWidget {
  final String itemName, imagePath;
  const BoxItemContainer({
    super.key,
    required this.itemName,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 23.w,
      height: 13.h,
      padding: EdgeInsets.symmetric(horizontal: 0.2.w),
      margin: EdgeInsets.symmetric(horizontal: 1.w, vertical: 1.w),
      constraints: BoxConstraints(minHeight: 13.h),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xffFFFFFF), Color(0xffE0D1BB)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
        boxShadow: kElevationToShadow[4],
      ),
      child: Column(
        children: [
          const Spacer(),
          Image.asset(
            imagePath,
          ),
          Text(
            itemName,
            style: TextStyle(fontSize: 16.sp, overflow: TextOverflow.ellipsis),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
