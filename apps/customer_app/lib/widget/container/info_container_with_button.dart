import 'package:customer_app/widget/container/profile_small_container.dart';
import 'package:flutter/material.dart';
import 'package:get_all_pkg/get_all_pkg.dart';

class InfoContainerWithButton extends StatelessWidget {
  final String title, amount;
  final Color? smallContainerColor;
  final void Function() onPressedInfo;
  const InfoContainerWithButton({
    super.key,
    required this.title,
    required this.amount,
    this.smallContainerColor,
    required this.onPressedInfo,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.w),
      margin: EdgeInsets.symmetric(horizontal: 3.w),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(11),
          boxShadow: kElevationToShadow[4],
          border: Border.all(width: 0.2, color: Colors.grey)),
      child: Row(
        children: [
          Text(
            title,
            style:  TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500),
          ),
          IconButton(
              onPressed: onPressedInfo,
              icon: const Icon(
                Icons.info_outline,
                color: const Color.fromARGB(255, 9, 85, 148),
              )),
          const Spacer(),
          ProfileSmallContainer(
            number: amount,
            backgroundColor: smallContainerColor ?? const Color(0xffc9adab),
          ),
        ],
      ),
    );
  }
}
