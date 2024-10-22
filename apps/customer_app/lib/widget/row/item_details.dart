import 'package:flutter/material.dart';
import 'package:get_all_pkg/get_all_pkg.dart';

class ItemDetails extends StatelessWidget {
  final String productName, quantity, price;
  const ItemDetails({
    super.key,
    required this.productName,
    required this.quantity,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.5.h),
      child: Row(
        children: [
          Text(
            productName,
            style: TextStyle(fontSize: 13.sp),
          ),
          const Spacer(),
          Text(
            '$quantity X',
            textDirection: TextDirection.ltr,
            style: TextStyle(fontSize: 13.sp),
          ),
          SizedBox(
            width: 5.w,
          ),
          Text(
            '$price رس',
            style: TextStyle(fontSize: 13.sp),
          ),
        ],
      ),
    );
  }
}
