import 'package:customer_app/widget/button/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get_all_pkg/get_all_pkg.dart';

class PayPlanBottom extends StatelessWidget {
  final String totalPrice;
  final void Function() onPressed;
  const PayPlanBottom({
    super.key,
    required this.totalPrice,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.h),
      decoration: const BoxDecoration(
        color: Color(0x50C8E5F5),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'المجموع',
                style: TextStyle(fontSize: 16.sp),
              ),
              const Spacer(),
              Text(
                '$totalPrice رس',
                style: TextStyle(fontSize: 16.sp),
              ),
            ],
          ),
          SizedBox(
            height: 2.h,
          ),
          CustomButton(onPressed: onPressed, title: 'دفع'),
        ],
      ),
    );
  }
}
