import 'package:flutter/material.dart';
import 'package:get_all_pkg/get_all_pkg.dart';

class ProductSmallContainer extends StatelessWidget {
  final bool isForCal;
  final bool isCallWithText;
  final String amount;
  const ProductSmallContainer({
    super.key,
    required this.isForCal,
    required this.amount,
    required this.isCallWithText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Color(0x56FBC983),
      ),
      child: isForCal
          ? Row(
              children: [
                Text(
                  ' $amount ',
                  style:
                      TextStyle(fontWeight: FontWeight.w300, fontSize: 16.sp),
                ),
                const Icon(
                  LineAwesome.fire_alt_solid,
                  color: Color(0xffEC8743),
                ),
                Text(
                  isCallWithText?'سعرة':'',
                  style:
                      TextStyle(fontWeight: FontWeight.w300, fontSize: 16.sp),
                ),
              ],
            )
          : Row(
              children: [
                Text(
                  ' $amount ',
                  style:
                      TextStyle(fontWeight: FontWeight.w300, fontSize: 16.sp),
                ),
                Text(
                  'رس',
                  style:
                      TextStyle(fontWeight: FontWeight.w300, fontSize: 16.sp),
                ),
              ],
            ),
    );
  }
}
