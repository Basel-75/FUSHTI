import 'package:customer_app/widget/history_widget/separator_divider.dart';
import 'package:customer_app/widget/history_widget/text_tow_direction.dart';
import 'package:flutter/material.dart';

class BottomHistoryInfo extends StatelessWidget {
  const BottomHistoryInfo({
    super.key,
    required this.totalPrice,
    required this.name,
  });
  final int totalPrice;
  final String name;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SeparatorDivider(
          color: Colors.black.withOpacity(0.60),
          height: 2,
        ),
        TextWithTowDirection(
          isRightClickable: false,
          onPressed: () {},
          leftText: 'السعر الكلي $totalPrice',
          leftTextColor: Colors.black,
          leftTextSize: 18,
          rightText: 'الاسم: $name',
          rightTextColor: Colors.black.withOpacity(0.40),
          rightTextSize: 18,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        ),
      ],
    );
  }
}