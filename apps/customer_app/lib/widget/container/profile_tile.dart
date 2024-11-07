import 'package:flutter/material.dart';
import 'package:get_all_pkg/get_all_pkg.dart';

class ProfileTile extends StatelessWidget {
  final Color? backgroundColor;
  final Icon? icon;
  final String title;
  final Function()? onTap;
  final bool forLogout;
  const ProfileTile({
    super.key,
    this.onTap,
    required this.title,
    this.backgroundColor,
    this.icon,
    required this.forLogout,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 85.w,
        margin: EdgeInsets.only(top: 3.h),
        padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
        decoration: BoxDecoration(
            color: backgroundColor ?? const Color(0xffF2F2F2),
            boxShadow: forLogout ? null : kElevationToShadow[2],
            borderRadius: BorderRadius.circular(8)),
        child: Row(
          children: [
            Text(
              title,
              style: TextStyle(
                  fontSize: 16.sp,
                  color: forLogout ? Colors.grey : const Color(0xff546F66)),
            ),
            const Spacer(),
            icon ??
                const Icon(
                  Icons.add,
                  color: Color(0xff545454),
                )
          ],
        ),
      ),
    );
  }
}
