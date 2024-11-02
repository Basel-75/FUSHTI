import 'package:flutter/material.dart';
import 'package:get_all_pkg/get_all_pkg.dart';

class ContainerFunds extends StatelessWidget {
  final String label;
  final String amount;
  final Color? backgroundColor;
  const ContainerFunds(
      {super.key,
      required this.label,
      required this.amount,
      this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16),
        ),
        SizedBox(height: 1.h),
        Container(
          width: 30.w,
          height: 5.h,
          decoration: BoxDecoration(
            color: backgroundColor ?? Colors.white,
            borderRadius: BorderRadius.circular(8),
            // boxShadow: [
            //   BoxShadow(
            //     color: Colors.grey.withOpacity(0.2),
            //     spreadRadius: 1,
            //     blurRadius: 5,
            //     offset: const Offset(0, 3),
            //   ),
            // ],
          ),
          child: Center(
            child: Text(
              '$amount',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}
