import 'package:flutter/material.dart';
import 'package:get_all_pkg/get_all_pkg.dart';

class CalRow extends StatelessWidget {
  final String totalCal;
  const CalRow({
    super.key,
    required this.totalCal,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'عدد السعرات',
          style: TextStyle(fontSize: 13.sp),
        ),
        Spacer(),
        Text(
          '$totalCal سعرة',
          style: TextStyle(fontSize: 13.sp),
        ),
        Icon(
          Icons.local_fire_department,
          color: Color(0xffE4A951),
        )
      ],
    );
  }
}
