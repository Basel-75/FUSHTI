import 'package:flutter/material.dart';
import 'package:get_all_pkg/get_all_pkg.dart';

class PlanDateRow extends StatelessWidget {
  final String startDate, endDate;
  const PlanDateRow({
    super.key,
    required this.startDate,
    required this.endDate,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'تاريخ الخطة',
          style: TextStyle(fontSize: 13.sp),
        ),
        const Spacer(),
        Text(
          '  من $startDate  الى $endDate ',
          style: TextStyle(fontSize: 13.sp),
        ),
      ],
    );
  }
}
