import 'package:customer_app/screen/product/product_screen.dart';
import 'package:customer_app/widget/devider/custom_dot_line.dart';
import 'package:flutter/material.dart';
import 'package:get_all_pkg/get_all_pkg.dart';

class ProductInfoColumn extends StatelessWidget {
  final String productName, rate, description;
  const ProductInfoColumn({
    super.key,
    required this.productName,
    required this.rate,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              productName,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
            ),
            const Spacer(),
            Text(
              '$rate/5',
              style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: Color(0xffFFE500)),
            ),
            const Icon(Icons.star_rate_rounded, color: Color(0xffFFE500)),
          ],
        ),
        SizedBox(
          height: 1.h,
        ),
        CustomDotLine(),
        SizedBox(
          height: 1.h,
        ),
        Text(
          description,
          style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Color(0x50000000),
              fontSize: 16.sp),
        ),
      ],
    );
  }
}
