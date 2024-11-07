import 'package:customer_app/widget/devider/custom_dot_line.dart';
import 'package:flutter/material.dart';
import 'package:get_all_pkg/get_all_pkg.dart';

class ProductInfoColumn extends StatelessWidget {
  final String productName, description;
  const ProductInfoColumn({
    super.key,
    required this.productName,

    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          productName,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
        ),
        SizedBox(
          height: 1.h,
        ),
        const CustomDotLine(),
        SizedBox(
          height: 1.h,
        ),
        Text(
          description,
          style: TextStyle(
              fontWeight: FontWeight.w500,
              color: const Color(0x50000000),
              fontSize: 16.sp),
        ),
      ],
    );
  }
}
