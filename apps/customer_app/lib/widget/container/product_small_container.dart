import 'package:flutter/material.dart';
import 'package:get_all_pkg/get_all_pkg.dart';

class ProductSmallContainer extends StatelessWidget {
  final bool isForCal;
  final String amount;
  const ProductSmallContainer({
    super.key,
    required this.isForCal,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Color(0x70BA9773),
      ),
      child: isForCal
          ? Row(
              children: [
                Icon(
                  Icons.local_fire_department_sharp,
                  color: Color(0xffE4A951),
                ),
                Text(
                  ' $amount ',
                  style:
                      TextStyle(fontWeight: FontWeight.w300, fontSize: 16.sp),
                ),
                Text(
                  'سعرة',
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
