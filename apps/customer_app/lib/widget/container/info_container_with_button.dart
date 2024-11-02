import 'package:customer_app/widget/container/product_small_container.dart';
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
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: Color(0xff546F66)),
        ),
        IconButton(
            onPressed: onPressedInfo,
            icon: const Icon(
              Icons.info_outline,
              color: const Color(0xffC8E5F5),
            )),
        const Spacer(),
        ProductSmallContainer(
          isForCal: false,
          amount: amount,
          isCallWithText: false,
          withAmountText: false,
          width: 15.w,
          height: 4.h,
          backgroundColor: Color(0xff56ECB0B0),
        ),

      ],
    );
  }
}
